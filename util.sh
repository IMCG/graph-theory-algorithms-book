#!/usr/bin/env bash

###########################################################################
# Copyright (c) 2010 Minh Van Nguyen <nguyenminh2@gmail.com>
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

# The main interface to the utilities under the directory bin/.

# Make the top-level directory absolute:
BOOK_ROOT=`pwd`
export BOOK_ROOT

# Print usage information for this script.
usage() {
    echo "Usage: $0 <options>"
    echo "Optional arguments:"
    echo "--dist [VER]   Wrap up a source distribution with version number VER."
}

# You must provide an argument to this script.
if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

# Wrapping up a source distribution. See the file
#
# bin/sdist.sh
#
# for more information about wrapping up a source distribution. That file
# also discusses the distinction between a version release and a revision
# release.
if [ "$1" = "--dist" ]; then
    # Argument must be of the form "--dist [VER]".
    # No argument to --dist, so wrap up a revision release.
    if [ "$#" -eq 1 ]; then
    	"$BOOK_ROOT/bin/sdist.sh" "--revision" "$BOOK_ROOT"
    # An argument is provided to --dist, so wrap up a version release.
    elif [ "$#" -eq 2 ]; then
    	"$BOOK_ROOT/bin/sdist.sh" "$2" "$BOOK_ROOT"
    fi
fi
