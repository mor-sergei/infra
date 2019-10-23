class role::deb9_test_server {
  if ($facts['is_virtual']){
    include profile::virtual_guest
  }
  include profile::fireeye_agent

  if ($facts['os']['family'] == 'Debian') {
    if ($facts['lsbdistcodename'] == 'stretch') {
      # Debian stretch spec
      notify { "${::lsbdistdescription} distribute": }

      # NTP Service for Debian
      include profile::debb_timesyncd
    }
  }
}
