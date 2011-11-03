# Class: openssh
#
# This is the main openssh class
#
#
# == Parameters
#
# Class specific parameters - Define openssh specific behaviour
#  
#
#
# Standard class parameters - Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations 
#   If defined, openssh class will automatically "include $my_class"
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, openssh main config file will have the parameter: source => $source
#
# [*template*]
#   Sets the path to the template to be used as content for main configuration file
#   If defined, openssh main config file will have: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*options*]
#   An hash of custom options that can be used in templates for arbitrary settings.
# 
# [*port*] 
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#
# [*protocol*] 
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#
# [*absent*] 
#   Set to 'true' to remove package(s) installed by module 
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by an external tool, like a cluster software
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module) you want to use for openssh
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module) you want to use for openssh
#
# [*firewall_src*]
#   Define which source address/net allow for firewalling openssh. Default: 0.0.0.0/0
#
# [*firewall_dst*]
#   Define which destination address/net use for firewalling openssh. Default: $ipaddress
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#
# 
# Default class params - As defined in openssh::params.
# Note that these variables are mostly defined and used in the module itself, overriding the default
# values might not affected all the involved components (ie: packages layout)
# Set and override them only if you know what you're doing.
#
# [*package*]
#   The name of openssh package 
# 
# [*service*]
#   The name of openssh service
#
# [*service_status*]
#   If the openssh service init script supports status argument
#
# [*process*]
#   The name of openssh process 
#
# [*process_args*]
#   The name of openssh arguments. Defined when the openssh process is generic (java, ruby...) 
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor 
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
#
# == Examples
# 
# See README
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class openssh (
  $my_class          = "",
  $source            = "",
  $template          = "",
  $options           = "",
  $port              = "22",
  $protocol          = "tcp",
  $absent            = false,
  $disable           = false,
  $disableboot       = false,
  $monitor           = false,
  $monitor_tool      = "",
  $puppi             = false,
  $firewall          = false,
  $firewall_tool     = "",
  $firewall_src      = "0.0.0.0/0",
  $firewall_dst      = "$ipaddress",
  $debug             = false,
  $package           = $openssh::params::package,   
  $service           = $openssh::params::service, 
  $service_status    = $openssh::params::service_status, 
  $process           = $openssh::params::process,
  $process_args      = $openssh::params::process_args,
  $config_dir        = $openssh::params::config_dir,
  $config_file       = $openssh::params::config_file,
  $config_file_mode  = $openssh::params::config_file_mode,
  $config_file_owner = $openssh::params::config_file_owner,
  $config_file_group = $openssh::params::config_file_group,
  $config_file_init  = $openssh::params::config_file_init,
  $pid_file          = $openssh::params::pid_file, 
  $data_dir          = $openssh::params::data_dir, 
  $log_dir           = $openssh::params::log_dir, 
  $log_file          = $openssh::params::log_file 
  ) inherits openssh::params {

  # This requires puppetlabs-stdlib
  # validate_bool($absent , $disable , $disableboot, $monitor , $puppi , $firewall , $debug)

  # Calculations of some variables used in the module
  $manage_package = $openssh::absent ? {
    true  => "absent",
    false => "present",
  }
 
  $manage_service_enable = $openssh::disableboot ? {
    true    => false,
    default => $openssh::disable ? {
      true  => false,
      default => $openssh::absent ? {
          true  => false,
          false => true,
      },
    },
  }

  $manage_service_ensure = $openssh::disable ? {
    true  => "stopped",
    default =>  $openssh::absent ? {
      true    => "stopped",
      default => "running",
    },
  }

  $manage_file = $openssh::absent ? {
    true    => "absent",
    default => "present",
  }

  $manage_monitor = $openssh::absent ? {
    true  => false ,
    default => $openssh::disable ? {
      true    => false,
      default => true,
    }
  }

  # Managed resources
  package { "openssh":
    name   => "${openssh::package}",
    ensure => "${openssh::manage_package}",
  }

  service { "openssh":
    name       => "${openssh::service}",
    ensure     => "${openssh::manage_service_ensure}",
    enable     => $openssh::manage_service_enable,
    hasstatus  => "${openssh::service_status}",
    pattern    => "${openssh::process}",
    require    => Package["openssh"],
    subscribe  => File["openssh.conf"],
  }

  file { "openssh.conf":
    path    => "${openssh::config_file}",
    mode    => "${openssh::config_file_mode}",
    owner   => "${openssh::config_file_owner}",
    group   => "${openssh::config_file_group}",
    ensure  => "${openssh::manage_file}",
    require => Package["openssh"],
    notify  => Service["openssh"],
    source  => $source ? {
      ''      => undef,
      default => $source,
    },
    content => $template ? {
      ''      => undef,
      default => template("$template"),
    },
  }


  # Include custom class if $my_class is set
  if $openssh::my_class {
    include $openssh::my_class
  } 


  # Provide puppi data, if enabled ( puppi => true )
  if $openssh::puppi == true { 
    file { "puppi_openssh":
      path    => "${settings::vardir}/puppi/openssh",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      ensure  => "${openssh::manage_file}",
#      require => Class["puppi"],         
      content => template("openssh/puppi.erb"),
    }
  }


  # Service monitoring, if enabled ( monitor => true )
  if $openssh::monitor == true { 

    monitor::port { "openssh_${openssh::protocol}_${openssh::port}": 
      protocol => "${openssh::protocol}",
      port     => "${openssh::port}",
      target   => "${openssh::params::monitor_target_real}",
      tool     => "${openssh::monitor_tool}",
      enable   => $openssh::manage_monitor,
    }
    monitor::process { "openssh_process":
      process  => "${openssh::process}",
      service  => "${openssh::service}",
      pidfile  => "${openssh::pidfile}",
      tool     => "${openssh::monitor_tool}",
      enable   => $openssh::manage_monitor,
    }
  }


  # Firewall management, if enabled ( firewall => true )
  if $openssh::firewall == true {  
    firewall { "openssh_${openssh::protocol}_${openssh::port}":
      source      => "${openssh::firewall_source}",
      destination => "${openssh::firewall_destination}",
      protocol    => "${openssh::protocol}",
      port        => "${openssh::port}",
      action      => "allow",
      direction   => "input",
      tool        => "${openssh::firewall_tool}",
    }
  }


  # Include debug class is debugging is enabled 
  if $openssh::debug == true {
    file { "debug_openssh":
      path    => "${settings::vardir}/debug-openssh",
      mode    => "0640",
      owner   => "root",
      group   => "root",
      ensure  => "$openssh::manage_file",
      content => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>"),
    }
  }

}
