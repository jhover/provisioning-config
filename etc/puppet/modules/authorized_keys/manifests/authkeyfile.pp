define authorized_keys::authkeyfile ($roles,$home='') {
  # This line allows default homedir based on $title variable.
  # If $home is empty, the default is used.
  $homedir = $home ? {'' => "/home/${title}", default => $home}

  file {
    "$homedir":
      ensure  => 'directory',
      owner   => $title,
      group   => $title,
      mode    => '0700';
    "${homedir}/.ssh":
      ensure  => 'directory',
      owner   => $title,
      group   => $title,
      mode    => '0700',
      require => File["$homedir"];
    "${homedir}/.ssh/authorized_keys":
      ensure  => present,
      owner   => $title,
      group   => $title,
      mode    => '0600',
      require => File["${homedir}/.ssh"],
      content => template('authorized_keys/authorized_keys.erb');
  }
}
