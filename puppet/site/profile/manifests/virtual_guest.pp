class profile::virtual_guest {
  if ($facts['is_virtual']) {
    if ($facts['osfamily'] == 'Debian') {
      if ($facts['productname'] == 'VMware Virtual Platform') {
        package { 'open-vm-tools':
        ensure => installed,
        }
      }
      if ($facts['productname'] == 'VirtualBox') {
        package { 'dkms':
        ensure => installed,
        }
      }
    }
  }
}
