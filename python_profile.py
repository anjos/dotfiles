#!/usr/bin/env python
# coding=utf-8
# Created by Andre Anjos <andre.anjos@idiap.ch>
# 2021-09-14

# This my user initilization file. To get it activated
# whenever you start python, just make sure the environment
# variable PYTHONSTARTUP is defined to point to this file

import atexit
import os
import readline
histfile = os.path.join(os.path.expanduser("~"), ".python_history")

try:
    readline.read_history_file(histfile)
    h_len = readline.get_current_history_length()
except FileNotFoundError:
    open(histfile, 'wb').close()
    h_len = 0

def save(prev_h_len, histfile):
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(1000)
    readline.append_history_file(new_h_len - prev_h_len, histfile)
atexit.register(save, h_len, histfile)
