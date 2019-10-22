#!/usr/bin/env python

import shutil
import fileinput
import datetime
import argparse


def parse_arguments():
    """
    Parse script input arguments.
    :return: Object with parsed input arguments arguments.
    """
    arguments_parser = argparse.ArgumentParser()
    arguments_parser.add_argument('--kvm', help='Using KVM as VM provider', action="store_true")
    arguments_parser.add_argument('--virtualbox', help='Using KVM as VM provider', action="store_true")

    arguments = arguments_parser.parse_args()
    return arguments

def replacetmpl(file, setng, sprovider='virtualbox'):
    try:
        ovrFile='template/Vagrantfile'
        shutil.copy(file, ovrFile)
    except IOError:
        print("Error: File %s does not appear to exist." % ovrFile)

    for line in fileinput.input(ovrFile, inplace=True):
        line = line.replace('{{ Vprovider }}',sprovider)
        line = line.rstrip('\r\n')
        print(setng.get(line, line))

def logging(message, frm='info'):
    if frm == 'info':
        print('-- info: {} --'.format(message))
    elif frm == 'cfg':
        print('-- congig: {} --'.format(message))

def main():
    args = parse_arguments()

    if args.kvm:
        logging('KVM turned on', 'cfg')
        vm_provider = 'kvm'
    elif args.virtualbox:
        logging('VirtualBox turned on', 'cfg')
        vm_provider = 'virtualbox'
    else:
        logging('VirtualBox turned on', 'cfg')
        vm_provider = 'virtualbox'

    setng = {
        '#GENERATION#': '# Config generated: %s' % datetime.datetime.now(),
        '#VIMAGE#': 'BOX_IMAGE = debian/jessie64',
        '#VMEMORY#': 'MEMORY = 1024',
        '#VCPU#': 'CPU = 1',
        '#VCOUNT#': 'NODE_COUNT = 2',
        '#NETPR#': 'NET_PREF = 10.11.0',
        '#PROVIDER#': '    config.vm.provider "{{ Vprovider }}" do |v|'
    }

    templfile='template/Vagrantfile.tmpl'
    replacetmpl(templfile, setng, vm_provider)


if __name__ == '__main__':
    main()
