# Debian 8 time sync system
# Implementation logic:
#  - Shutdown NTP
#  - Set NTP Enable - off
#  - Remove package NTP
#  - Upload timesyncd.conf -. /etc/timesyncd.conf
#  - Set subscription on /etc/timesyncd.conf change
#  - Set Enable Timesyncd
#  - Start Timesyncd Service

class profile::debb_timesyncd {
  $tsync_cfg = 'puppet:///modules/profile/timesyncd.conf'

  service { 'systemd-timesyncd':
    ensure => running,
    enable => true,
    subscribe => File['/etc/systemd/timesyncd.conf'],
  }
  service { 'ntp':
    ensure => stopped,
    enable => false,
    before => Service['systemd-timesyncd'],
  }
  package { 'ntp':
    ensure => 'absent',
    require => Service['ntp'],
    before => Service['systemd-timesyncd'],
  }
  file { '/etc/systemd/timesyncd.conf':
    ensure => file,
    source => $tsync_cfg,
    before => Service['systemd-timesyncd'],
    notify => Service['systemd-timesyncd'],
  }
}
