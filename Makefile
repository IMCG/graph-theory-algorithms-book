###########################################################################
# Copyright (C) 2009, 2010, 2011 Minh Van Nguyen <nguyenminh2@gmail.com>
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

# Make sure you have a proper and working LaTeX/TeX distribution.

FILE = book
TEX_MASTER = $(FILE).tex

all:
	make pdf
	makeindex $(FILE)
	(BSTINPUTS=.:style:${BSTINPUTS:-:} && export BSTINPUTS && \
	 bibtex $(FILE))
	make pdf
	make clean

# We distribute PGFPlots 1.4.1 with this book. The version of PGFPlots that
# is distributed via TeXlive with Ubuntu 10.10 is rather old.
pdf:
	(TEXINPUTS=.:style:style/context/third/pgfplots:style/generic/pgfplots:style/generic/pgfplots/libs:style/generic/pgfplots/liststructure:style/generic/pgfplots/numtable:style/generic/pgfplots/oldpgfcompatib:style/generic/pgfplots/oldpgfplotscompatib:style/generic/pgfplots/sys:style/generic/pgfplots/util:style/latex/pgfplots:style/latex/pgfplots/libs:style/plain/pgfplots:${TEXINPUTS:-:} && export TEXINPUTS && \
	 pdflatex -shell-escape $(TEX_MASTER))
	(TEXINPUTS=.:style:style/context/third/pgfplots:style/generic/pgfplots:style/generic/pgfplots/libs:style/generic/pgfplots/liststructure:style/generic/pgfplots/numtable:style/generic/pgfplots/oldpgfcompatib:style/generic/pgfplots/oldpgfplotscompatib:style/generic/pgfplots/sys:style/generic/pgfplots/util:style/latex/pgfplots:style/latex/pgfplots/libs:style/plain/pgfplots:${TEXINPUTS:-:} && export TEXINPUTS && \
	 pdflatex -shell-escape $(TEX_MASTER))

clean:
	rm -rfv *#
	rm -rfv *~
	rm -rfv *.aux
	rm -rfv *.bak
	rm -rfv tex/*.bak
	rm -rfv *.bbl
	rm -rfv *.blg
	rm -rfv *.dvi
	rm -rfv *.gnuplot
	rm -rfv *.idx
	rm -rfv *.ilg
	rm -rfv *.ind
	rm -rfv *.loa
	rm -rfv *.lof
	rm -rfv *.log
	rm -rfv *.lot
	rm -rfv *.out
	rm -rfv *.ps
	rm -rfv *.table
	rm -rfv *.toc
