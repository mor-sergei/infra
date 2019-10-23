class profile::debb_fireeye {
  include ::wget

  $inst_pkg = '/tmp/xagt_29.7.0-1.ubuntu16_amd64.deb'
  $inst_cfg = '/tmp/agent_config.json'
  $pkg_src = 'http://nodeinst.localntp.com/xagt/xagt_29.7.0-1.ubuntu16_amd64.deb'
  $cfg_src = 'http://nodeinst.localntp.com/xagt/agent_config.json'

  wget::fetch { $pkg_src:
    destination => $inst_pkg,
    timeout     => 15,
    verbose     => true,
    before      => Package['xagt']
  }

  wget::fetch { $cfg_src:
    destination => $inst_cfg,
    timeout     => 15,
    verbose     => true,
    notify      => Service['xagt.service'],
    before      => Package['xagt']
  }

  package { 'xagt':
    provider => dpkg,
    ensure   => installed,
    source   => $inst_pkg
  }->

  exec { 'config_update':
    command => "xagt -i ${inst_cfg}",
    path    => [ '/opt/fireeye/bin/' ],
    notify  => Service['xagt.service']
  }

  service { 'xagt.service':
    ensure => running,
    enable => true,
    subscribe => Exec['config_update']
  }
}
