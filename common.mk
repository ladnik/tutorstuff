TEXS := $(filter-out preamble.tex,$(wildcard *.tex))

LATEXMKFLAGS+=-pdf -halt-on-error -interaction=nonstopmode -shell-escape

TEXINPUTS_FULL := $(TEXINPUTS_EXTRA)../beamer//:

.PHONY: all clean distclean

%.pdf: %.tex
	TEXINPUTS=$(TEXINPUTS_FULL) latexmk $(LATEXMKFLAGS) $<

all: $(TEXS:.tex=.pdf)

clean:
	rm -f *.aux *.log *.out *.toc *.nav *.snm *.vrb *.synctex.gz *.fls *.fdb_latexmk *.bak*
	latexmk -c

distclean: clean
	rm -f $(TEXS:.tex=.pdf)
