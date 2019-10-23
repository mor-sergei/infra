class role::deb_build_server {
  if ($facts['is_virtual']){
    include profile::virtual_guest
  }
  include profile::fireeye_agent

  if ($facts['os']['family'] == 'Debian') {
    if ($facts['lsbdistcodename'] == 'jessie') {
    # Debian jessie spec
      notify { "${::lsbdistdescription} distribute": }
      include profile::deb8_bports
      
      class { 'profile::deb8_openjdk':
         java_version => '8',
         kit_type     => 'jdk',
      }
    }
    
    elsif ($facts['lsbdistcodename'] == 'stretch') {
    # Debian stretch spec
      notify { "${::lsbdistdescription} distribute": }
    }

    # Debian base packages
    include profile::deb_base

    # Debian configuration change
    include profile::debb_config

    # NTP Service for Debian
    include profile::debb_timesyncd

    # Python dev packages for Debian
    include profile::debb_pyd

    # Python 3 + packages for Debian
    include profile::debb_py3

    # Crontab jobs manager

     class { 'profile::debb_cron':
       condition  => 'present',
       command    => 'echo "Crontab test execution" > /tmp/cron_exec.log',
       job_hour   => '*/1',
       job_minute => '30',
    }

    # Protobuf-compiler needed to crosscompile armhf on amd64
    include profile::deb_protobuf_compiler
  }
}
