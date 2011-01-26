#!/usr/bin/env python

###########################################################################
# Copyright (c) 2011 Minh Van Nguyen <nguyenminh2@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# http://www.gnu.org/licenses/
###########################################################################

# Managing copyright headers
#
# With each passing year, the copyright information of each file needs
# updating to reflect the current year. This script helps in automating the
# updating process.

from copy import copy
from datetime import date
import os
import sys

###################################
# helper functions
###################################

def is_blacklisted(f):
    """
    Determine whether the given file is blacklisted.

    INPUT:

    - f --- a file.

    OUTPUT:

    True if f is blacklisted; False otherwise.
    """
    if ".hg/" in f:
        return True
    if f.endswith(".hgignore"):
        return True
    if f.endswith(".hgtags"):
        return True
    if f.endswith(".jpg"):
        return True
    if f.endswith(".pdf"):
        return True
    if f.endswith(".png"):
        return True
    if f.endswith(".sty") and not f.endswith("mystyle.sty"):
        return True
    if f.endswith("bibliography.bst"):
        return True
    if f.endswith("bin/copyright.py"):
        return True
    if  f.endswith("LICENSE"):
        return True
    if f.endswith("style/tkz-arith.tex"):
        return True
    if f.endswith("TODO"):
        return True
    return False

def update_copyright(f):
    """
    Update copyright information of given file.

    INPUT:

    - f --- a regular file.

    OUTPUT:

    The copyright information of f updated.
    """
    output = ""
    year = str(date.today().year)
    infile = open(f, "r")
    has_copyright = False  # assume that f doesn't have copyright information
    for line in infile:
        if "Copyright (C)" in line and ", 2011 Minh Van Nguyen <nguyenminh2" in line:
            has_copyright = True
            # substring preceding "Minh Van Nguyen <nguyenminh2"
            s = line.split("Minh Van Nguyen <nguyenminh2")[0].strip()
            latest_year = s.split()[-1].strip()
            if latest_year == year:
                continue
            # substring following s
            t = line.split(s)[-1].strip()
            s = s + ", " + year
            s = s + " " + t
            output += s + "\n"
            continue
        output += line
    infile.close()
    ofile = open(f, "w")
    ofile.write(output)
    ofile.close()
    # alert to any file without copyright information
    if not has_copyright:
        print(f)
        sys.stdout.flush()

def usage():
    """
    Print the usage information for this script.
    """
    msg = "Usage: " + sys.argv[0] + " BOOK_ROOT\n"
    msg += "  BOOK_ROOT --- path to top-level directory of book project"
    print(msg)
    sys.stdout.flush()

##############################
# the script starts here
##############################

if __name__ == "__main__":
    # sanity checks
    if len(sys.argv) != 2:
        usage()
        sys.exit(1)
    if not os.path.exists(sys.argv[1]):
        usage()
        sys.exit(1)

    # traverse directory tree BOOK_ROOT and update copyright information
    BOOK_ROOT = sys.argv[1]
    os.chdir(BOOK_ROOT)
    blacklist = ()
    for root, _, files in os.walk(BOOK_ROOT):
        # ignore anything under .hg/
        if ".hg" in root:
            continue
        for f in files:
            p = os.path.join(root, f)
            if is_blacklisted(p):
                continue
            if os.path.isfile(p):
                update_copyright(p)
    # alert to any file whose copyright needs to be updated manually
    print("bin/copyright.py")
    sys.exit(0)
