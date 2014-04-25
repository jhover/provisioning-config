class os ( $motd = 'Default MOTD message.' ) {
  file {
    "/etc/motd":
      ensure => file,
      content => $motd;
  }
}
