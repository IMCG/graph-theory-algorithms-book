###########################################################################
# Copyright (C) 2009--2011 Minh Van Nguyen <nguyenminh2@gmail.com>
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

# Compile everything. This is usually done by executing the command
#
# $ make
#
# from your terminal.
all:
	make pdf
	makeindex $(FILE)
	(BSTINPUTS=.:style:${BSTINPUTS:-:} && export BSTINPUTS && \
	 bibtex $(FILE))
	make pdf
	make clean

# We distribute PGFPlots 1.4.1 and TikZ/PGF 2.10 with this book. The versions
# of PGFPlots and TikZ/PGF as distributed via TeX Live with Ubuntu 10.10 are
# rather old.
pdf:
	(TEXINPUTS=.:style:style/tex/context/third/pgf/basiclayer:style/tex/context/third/pgf/frontendlayer:style/tex/context/third/pgf/math:style/tex/context/third/pgf/systemlayer:style/tex/context/third/pgf/utilities:style/context/third/pgfplots:style/tex/generic/pgf/basiclayer:style/tex/generic/pgf/frontendlayer/svg:style/tex/generic/pgf/frontendlayer/tikz/libraries/circuits:style/tex/generic/pgf/frontendlayer/tikz/libraries/datavisualization:style/tex/generic/pgf/frontendlayer/tikz/libraries/graphs:style/tex/generic/pgf/frontendlayer/tikz/libraries:style/tex/generic/pgf/frontendlayer/tikz:style/tex/generic/pgf/libraries/datavisualization:style/tex/generic/pgf/libraries/decorations:style/tex/generic/pgf/libraries:style/tex/generic/pgf/libraries/shapes/circuits:style/tex/generic/pgf/libraries/shapes:style/tex/generic/pgf/math:style/tex/generic/pgf/modules:style/tex/generic/pgf/rendering:style/tex/generic/pgf/systemlayer:style/tex/generic/pgf/utilities:style/generic/pgfplots:style/generic/pgfplots/libs:style/generic/pgfplots/liststructure:style/generic/pgfplots/numtable:style/generic/pgfplots/oldpgfcompatib:style/generic/pgfplots/oldpgfplotscompatib:style/generic/pgfplots/sys:style/generic/pgfplots/util:style/latex/pgfplots:style/latex/pgfplots/libs:style/plain/pgfplots:style/tex/latex/pgf/basiclayer:style/tex/latex/pgf/compatibility:style/tex/latex/pgf/doc:style/tex/latex/pgf/frontendlayer/libraries:style/tex/latex/pgf/frontendlayer:style/tex/latex/pgf/math:style/tex/latex/pgf/systemlayer:style/tex/latex/pgf/utilities:style/tex/plain/pgf/basiclayer:style/tex/plain/pgf/frontendlayer:style/tex/plain/pgf/math:style/tex/plain/pgf/systemlayer:style/tex/plain/pgf/utilities:${TEXINPUTS:-:} && export TEXINPUTS && \
	 pdflatex -shell-escape $(TEX_MASTER))
	(TEXINPUTS=.:style:style/tex/context/third/pgf/basiclayer:style/tex/context/third/pgf/frontendlayer:style/tex/context/third/pgf/math:style/tex/context/third/pgf/systemlayer:style/tex/context/third/pgf/utilities:style/context/third/pgfplots:style/tex/generic/pgf/basiclayer:style/tex/generic/pgf/frontendlayer/svg:style/tex/generic/pgf/frontendlayer/tikz/libraries/circuits:style/tex/generic/pgf/frontendlayer/tikz/libraries/datavisualization:style/tex/generic/pgf/frontendlayer/tikz/libraries/graphs:style/tex/generic/pgf/frontendlayer/tikz/libraries:style/tex/generic/pgf/frontendlayer/tikz:style/tex/generic/pgf/libraries/datavisualization:style/tex/generic/pgf/libraries/decorations:style/tex/generic/pgf/libraries:style/tex/generic/pgf/libraries/shapes/circuits:style/tex/generic/pgf/libraries/shapes:style/tex/generic/pgf/math:style/tex/generic/pgf/modules:style/tex/generic/pgf/rendering:style/tex/generic/pgf/systemlayer:style/tex/generic/pgf/utilities:style/generic/pgfplots:style/generic/pgfplots/libs:style/generic/pgfplots/liststructure:style/generic/pgfplots/numtable:style/generic/pgfplots/oldpgfcompatib:style/generic/pgfplots/oldpgfplotscompatib:style/generic/pgfplots/sys:style/generic/pgfplots/util:style/latex/pgfplots:style/latex/pgfplots/libs:style/plain/pgfplots:style/tex/latex/pgf/basiclayer:style/tex/latex/pgf/compatibility:style/tex/latex/pgf/doc:style/tex/latex/pgf/frontendlayer/libraries:style/tex/latex/pgf/frontendlayer:style/tex/latex/pgf/math:style/tex/latex/pgf/systemlayer:style/tex/latex/pgf/utilities:style/tex/plain/pgf/basiclayer:style/tex/plain/pgf/frontendlayer:style/tex/plain/pgf/math:style/tex/plain/pgf/systemlayer:style/tex/plain/pgf/utilities:${TEXINPUTS:-:} && export TEXINPUTS && \
	 pdflatex -shell-escape $(TEX_MASTER))

clean:
	rm -rfv *#
	rm -rfv *~
	rm -rfv *.aux
	rm -rfv *.auxlock
	rm -rfv *.bak
	rm -rfv tex/*.bak
	rm -rfv *.bbl
	rm -rfv *.blg
	rm -rfv *.dep
	rm -rfv *.dpth
	rm -rfv *.dvi
	rm -rfv *.gnuplot
	rm -rfv *.idx
	rm -rfv *.ilg
	rm -rfv *.ind
	rm -rfv *.loa
	rm -rfv *.lof
	rm -rfv *.log
	rm -rfv *.lot
	rm -rfv *.orig
	rm -rfv *.out
	rm -rfv *.ps
	rm -rfv *.table
	rm -rfv *.toc
