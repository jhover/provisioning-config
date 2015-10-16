# Debian specifix stuff
class nfs::server::ubuntu(
  $nfs_v4              = false,
  $nfs_v4_idmap_domain = undef,
  $mountd_port         = undef,
  $mountd_threads      = 1,
  $service_manage      = true,
) {

  if !defined(Class['nfs::client::ubuntu']) {
    class{ 'nfs::client::ubuntu':
      nfs_v4              => $nfs_v4,
      nfs_v4_idmap_domain => $nfs_v4_idmap_domain,
    }
  }

  if ($mountd_port != undef){
    shellvar { 'rpc-mount-options':
      ensure   => present,
      target   => '/etc/default/nfs-kernel-server',
      variable => 'RPCMOUNTDOPTS',
      value    => "--manage-gids --port ${mountd_port} --num-threads ${mountd_threads}",
    }

    if $service_manage {
      Shellvar['rpc-mount-options'] ~> Service['nfs-kernel-server']
    }
  }

  include nfs::server::ubuntu::install, nfs::server::ubuntu::service
}
