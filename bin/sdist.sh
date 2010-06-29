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

# Wrap up a source distribution of the book "Algorithmic Graph Theory".
# You should not run this script directly, but invoke it through the script
# BOOK_ROOT/util.sh. Before running the current script, you need to ensure
# that the book compiles OK by running the .tex files through LaTeX. In
# particular, issuing the command
#
# $ make
#
# from BOOK_ROOT would compile the LaTeX source files and produce a PDF
# version of the book. This command should not result in any errors.
#
# Assume that BOOK_ROOT is the top-level directory of this source tree.
# For a version release, issue the command
#
# $ BOOK_ROOT/util.sh --dist x.y
#
# This results in a source tarball named "graph-theory-x.y.tar.bz2" and a
# PDF version of the book named "graph-theory-x.y.pdf". Thus, a version
# release has a version number of the form x.y, where x signifies the
# major version number and y signifies the minor version number.
#
# Apart from the version release, you could also wrap up a revision release
# by issuing the command
#
# $ BOOK_ROOT/util.sh --dist
#
# This has the effect of taking the current revision or snapshot of the
# source tree and produce a bug fix release. The resulting source tarball is
# named "latest-rxxx.tar.bz2" and a PDF version of the book is named
# "latest-rxxx.pdf". You can think of the command
# "BOOK_ROOT/util.sh --dist" as producing a nightly build of the whole
# source tree and wrap up that tree for distribution. If this project were
# hosted on a server that allows for nightly builds or working daily
# snapshots, the command "BOOK_ROOT/util.sh --dist" would serve that
# purpose.

BOOK_ROOT="$2"
cd "$BOOK_ROOT"
NAME=""
VERSION=""

build() {
    # Compile the whole book first, before actually doing the wrapping up.
    # At this stage, it is assumed that the whole source tree of the book
    # compiles OK without any errors. It is up to you to ensure this. If the
    # book does not compile OK, the following command would seem to hang. In
    # that case, pressing the Enter key should return you to the command
    # prompt. This function should invoke the file BOOK_ROOT/Makefile.
    make 2>&1 > /dev/null
    make clean 2>&1 > /dev/null
}

# Determine whether we want to do a revision release or a version release.
if [ "$1" = "--revision" ]; then
    echo "Wrap up revision release..."
    VERSION=`hg tip | head -1 | awk '{split($2, array, ":"); print array[1]}'`
    NAME="latest-r"
    STABLE=`cat "$BOOK_ROOT"/tex/version.tex`
    echo "$STABLE-r$VERSION" > "$BOOK_ROOT"/tex/version.tex
    build
    # We do not want to save the revision number in the version.tex file. So
    # restore the stable release number in that file. That way, Mercurial
    # would not complain about version.tex being modified. The file
    # version.tex essentially stores the latest stable version number.
    echo "$STABLE" > "$BOOK_ROOT"/tex/version.tex
else
    echo "Wrap up version release..."
    VERSION="$1"
    NAME="graph-theory-"
    echo "$1" > "$BOOK_ROOT"/tex/version.tex
    hg diff
    hg status
    hg tag "$VERSION"
    hg commit -m "$VERSION"
    build
fi

# Test if there is a file called "book.pdf". That file results from
# running the command "make" from BOOK_ROOT.
if [ -e "book.pdf" ] && [ -f "book.pdf" ]; then
    cd ..
    cp -rf "$BOOK_ROOT" "$NAME$VERSION"
    mv "$NAME$VERSION"/book.pdf "$NAME$VERSION".pdf
    tar -jcf "$NAME$VERSION".tar.bz2 "$NAME$VERSION"
    rm -rf "$NAME$VERSION"
    # You should now be left with the original source tree named
    # "graph-theory-x.y". In addition, you now have two new files named
    # "<NAME><VERSION>.tar.bz2" and "<NAME><VERSION>.pdf".
else
    echo "File book.pdf does not exist. Exiting..."
    exit 1
fi
