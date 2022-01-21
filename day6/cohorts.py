#!/usr/bin/python

import sys

cohorts = [0,0,0,0,0,0,0,0,0]
for fish in sys.argv[1].split(","):
    cohorts[int(fish)] += 1

print(cohorts)
