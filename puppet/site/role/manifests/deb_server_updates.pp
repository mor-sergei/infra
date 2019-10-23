class role::deb_server_updates {
  if ($facts['is_virtual']){
    include profile::virtual_guest
  }
  include profile::fireeye_agent
}
