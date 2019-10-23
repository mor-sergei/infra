class profile::debb_config {
  $conf_param = '"adduser adduser/homedir-permission boolean false"'
  exec { 'adduser':
    path    => '/bin:/usr/bin:/usr/sbin',
    command => "echo ${conf_param} | debconf-set-selections",
    user    => 'root',
  }
}