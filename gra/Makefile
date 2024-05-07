# compile a specific .tex file to PDF and clean auxiliary files
# call with: make filename.pdf
%.pdf: %.tex
	TEXINPUTS=./beamer//: pdflatex -interaction=nonstopmode $<
	@$(MAKE) clean

# compile all .tex files
# call with: make
all: $(patsubst %.tex,%.pdf,$(wildcard *.tex))
	@$(MAKE) clean

# clean auxiliary files
clean:
	@rm -f *.aux *.log *.out *.toc *.nav *.snm *.vrb *.synctex.gz *.fls *.fdb_latexmk *.dvi
