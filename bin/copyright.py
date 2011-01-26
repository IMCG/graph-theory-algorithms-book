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

import os
import sys

###################################
# helper functions
###################################

def update_copyright(f):
    """
    Update copyright information of given file.

    INPUT:

    - f --- a regular file.

    OUTPUT:

    The copyright information of f updated.
    """
    # ofile := updated file
    # output := all information to be written to ofile
    # year := the current year
    # for each line in f
    #     if line has the substrings "Copyright (C)" and "Minh Van Nguyen <nguyenminh2@gmail.com>"
    #         s := substring preceding "Minh Van Nguyen <nguyenminh2@gmail.com>"
    #         t := substring following s
    #         s := append ", year" to s
    #         s := concatenate s and t
    #         output := append s to output
    #     output := append line to output
    # write output to ofile

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
    # T := directory tree of BOOK_ROOT where T[i] is either a directory or file
    #      under BOOKT_ROOT
    # for each e in T
    #     if e is a directory
    #         continue with next iteration of loop
    #     if e is a regular file
    #         update_copyright(e)
    #     continue with next iteration of loop
    sys.exit(0)
