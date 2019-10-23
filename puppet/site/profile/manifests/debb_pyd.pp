class profile::debb_pyd {
  package { 'python-dev':
    ensure => installed,
  }->
  package { 'python3-dev':
    ensure => installed,
  }
}
