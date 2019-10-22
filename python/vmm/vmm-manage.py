#!/usr/bin/env python

import shutil
import fileinput
import datetime

def replacetmpl(file, setng, savefl=False):
    ovrFile="template/Vagrantfile"
    shutil.copy(file, ovrFile)
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

    templfile="template/Vagrantfile.tmpl"
    replacetmpl(templfile, setng)


if __name__ == '__main__':
    main()