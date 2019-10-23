class profile::deb_protobuf_compiler {
  package { 'protobuf-compiler':
    ensure => installed,
  }
}
