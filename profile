#!/usr/bin/env sh
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue 03 Sep 2013 15:55:27 CEST

# Non-interactive initialization file for sh-like shells, including bash

# Idiap environment
if [ -f /idiap/resource/software/initfiles/shrc ]; then
  source /idiap/resource/software/initfiles/shrc;
fi

# Adds my bin directory to the search list
if [ -d ~/bin ]; then
  export PATH=$HOME/bin:$PATH;
fi

# Useful environment variables for non-interactive shells
export GPGKEY="A2170D5D";

# Sets up the core dump limits - if I'm on my machine
if [ "$(/usr/sbin/custom-conf-getuser)" = "$USER" ]; then
  ulimit -c unlimited;
fi
