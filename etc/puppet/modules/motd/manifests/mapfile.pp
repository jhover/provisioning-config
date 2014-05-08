#
# Map the file to manage with concat module
#
define motd::mapfile(
  $path
){
  include concat::setup
  include motd::params

  if !defined(Concat[$path]){
    concat { $path:
      owner => $::motd::params::owner,
      group => $::motd::params::group,
      mode  => $::motd::params::mode,
    }
  }

}# end define
