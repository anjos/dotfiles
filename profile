#!/usr/bin/env bash
# Andre Anjos <andre.dos.anjos@gmail.com>
# Tue  3 Sep 16:48:07 2013 CEST

# Initialization for **non-interactive** shells

# Global profile: force reading since maybe using MacPorts bash
if [ -e /etc/profile ]; then . /etc/profile; fi
