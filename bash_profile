#!/usr/bin/env sh
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue 03 Sep 2013 16:06:44 CEST

# Understand how bashrc, bash_profile, profile and inputrc are used:
#
# 1. If you start bash from a graphical user interface, only bashrc will be
# sourced.
#
# 2. If you login using your computer login terminal (not the graphical login
# system) or through SSH, then only bash_profile will be executed. Normally, we
# setup bash_profile so that it executes the contents of profile and then
# bashrc, if the shell is supposed to be interactive.
#
# 3. The file inputrc is only read/executed by bash for interactive shells.

# Routes configuration so minimal initialization is done for non-interactive
# shells and bells-and-whistles for interactive ones

if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
