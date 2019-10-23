class profile::deb8_bports {
  class { 'apt::backports':
    location => 'http://ftp.debian.org/debian',
    release  => 'jessie-backports',
    repos    => 'main',
	key      => {
      id     => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
      server => 'ftp.debian.org',
	},  
    pin      => 500,
  }
}