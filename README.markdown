# Puppet module: openssh

An open work in progress to define a new openssh template for Puppet modules

## USAGE - Basic management
* Install openssh with default settings

        class { "openssh": }

* Disable openssh service.

        class { "openssh":
          disable => true
        }

* Disable openssh service at boot time, but don't stop if is running.

        class { "openssh":
          disableboot => true
        }

* Remove openssh package

        class { "openssh":
          absent => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "openssh":
          source => [ "puppet:///modules/lab42/openssh/openssh.conf-$hostname" , "puppet:///modules/lab42/openssh/openssh.conf" ], 
        }

* Use custom template for main config file 

        class { "openssh":
          template => "example42/openssh/openssh.conf.erb",      
        }

* Define custom options that can be used in a custom template without the
  need to add parameters to the openssh class

        class { "openssh":
          template => "example42/openssh/openssh.conf.erb",    
          options  => {
            'LogLevel' => 'INFO',
            'UsePAM'   => 'yes',
          },
        }

* Automaticallly include a custom subclass

        class { "openssh:"
          my_class => 'lab42::openssh',
        }


## USAGE - Example42 extensions management 
* Activate puppi (reccomended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "openssh": 
          puppi    => true,
        }

* Activate automatic monitoring (reccomended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "openssh":
          monitor      => true,
          monitor_tool => [ "nagios" , "monit" , "munin" ],
        }

* Activate automatic firewalling 
  This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { "openssh":       
          firewall      => true,
          firewall_tool => "iptables",
          firewall_src  => "10.42.0.0/24",
          firewall_dst  => "$ipaddress_eth0",
        }


