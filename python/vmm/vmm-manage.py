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
    arguments_parser.add_argument('-i', '--img', required=True, action='store', dest='vm_image',
                    help='Vagrant VM image')
    arguments_parser.add_argument('-m', '--memory', required=True, action='store', dest='vm_memory',
                    help='VM box memory size')
    arguments_parser.add_argument('-c', '--cpu', required=True, action='store', dest='vm_cpu',
                        help='VM box CPU count')
    arguments_parser.add_argument('-n', '--node', required=True, action='store', dest='vm_node',
                        help='VM box nodes count')
    arguments_parser.add_argument('-p', '--netprefix', required=True, action='store', dest='vm_netprefix',
                        help='VM box network prefix ex: 10.10.0')

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
        '#VIMAGE#': 'BOX_IMAGE = \"%s\"' % args.vm_image,
        '#VMEMORY#': 'MEMORY = %s' % args.vm_memory,
        '#VCPU#': 'CPU = %s' % args.vm_cpu,
        '#VCOUNT#': 'NODE_COUNT = %s' % args.vm_node,
        '#NETPR#': 'NET_PREF = %s' % args.vm_netprefix,
    }

    templfile='template/Vagrantfile.tmpl'
    replacetmpl(templfile, setng, vm_provider)


if __name__ == '__main__':
    main()
