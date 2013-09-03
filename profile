#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue  3 Sep 16:48:07 2013 CEST

# Initialization for **non-interactive** shells

# Global profile
if [ -e /etc/profile ]; then . /etc/profile; fi

# MacPorts installer addition: adding an appropriate PATH variable
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Sets up the core dump limits
ulimit -c unlimited;
