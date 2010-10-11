""" User configuration file for IPython

This is a more flexible and safe way to configure ipython than *rc files
(ipythonrc, ipythonrc-pysh etc.)

This file is always imported on ipython startup. You can import the
ipython extensions you need here (see IPython/Extensions directory).

Feel free to edit this file to customize your ipython experience.

Note that as such this file does nothing, for backwards compatibility.
Consult e.g. file 'ipy_profile_sh.py' for an example of the things 
you can do here.

See http://ipython.scipy.org/moin/IpythonExtensionApi for detailed
description on what you could do here.
"""

# Most of your config files and extensions will probably start with this import
import IPython.ipapi
ip = IPython.ipapi.get()

# You probably want to uncomment this if you did %upgrade -nolegacy
# import ipy_defaults    

# Some stuff to help me
import time

def main():
    # Handy tab-completers for %cd, %run, import etc.
    # Try commenting this out if you have completion problems/slowness
    import ipy_stock_completers
    
    # uncomment if you want to get ipython -p sh behaviour
    # without having to use command line switches
    #import ipy_profile_sh

    
    o = ip.options
    # An example on how to set options
    #o.autocall = 1
    o.system_verbose = '0'

    # Prompt handling
    o.prompt_in1 = r'\C_Green[\C_Normal\h-${time.strftime("%H:%M")}\C_Green] \C_Normal\Y2 \C_Green>>>\C_Normal '
    o.separate_in = '0'
    o.prompts_pad_left = 0

    from IPython import Release
    import sys
    o.banner = "Py %sIPy %s\n" % (sys.version.split('\n')[0],Release.version)

    # make 'd' an alias for ls -F
    ip.magic('alias gls ls -F --color=auto')
    ip.magic('alias ll ls -lhrt')
    ip.magic('alias la ls -a')
    ip.magic('alias lla ll -a')
    ip.magic('alias grep grep --color')
    ip.magic('alias rm rm -vi')
    ip.magic('alias cp cp -vi')
    ip.magic('alias vim vim')
    ip.magic('alias gvim gvim')
    ip.magic('alias more less')
    ip.magic('alias tn less -N')
    ip.magic('alias dhps ssh andreps@ps9838.dreamhost.com')
    ip.magic('alias dh ssh andreanjos@pacer.dreamhost.com')
    ip.magic('alias casa ssh andre@orquidea.andreanjos.org')
    ip.magic('alias lx ssh rabello@lxplus.cern.ch')

    # Some quirks
    o.confirm_exit = 0
    o.editor = 'gvim'

    o.system_header = "IPy calls: "
    o.system_verbose = 0

main()
