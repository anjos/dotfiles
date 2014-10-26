#!/usr/bin/env python
# vim: set fileencoding=utf-8 :
# Andre Anjos <andre.dos.anjos@gmail.com>
# Wed 17 Oct 19:07:14 2012 

"""Disables some warnings in ipython
"""

import warnings
warnings.filterwarnings('ignore', '.*Module readline was already.*',)
