class nfs::client::ubuntu::install {

  package { 'rpcbind':
    ensure => installed,
  }

  package { ['nfs-common', 'nfs4-acl-tools']:
    ensure => installed,
  }

}
