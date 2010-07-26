# Copyright (C) 2008 Minh Van Nguyen <nguyenminh2@gmail.com>
#
# Make sure that the following commands are in your PATH variable:
# latex, dvips, ps2pdf, rm

# change "template" to the name of your master .tex file
FILE = book

all:
	make latex
	makeindex $(FILE)
	bibtex $(FILE)
	make latex
	make clean

latex:
	pdflatex $(FILE).tex
	pdflatex $(FILE).tex

clean:
	rm -rfv *#
	rm -rfv *~
	rm -rfv *.aux
	rm -rfv *.bak
	rm -rfv tex/*.bak
	rm -rfv *.bbl
	rm -rfv *.blg
	rm -rfv *.dvi
	rm -rfv *.idx
	rm -rfv *.ilg
	rm -rfv *.ind
	rm -rfv *.loa
	rm -rfv *.lof
	rm -rfv *.log
	rm -rfv *.lot
	rm -rfv *.out
	rm -rfv *.ps
	rm -rfv *.toc
