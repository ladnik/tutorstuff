# This file is part of the TUM Overleaf template.
# It is used to point the LaTeX Compiler to the class and package files
# located in the tum/ subdirectory.
$ENV{'TEXINPUTS'}='./beamer//:' . $ENV{'TEXINPUTS'};

# Produce pdf output from tex
#$pdf_mode = 1;