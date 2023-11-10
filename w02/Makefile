# LaTeX Makefile for Beamer presentation

MAIN := $(shell ls era_slides_w*.tex | grep -Po '.*(?=\.)')

# Check if a .tex file was found
ifeq ($(MAIN),)
$(error No .tex file found matching the naming convention "era_slides_w**.tex")
endif

# Define paths to the "beamer" and "beamer/resources" directories
PDF_OUTPUT = $(patsubst %.tex,%.pdf,$(MAIN)) 
BEAMER_FOLDER = ../beamer
RESOURCES_FOLDER = ../$(BEAMER_FOLDER)/resources

# Additional style (.sty) and class (.cls) files inside the 'beamer' folder
EXTRA_STY = $(wildcard $(BEAMER_FOLDER)/*.sty)
EXTRA_CLS = $(wildcard $(BEAMER_FOLDER)/*.cls)

# List of resource files to include in the TEXINPUTS variable
RESOURCE_PATH = '$(BEAMER_FOLDER)':'$(RESOURCES_FOLDER)'

# LaTeX compiler and flags
LATEX = pdflatex
LATEX_FLAGS = -shell-escape -recorder

# Set the TEXINPUTS environment variable to include the 'beamer' and 'beamer/resources' folders
export TEXINPUTS := $(RESOURCE_PATH)//

# Clean target files (excluding .pdf and .tex)
CLEAN_TARGETS = *.aux *.log *.nav *.out *.snm *.toc

all: $(PDF_OUTPUT)

$(PDF_OUTPUT): $(MAIN) $(EXTRA_STY) $(EXTRA_CLS)
	$(LATEX) $(LATEX_FLAGS) $(MAIN)
	$(LATEX) $(LATEX_FLAGS) $(MAIN)
	$(LATEX) $(LATEX_FLAGS) $(MAIN)

clean:
	rm -f $(CLEAN_TARGETS)

distclean: clean
	rm -f $(PDF_OUTPUT)

.PHONY: all clean distclean
