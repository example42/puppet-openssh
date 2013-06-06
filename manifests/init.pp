# = Class: openssh
#
# This is the main openssh class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, openssh class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $openssh_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, openssh main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $openssh_source
#
# [*source_dir*]
#   If defined, the whole openssh configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $openssh_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $openssh_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, openssh main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $openssh_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $openssh_options
#
# [*service_autorestart*]
#   Automatically restarts the openssh service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $openssh_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $openssh_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $openssh_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $openssh_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for openssh checks
#   Can be defined also by the (top scope) variables $openssh_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $openssh_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $openssh_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $openssh_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $openssh_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for openssh port(s)
#   Can be defined also by the (top scope) variables $openssh_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling openssh. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $openssh_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $openssh_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $openssh_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $openssh_audit_only
#   and $audit_only
#
# Default class params - As defined in openssh::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
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
#   The name of openssh arguments. Used by puppi and monitor.
#   Used only in case the openssh process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user openssh runs with. Used by puppi and monitor.
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
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $openssh_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $openssh_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include openssh"
# - Call openssh as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class openssh (
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $exchange_hostkeys   = params_lookup( 'exchange_hostkeys' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits openssh::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $openssh::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $require_package = $openssh::package ? {
    ''      => undef,
    default => Package['openssh'],
  }

  $manage_service_enable = $openssh::bool_disableboot ? {
    true    => false,
    default => $openssh::bool_disable ? {
      true    => false,
      default => $openssh::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $openssh::bool_disable ? {
    true    => 'stopped',
    default =>  $openssh::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $openssh::bool_service_autorestart ? {
    true    => 'Service[openssh]',
    false   => undef,
  }

  $manage_file = $openssh::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $openssh::bool_absent == true or $openssh::bool_disable == true or $openssh::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $openssh::bool_absent == true or $openssh::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $openssh::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $openssh::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $openssh::source ? {
    ''        => undef,
    default   => $openssh::source,
  }

  $manage_file_content = $openssh::template ? {
    ''        => undef,
    default   => template($openssh::template),
  }

  ### Managed resources
  if $openssh::package {
    package { 'openssh':
      ensure => $openssh::manage_package,
      name   => $openssh::package,
    }
  }

  service { 'openssh':
    ensure     => $openssh::manage_service_ensure,
    name       => $openssh::service,
    enable     => $openssh::manage_service_enable,
    hasstatus  => $openssh::service_status,
    pattern    => $openssh::process,
    require    => $require_package,
  }

  file { 'openssh.conf':
    ensure  => $openssh::manage_file,
    path    => $openssh::config_file,
    mode    => $openssh::config_file_mode,
    owner   => $openssh::config_file_owner,
    group   => $openssh::config_file_group,
    require => $require_package,
    notify  => $openssh::manage_service_autorestart,
    source  => $openssh::manage_file_source,
    content => $openssh::manage_file_content,
    replace => $openssh::manage_file_replace,
    audit   => $openssh::manage_audit,
  }

  # The whole openssh configuration directory can be recursively overriden
  if $openssh::source_dir {
    file { 'openssh.dir':
      ensure  => directory,
      path    => $openssh::config_dir,
      require => $require_package,
      notify  => $openssh::manage_service_autorestart,
      source  => $openssh::source_dir,
      recurse => true,
      purge   => $openssh::bool_source_dir_purge,
      replace => $openssh::manage_file_replace,
      audit   => $openssh::manage_audit,
    }
  }

  if $openssh::exchange_hostkeys {
    include openssh::hostkeys

    $ssh_key_fqdn = $port ? {
      22 => $::fqdn,
      default => "[${::fqdn}]:$port",
    }

    $ssh_key_address = $port ? {
      22 => $::ipaddress,
      default => "[${::ipaddress}]:$port",
    }

    @@sshkey { $ssh_key_fqdn:
      host_aliases => [ $ssh_key_address ],
      type         => 'ssh-rsa',
      key          => $::sshrsakey,
      tag          => [ "openssh::hostkeys" ];
    }

    $ssh_key_name = $port ? {
      22 => $::hostname,
      default => "[${::hostname}]:$port",
    }

    @@sshkey { $ssh_key_name:
      type => 'ssh-rsa',
      key  => $::sshrsakey,
      tag  => [ "openssh::hostkeys::${::domainname}" ];
    }

    # puppet creates this file with 0600, which is not very usable
    file { "${openssh::config_dir}/ssh_known_hosts":
      ensure  => present,
      owner   => root,
      mode    => '0644',
      require => $require_package;
    }

    resources { 'sshkey':
      purge => true;
    }
  }


  ### Include custom class if $my_class is set
  if $openssh::my_class {
    include $openssh::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $openssh::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'openssh':
      ensure    => $openssh::manage_file,
      variables => $classvars,
      helper    => $openssh::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $openssh::bool_monitor == true {
    monitor::port { "openssh_${openssh::protocol}_${openssh::port}":
      protocol => $openssh::protocol,
      port     => $openssh::port,
      target   => $openssh::monitor_target,
      tool     => $openssh::monitor_tool,
      enable   => $openssh::manage_monitor,
    }
    monitor::process { 'openssh_process':
      process  => $openssh::process,
      service  => $openssh::service,
      pidfile  => $openssh::pid_file,
      user     => $openssh::process_user,
      argument => $openssh::process_args,
      tool     => $openssh::monitor_tool,
      enable   => $openssh::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $openssh::bool_firewall == true {
    firewall { "openssh_${openssh::protocol}_${openssh::port}":
      source      => $openssh::firewall_src,
      destination => $openssh::firewall_dst,
      protocol    => $openssh::protocol,
      port        => $openssh::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $openssh::firewall_tool,
      enable      => $openssh::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $openssh::bool_debug == true {
    file { 'debug_openssh':
      ensure  => $openssh::manage_file,
      path    => "${settings::vardir}/debug-openssh",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
