#
# Parameters for different OS types
#
class motd::params {
  case $::osfamily {
    
    redhat, debian, suse: {
      $supported   = 'true'
      $config_file = '/etc/motd'
      $source      = template("${module_name}/motd.rhel.erb")
      $owner       = 'root'
      $group       = 'root'
      $mode        = '0644'
    }
    
    solaris, sunos: {
      $supported   = 'true'
      $config_file = '/etc/motd'
      $source      = template("${module_name}/motd.sol.erb")
      $owner       = 'root'
      $group       = 'root'
      $mode        = '0644'
    }

    aix: {
      $supported   = 'true'
      $config_file = '/etc/motd'
      $source      = template("${module_name}/motd.aix.erb")
      $owner       = 'root'
      $group       = 'system'
      $mode        = '0644'
    }

    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }

  }# end case

}# end class
