#! /usr/bin/env python

"""Pretty-print a pickle from stdin."""

import sys
import pprint
import pickle

structure = pickle.load(sys.stdin)
pprint.pprint(structure)
