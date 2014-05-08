# Class: motd
#
# This module manages 'Message Of The Day'
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*motd_file*]
#     'Message Of The Day' file.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*supported*]
#     This is used so we can put the class in hiera on all ostypes
#     so we don't get an error message
#
#   [*use_hiera*]
#     Should we get the data from hiera or just use the default
#     motd file as defined in the template
#     Default: false
#
# Actions:
#   Manages 'Message Of The Day' content.
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'motd': }
#
# [Remember: No empty lines between comments and class definition]
class motd(
  $ensure    = 'present',
  $motd_file = $::motd::params::config_file,
  $supported = $::motd::params::supported,
  $use_hiera = 'true'
) inherits motd::params {

  if $supported == 'true' {

    motd::mapfile { "${motd_file}_on_${::hostname}":
      path => $motd_file,
    }

    concat::fragment { 'motd_header':
      ensure  => $ensure,
      target  => $motd_file,
      content => $motd::params::source,
      order   => '01',
    }

    if $::motd::use_hiera == 'true' {
      create_resources('motd::message', hiera_hash('motd_messages'))
    }

  }# end if supported

}# end class
