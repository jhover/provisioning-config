#!/usr/bin/env python
#
# Setup prog for Certify certificate management utility

import os
import sys
from distutils.core import setup

# ===========================================================
#           data files
# ===========================================================

cron_files = ['etc/cron.d/%s' %file for file in os.listdir('etc/cron.d') if os.path.isfile('etc/cron.d/%s' %file)]
hiera_files = ['etc/hiera/%s' %file for file in os.listdir('etc/hiera') if os.path.isfile('etc/hiera/%s' %file)]
puppet_files = ['etc/puppet/%s' %file for file in os.listdir('etc/puppet') if os.path.isfile('etc/puppet/%s' %file)]

# ===========================================================

setup(
    name="provisioning-config",
    version='0.9.4',
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
              'scripts/runpuppettwice',
              'scripts/mountdisks',
             ],
    data_files=[ ('/usr/share/doc/provisioning-config', 
                     ['README.txt', 
                     'misc/puppetlabs.repo',
                     'NOTES.txt', 
                     ],
                  ),
                  ('/etc/cron.d',
                   cron_files,                  
                  ),
                  ('/etc/hiera',
                   hiera_files,
                   ),
                ] + [('/%s' % ( x[0]), map(lambda y: x[0]+'/'+y, x[2])) for x in os.walk('etc/puppet/')],
)  # end setup()
