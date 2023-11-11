# LaTeX Makefile for Beamer presentation

# Default MAIN value (change if needed)
MAIN ?= era_slides_w03

# Change these variables to match your project's filenames and folder structure
TEX_SRC = $(MAIN).tex
PDF_OUTPUT = $(MAIN).pdf
BEAMER_FOLDER = beamer

# Additional style (.sty) and class (.cls) files inside the 'beamer' folder
EXTRA_STY = $(wildcard $(BEAMER_FOLDER)/*.sty)
EXTRA_CLS = $(wildcard $(BEAMER_FOLDER)/*.cls)

# LaTeX compiler and flags
LATEX = pdflatex
LATEX_FLAGS = -shell-escape

# Set the TEXINPUTS environment variable to include the 'beamer' folder
export TEXINPUTS := ./'$(BEAMER_FOLDER)'//:

# Clean target files (excluding .pdf and .tex)
CLEAN_TARGETS = *.aux *.log *.nav *.out *.snm *.toc

all: $(PDF_OUTPUT)

$(PDF_OUTPUT): $(TEX_SRC) $(EXTRA_STY) $(EXTRA_CLS)
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC)
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC)
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC)

clean:
	rm -f $(CLEAN_TARGETS)

distclean: clean
	rm -f $(PDF_OUTPUT)

.PHONY: all clean distclean
