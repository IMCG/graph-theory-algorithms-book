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
    blacklist = (".hgignore", ".hgtags", ".jpg", ".pdf", ".png",
                 "bibliography.bst", "bin/copyright.py",
                 "image/graph-algorithms/worldmap-capital-cities.svg",
                 "LICENSE", "style/tkz-arith.tex", "tex/license-gfdl.tex",
                 "tex/version.tex", "TODO")
    if ".hg/" in f:
        return True
    if f.endswith(".sty") and not f.endswith("mystyle.sty"):
        return True
    for e in blacklist:
        if f.endswith(e):
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
        if "Copyright (C)" in line and "Minh Van Nguyen <nguyenminh2" in line:
            has_copyright = True
            # substring preceding "Minh Van Nguyen <nguyenminh2"
            s = line.split("Minh Van Nguyen <nguyenminh2")[0].strip()
            latest_year = s.split()[-1].strip()
            if latest_year == year:
                output += line
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
    sys.stdout.flush()
    sys.exit(0)
