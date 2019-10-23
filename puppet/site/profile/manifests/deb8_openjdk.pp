class profile::deb8_openjdk( $java_version = '8', $kit_type = 'jdk' ) {
  $pkg_name = "openjdk-${java_version}-${kit_type}"
  notify { "${pkg_name} Pkg selected": }
  package { $pkg_name:
    ensure => present,
    install_options => ['-t', 'jessie-backports'],
  }
}
