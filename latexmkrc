# This file is part of the TUM Overleaf template.
# It is used to point the LaTeX Compiler to the class and package files
# located in the tum/ subdirectory.

$ENV{'TEXINPUTS'}='./tum//:' . $ENV{'TEXINPUTS'};
