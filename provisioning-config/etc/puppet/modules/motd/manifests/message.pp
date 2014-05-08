#
# Add messages to the motd file
#
define motd::message(
  $message = $title,
  $ensure  = 'present',
  $order   = '100',
  $mapfile = undef
) {
  include motd::params

  if $mapfile != undef {
    $path = $mapfile
  } else {
    $path = $motd::params::config_file
  }

  concat::fragment { "motd_${title}":
    ensure  => $ensure,
    target  => $path,
    content => "${message}\n",
    order   => "${order}",
  }

}
