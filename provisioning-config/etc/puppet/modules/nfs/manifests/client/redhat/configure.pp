# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::redhat::configure {

  create_resources('nfs::client::mount',hiera_hash('nfs::client::mount'))

  if $nfs::client::redhat::nfs_v4 {
    augeas {
      '/etc/idmapd.conf':
        context => '/files/etc/idmapd.conf/General',
        lens    => 'Puppet.lns',
        incl    => '/etc/idmapd.conf',
        changes => ["set Domain ${nfs::client::redhat::nfs_v4_idmap_domain}"],
    }
  }
}
