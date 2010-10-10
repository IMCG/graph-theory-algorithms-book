# Copyright (C) 2009, 2010 Minh Van Nguyen <nguyenminh2@gmail.com>
#
# Make sure that the following commands are in your PATH variable:
# latex, dvips, ps2pdf, rm

# change "template" to the name of your master .tex file
FILE = book
TEX_MASTER = $(FILE).tex

all:
	make latex
	makeindex $(FILE)
	(BSTINPUTS=.:style:${BSTINPUTS:-:} && export BSTINPUTS && \
	 bibtex $(FILE))
	make latex
	make clean

latex:
	(TEXINPUTS=.:style:${TEXINPUTS:-:} && export TEXINPUTS && \
	 pdflatex -shell-escape $(TEX_MASTER))
	(TEXINPUTS=.:style:${TEXINPUTS:-:} && export TEXINPUTS && \
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
