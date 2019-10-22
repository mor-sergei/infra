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
    arguments_parser.add_argument('-docpath', required=True, dest='docpath', metavar='destination_documentation_path',
                                  type=str, help='')

    arguments = arguments_parser.parse_args()
    return arguments

def replacetmpl(file, setng, savefl=False):
    try:
        ovrFile='template/Vagrantfile'
        shutil.copy(file, ovrFile)
    except IOError:
        print("Error: File %s does not appear to exist." % ovrFile)

    for line in fileinput.input(ovrFile, inplace=True):
        line = line.rstrip('\r\n')
        print(setng.get(line, line))


def main():
    setng = {
        '#GENERATION#': '# Config generated: %s' % datetime.datetime.now(),
        '#VIMAGE#': 'BOX_IMAGE = debian/jessie64',
        '#VMEMORY#': 'MEMORY = 1024',
        '#VCPU#': 'CPU = 1',
        '#VCOUNT#': 'NODE_COUNT = 2',
        '#NETPR#': 'NET_PREF = 10.11.0'
    }

    templfile='template/Vagrantfile.tmpl'
    replacetmpl(templfile, setng)


if __name__ == '__main__':
    main()
