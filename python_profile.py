# Created by Andre Anjos <andre.dos.anjos@cern.ch>
# Qui 26 Jul 2007 11:04:58 CEST

# This my user initilization file. To get it activated
# whenever you start python, just make sure the environment
# variable PYTHONSTARTUP is defined to point to this file

try:
  import readline
  import os, atexit
  histfile = os.environ['HOME'] + os.sep + '.python_history'
  if os.path.exists(histfile):
    readline.read_history_file(histfile)
  atexit.register(readline.write_history_file, histfile)
except ImportError:
  print("Module readline not available.")
else:
  import rlcompleter
  readline.parse_and_bind("tab: complete")
