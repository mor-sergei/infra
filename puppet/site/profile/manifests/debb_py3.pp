class profile::debb_py3 {
  $pip_lst = [ 'mysql-connector-python', 'pycodestyle', 'MarkupSafe' ]
  package { 'python3':
    ensure => installed,
  }
  package { 'python-pip':
    ensure   => installed,
    require  => [ Package['python3'], ],
  }
  ensure_packages( $pip_lst, {
    ensure   => present,
    provider => 'pip',
    require  => [ Package['python-pip'], Package['python3'], ],
  })
}
