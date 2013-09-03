#!/usr/bin/env sh
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue 03 Sep 2013 16:06:44 CEST

# Routes configuration so minimal initialization is done for non-interactive
# shells and bells-and-whistles for interactive ones

if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
