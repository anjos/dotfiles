# Created by Andre Anjos <andre.dos.anjos@cern.ch>
# Qui 26 Jul 2007 10:16:23 CEST
#
# This makefile maintains the symbolic links from the user home directory
# pointing to this directory. The mechanics of work is like this:
#
#   git clone <repo>/dotfiles <to-wherever-you-want>
#   cd <to-wherever-you-want>
#   make deepclean; make
#
# This should install all relevant symbolic links to the files in this
# directory. From this point on, you control the contents of your dotfiles from
# within this directory and your home directory will be updated accordingly
# when you do a "make" from here.

FILES=$(shell find `pwd` -maxdepth 1 -not -name '.*' -not -name '*~' -not -name 'Makefile' -not -name 'ssh' -not -name 'config' -not -name 'envs')
SSHFILES=$(shell find `pwd`/ssh -maxdepth 1 -not -name '.*' -not -name '*~' -type f)
GARBAGE=$(shell find `pwd` -name '*~')

all: deepclean ssh config
	@for f in $(FILES); do ln -s -v -f $$f $$HOME/.`basename $$f`; done

ssh:
	@for f in $(SSHFILES); do ln -s -v -f $$f $$HOME/.ssh/`basename $$f`; done

config:
	@if [ ! -d $$HOME/.config ]; then mkdir $$HOME/.config; fi
	@for k in $$PWD/config/*; do ln -s -v -f $$k $$HOME/.config/; done

.PHONY: clean all deepclean ssh config

clean:
	@rm -f -v $(GARBAGE)

deepclean: clean
	@for f in $(FILES); do rm -f -v $$HOME/.`basename $$f`; done
	@for f in $(SSHFILES); do rm -f -v $$HOME/.ssh/`basename $$f`; done
