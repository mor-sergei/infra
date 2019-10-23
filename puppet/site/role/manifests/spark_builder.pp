class role::spark_builder {
  include profile::fireeye_agent
  if ($facts['is_virtual']){
    include profile::virtual_guest
  }
  if ($facts['osfamily'] == 'Debian'){
    #include profile::debb_fireeye
    $packages = ['build-essential', 'python', 'diffstat', 'texinfo', 'gawk', 'chrpath', 'dos2unix', 'wget', 'unzip', 'socat', 'doxygen', 'gcc-multilib', 'g++-multilib', 'libssl-dev', 'flex', 'bison', 'autoconf', 'automake', 'bc']
    package { $packages: ensure => installed }
  }
}
