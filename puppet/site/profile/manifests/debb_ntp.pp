# Debian 7, 8 base ntp client service
# timesyncd.conf - local time client
# ntp - ntp sevice from ntp
# You could manage this services

class profile::debb_ntp {
  $ntp_cfg = 'puppet:///modules/profile/ntp.conf'
  $tsync_cfg = 'puppet:///modules/profile/timesyncd.conf'
  package { 'ntp':
    ensure => installed,
  }->
  file { '/etc/ntp.conf':
    ensure => file,
    source => $ntp_cfg,
    notify => Service['ntp'],
  }->
  file { '/etc/systemd/timesyncd.conf':
    ensure => file,
    source => $tsync_cfg,
    notify => Sevice['systemd-timesyncd'],
  }->
    service { 'systemd-timesyncd':
    ensure => running,
    enable => false,
    subscribe => File['/etc/systemd/timesyncd.conf'],
  }->
    service { 'ntp':
    ensure => running,
    enable => true,
    subscribe => File['/etc/ntp.conf'],
  }
}
