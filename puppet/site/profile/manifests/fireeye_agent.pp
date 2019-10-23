# FireEye-agent profile for all OS's

class profile::fireeye_agent {
  if ($facts['osfamily'] == 'Debian') {
    $inst_pkg = '/tmp/xagt_0.ubuntu16_amd64.deb'
    $inst_cfg = '/tmp/agent_config.json'
    $pkg_src = 'https://nodeinst.localntp.com/xagt/xagt_0.ubuntu16_amd64.deb'
    $cfg_src = 'https://nodeinst.localntp.com/xagt/agent_config.json'

    file { $inst_pkg:
      source   => $pkg_src,
      checksum => 'mtime',
      ensure   => 'present',
    }

    file { $inst_cfg:
      source   => $cfg_src,
      checksum => 'mtime',
      ensure   => 'present',
    }

    package { 'xagt':
      provider  => dpkg,
      ensure    => latest,
      source    => $inst_pkg,
      subscribe => File[$inst_pkg],
    }

    exec { 'config_update':
      command     => "xagt -i ${inst_cfg}",
      path        => [ '/opt/fireeye/bin/' ],
      notify      => Service['xagt.service'],
      subscribe   => File[$inst_cfg],
      refreshonly => true,
    }

    service { 'xagt.service':
      ensure  => running,
      enable  => true,
      require => Package['xagt'],
    }
  }
}
