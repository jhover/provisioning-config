#!/usr/bin/env python
#
# Setup prog for Certify certificate management utility

import sys
from distutils.core import setup

setup(
    name="provisioning-config",
    version='0.9.0',
    description='VM-based configuration resources.',
    long_description='''VM-based configuration resources.''',
    license='GPL',
    author='John Hover',
    author_email='jhover@bnl.gov',
    url='https://www.racf.bnl.gov/experiments/usatlas/griddev/',
    packages=[ 'provisioning',
              ],
    classifiers=[
          'Development Status :: 3 - Beta',
          'Environment :: Console',
          'Intended Audience :: System Administrators',
          'License :: OSI Approved :: GPL',
          'Operating System :: POSIX',
          'Programming Language :: Python',
          'Topic :: System Administration :: Management',
    ],
    scripts=[ 'scripts/runpuppet',
              'scripts/getuserdata'
             ],
    data_files=[ ('/etc/puppet/modules/', 
                     ['README.txt', 
                     'LGPL.txt', 
                     ] 
                  )
                ],
)  # end setup()

