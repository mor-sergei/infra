### Python 3 quick VM Environment creation scripts
* #### Short Review
This is a "_continiusly_" updateing python scrips project - created for demonstrate some of the best solution for "quick VM infrastructure creation". It's going to be more complicated and more functional furthe - from version to version. This set of scripts going to use Open Source software - so you could use it for your own targets and projects without any notification (Please check GitHub LICENSE).
* #### Ubuntu 18 KVM setup
Clean Minimal Latest Ubuntu Server amd64 base box for libvirt and virtualbox Vagrant providers.

    > # Ubuntu
    > apt install -y libvirt-bin vagrant-libvirt
    
* #### Getting started
Install and connect to the box:

    > mkdir ubuntu-18.04-server-amd64
    > cd ubuntu-18.04-server-amd64
    > vagrant init peru/ubuntu-18.04-server-amd64
    > VAGRANT_DEFAULT_PROVIDER=libvirt vagrant up
    > # or
    > VAGRANT_DEFAULT_PROVIDER=virtualbox vagrant up
    > vagrant ssh
    
(root password is not set)
* Username: __vagrant__
* Password: __vagrant__


##### __Links__
'<https://app.vagrantup.com/peru/boxes/ubuntu-18.04-server-amd64>' All details.  
'<https://github.com/vagrant-libvirt/vagrant-libvirt>' Vagrant Libvirt Provider - details.  
'<https://en.wikibooks.org/wiki/QEMU/Installing_QEMU>' Good to know before start.  
