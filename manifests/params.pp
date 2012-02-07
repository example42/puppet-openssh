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
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class openssh::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'openssh-server',
  }

  $service = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'ssh',
    default                   => 'sshd',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'sshd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'root',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/ssh',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/ssh/sshd_config',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/ssh',
    default                   => '/etc/sysconfig/sshd',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/sshd.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/ssh',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log',
  }

  $log_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/log/syslog',
    default                   => '/var/log/messages',
  }

  $port = $::openssh_port ? {
    ''      => '22',                    # Default value
    default => $::openssh_port,
  }

  $protocol = $::openssh_protocol ? {
    ''      => 'tcp',                   # Default value
    default => $::openssh_protocol,
  }


}
