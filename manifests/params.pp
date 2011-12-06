# Class: openssh::params
#
# This class defines default parameters used by the main module class openssh
# Operating Systems differences in names and paths are addressed here 
#
# == Variables
# 
# Refer to openssh class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It may be imported or inherited by other classes
#
class openssh::params {

  ## Application related parameters

  $package = $operatingsystem ? {
    default => "openssh-server",
  }

  $service = $operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => "ssh",
    default                   => "sshd",
  }

  $service_status = $operatingsystem ? {
    default => true,
  }

  $process = $operatingsystem ? {
    default => "openssh",
  }

  $process_args = $operatingsystem ? {
    default => "",
  }

  $config_dir = $operatingsystem ? {
    default => "/etc/ssh",
  }

  $config_file = $operatingsystem ? {
    default => "/etc/ssh/sshd_config",
  } 

  $config_file_mode = $operatingsystem ? { 
    default => "0600",
  }

  $config_file_owner = $operatingsystem ? {
    default => "root",
  }

  $config_file_group = $operatingsystem ? {
    default => "root",
  }

  $config_file_init = $operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => "/etc/default/ssh",
    default                   => "/etc/sysconfig/sshd",
  }
  
  $pid_file = $operatingsystem ? {
    default => "/var/run/sshd.pid",
  }

  $data_dir = $operatingsystem ? {
    default => "/etc/ssh",
  }

  $log_dir = $operatingsystem ? {
    default => "/var/log",
  }

  $log_file = $operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => "/var/log/syslog",
    default                   => "/var/log/messages",
  }

  $port = "22"

  $protocol = "tcp"


  ## General variables that affect module's behaviour
  ## They can be set at top scope level or in a ENC

  $my_class = $::openssh_my_class ? {
    ''      => "",                      # Default value
    default => $::openssh_my_class,
  }

  $source = $::openssh_source ? {
    ''      => "",                      # Default value
    default => $::openssh_source,
  }

  $source_dir = $::openssh_source_dir ? {
    ''      => "",                      # Default value
    default => $::openssh_source_dir,
  }

  $source_dir_purge = $::openssh_source_dir_purge ? {
    ''      => false,                   # Default value
    default => $::openssh_source_dir_purge,
  }

  $template = $::openssh_template ? {
    ''      => "",                      # Default value
    default => $::openssh_template,
  }

  $options = $::openssh_options ? {
    ''      => "",                      # Default value
    default => $::openssh_options,
  }

  $absent = $::openssh_absent ? {
    ''      => false,                   # Default value
    default => $::openssh_absent,
  }

  $disable = $::openssh_disable ? {
    ''      => false,                   # Default value
    default => $::openssh_disable,
  } 

  $disableboot = $::openssh_disableboot ? {
    ''      => false,                   # Default value
    default => $::openssh_disableboot,
  }


  ## General module variables that can have a site default
  ## or a per-module default. They can be set at top scope level or in a ENC

  $monitor = $::openssh_monitor ? {
    ''      => $::monitor ? {
      ''      => false,                # Default value
      default => $::monitor,
    },
    default => $::openssh_monitor,
  }

  $monitor_tool = $::openssh_monitor_tool ? {
    ''      => $::monitor_tool ? {
      ''      => "",                   # Default value
      default => $::monitor_tool,
    },
    default => $::openssh_monitor_tool,
  }

  $firewall = $::openssh_firewall ? {
    ''      => $::firewall ? {
      ''      => false,                # Default value
      default => $::firewall,
    },
    default => $::openssh_firewall,
  }

  $firewall_tool = $::openssh_firewall_tool ? {
    ''      => $::firewall_tool ? {
      ''      => "",                   # Default value
      default => $::firewall_tool,
    },
    default => $::openssh_firewall_tool,
  }

  $firewall_src = $::openssh_firewall_src ? {
    ''      => $::firewall_src ? {
      ''      => "0.0.0.0/0",          # Default value
      default => $::firewall_src,
    },
    default => $::openssh_firewall_src,
  }

  $firewall_dst = $::openssh_firewall_dst ? {
    ''      => $::firewall_dst ? {
      ''      => $ip_address,          # Default value
      default => $::firewall_dst,
    },
    default => $::openssh_firewall_dst,
  }

  $puppi = $::openssh_puppi ? {
    ''      => $::puppi ? {
      ''      => false,                # Default value
      default => $::puppi,
    },
    default => $::openssh_puppi,
  }  

  $puppi_helper = $::openssh_puppi_helper ? {
    ''      => $::puppi_helper ? {
      ''      => "standard",           # Default value
      default => $::puppi_helper,
    },
    default => $::openssh_puppi_helper,
  }

  $debug = $::openssh_debug ? {
    ''      => $::debug ? {
      ''      => false,                # Default value
      default => $::debug,
    },
    default => $::openssh_debug,
  }

  $audit_only = $::openssh_audit_only ? {
    ''      => $::audit_only ? {
      ''      => false,                # Default value
      default => $::audit_only,
    },
    default => $::openssh_audit_only,
  }

}
