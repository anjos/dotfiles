#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue  3 Sep 16:48:07 2013 CEST

# If it is just a non-interactive shell, read the profile, otherwise, read
# bashrc.

if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
