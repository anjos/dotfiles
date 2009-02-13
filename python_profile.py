# Created by Andre Anjos <andre.dos.anjos@cern.ch>
# Qui 26 Jul 2007 11:04:58 CEST 

# This my user initilization file. To get it activated
# whenever you start python, just make sure the environment
# variable PYTHONSTARTUP is defined to point to this file

import atexit
import os
import readline
import rlcompleter

histfile = os.path.expanduser("~/.python_history")

if os.path.exists(histfile): readline.read_history_file(histfile)

atexit.register(readline.write_history_file, histfile)

# adds some extra keyboard functions I like
readline.parse_and_bind('tab: complete')
readline.parse_and_bind('bind ^I rl_complete')
readline.parse_and_bind('"\C-r": reverse-search-history')
readline.parse_and_bind('"\C-s": forward-search-history')

del os, atexit, readline, rlcompleter, histfile
