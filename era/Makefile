TEXS := $(wildcard *.tex)

.PHONY: all clean distclean

# compile a specific .tex file to PDF and clean auxiliary files
%.pdf: %.tex
	TEXINPUTS=../beamer//: pdflatex -interaction=nonstopmode $<

# compile all .tex files
all: $(TEXS:.tex=.pdf)

# clean auxiliary files
clean:
	rm -f *.aux *.log *.out *.toc *.nav *.snm *.vrb *.synctex.gz *.fls *.fdb_latexmk

# clean all output files
distclean: clean
	rm -f $(TEXS:.tex=.pdf)
