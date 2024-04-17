% File: tumcover.cls Copyright (C) 2020 The LaTeX4EI Team
% Provides a bookcover class in TUM Corporate Design.
%
% It may be distributed and/or modified under the conditions of the
% LaTeX Project Public License (LPPL), either version 1.3c of this
% license or (at your option) any later version. The latest version
% of this license is in the file
%
%    https://www.latex-project.org/lppl.txt
%
% This file is part of the "tum-templates bundle" (The Work in LPPL)
% and all files in that bundle must be distributed together.
%
%
% ----------------------------------------------------------------------------
%
% The development version of the bundle can be found at
%
%    https://gitlab.lrz.de/latex4ei/tum-templates
%
% for those people who are interested.
%
% ----------------------------------------------------------------------------
%
% Version history:
% v2.0 2021/04/19 Initial version.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tumcover}[2021/04/19 v2.0]


% .:: Load required packages
% ----------------------------------------------------------------------------

\RequirePackage{pgfkeys}
\RequirePackage{pgfopts}
\RequirePackage{calc}


% .:: Package options for tumcover class
% ----------------------------------------------------------------------------

% print debug info to logfile
\typeout{Global options before any option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}

% length to store tum logo height, cover BCOR, and font size
\newlength{\@tum@logoheight@}
\newlength{\@tum@cover@bcor@}
\newlength{\@tum@fontsize@base@}

\pgfqkeys{/TUM/bookcover}{
  paper/.is choice,
  paper/a5paper/.code = {
      \PassOptionsToClass{coverwidth=148mm,coverheight=210mm}{bookcover}
      \setlength{\@tum@logoheight@}{7mm}
      \setlength{\@tum@fontsize@base@}{9pt}
    },
  paper/a4paper/.code = {
      \PassOptionsToClass{coverwidth=210mm,coverheight=297mm}{bookcover}
      \setlength{\@tum@logoheight@}{10mm}
      \setlength{\@tum@fontsize@base@}{11pt}
    },
  papername/.forward to = /TUM/bookcover/paper,
  a5paper/.forward to = /TUM/bookcover/paper/a5paper,
  a4paper/.forward to = /TUM/bookcover/paper/a4paper,
  format/.is choice,
  format/a5/.forward to = /TUM/bookcover/paper/a5paper,
  format/a4/.forward to = /TUM/bookcover/paper/a4paper,
  coverBCOR/.code = {\setlength{\@tum@cover@bcor@}{#1}},
}

% set default options
\pgfqkeys{/TUM/bookcover}{paper=a4paper, coverBCOR=0pt}

% process class options
\ProcessPgfOptions{/TUM/bookcover}

% print debug info to logfile
\typeout{Global options after tumcover option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}


% .:: Load base class
% ----------------------------------------------------------------------------

% load 'xcolor' package with 'table' option for compatibility with 'tumcolors'
\PassOptionsToPackage{table}{xcolor}

\PassOptionsToClass{spinewidth=10mm,marklength=5mm,bleedwidth=5mm}{bookcover}
\PassOptionsToClass{\@classoptionslist}{bookcover}
\LoadClass{bookcover}

% print debug info to logfile
\typeout{Global options after bookcover option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}


% .:: Load TUM packages
% ----------------------------------------------------------------------------

\RequirePackage{tumbase.sty}
\RequirePackage{tumcolors.sty}
\RequirePackage{tumlogo.sty}
\RequirePackage{tumlang.sty}
\RequirePackage{tumfonts.sty}
\RequirePackage{tumuser}

% load book package with common macros for tumbook and tumcover
\RequirePackage{tumbook.sty}


% .:: Font setup
% ----------------------------------------------------------------------------

% configure base font size
\KOMAoptions{fontsize=\the\@tum@fontsize@base@}
% define font size for spine area
\newkomafont{spine}{\large}


% .:: Definition of TUM cover areas
% ----------------------------------------------------------------------------

% newer versions of the bookcover class define a 'wrapwidth'
% define and set \wrapwidth to 0pt if it was not defined
\ifdef{\wrapwidth}{}{\dimdef\wrapwidth{0pt}}

% helper dimensions to simplify definition of new cover parts
\dimdef\@tum@cover@area@ypos@{\marklength+\bleedwidth}
\dimdef\@tum@cover@front@xpos@{
  \marklength+\bleedwidth+\flapwidth+\wrapwidth+\coverwidth+\spinewidth}
\dimdef\@tum@cover@spine@xpos@{
  \marklength+\bleedwidth+\flapwidth+\wrapwidth+\coverwidth}
\dimdef\@tum@cover@back@xpos@{
  \marklength+\bleedwidth+\flapwidth+\wrapwidth}

\newbookcoverpart{TUM logo area}{
  \setpartposx{\@tum@cover@front@xpos@+\@tum@cover@bcor@+\@tum@logoheight@}
  \setpartposy{\@tum@cover@area@ypos@+\@tum@logoheight@}
  \setpartwidth{\coverwidth-2\@tum@logoheight@-\@tum@cover@bcor@}
  \setpartheight{\@tum@logoheight@}
}
\newbookcoverpart{TUM title area}{
  \setpartposx{\@tum@cover@front@xpos@+\@tum@cover@bcor@+\@tum@logoheight@}
  \setpartposy{\@tum@cover@area@ypos@+3\@tum@logoheight@}
  \setpartwidth{\coverwidth-2\@tum@logoheight@-\@tum@cover@bcor@}
  \setpartheight{.5\coverheight-4\@tum@logoheight@}
}
\newbookcoverpart{TUM image area}{
  \setpartposx{\@tum@cover@front@xpos@+\@tum@cover@bcor@+\@tum@logoheight@}
  \setpartposy{\@tum@cover@area@ypos@+.5\coverheight}
  \setpartwidth{\coverwidth-2\@tum@logoheight@-\@tum@cover@bcor@}
  \setpartheight{.5\coverheight-\@tum@logoheight@}
}
\newbookcoverpart{TUM spine area}{
  \setpartposx{\@tum@cover@spine@xpos@+.1\spinewidth}
  \setpartposy{\@tum@cover@area@ypos@+\@tum@logoheight@}
  \setpartwidth{.8\spinewidth}
  \setpartheight{\coverheight-2\@tum@logoheight@}
}
\newbookcoverpart{TUM back area}{
  \setpartposx{\@tum@cover@back@xpos@+\@tum@logoheight@}
  \setpartposy{\@tum@cover@area@ypos@+3\@tum@logoheight@}
  \setpartwidth{\coverwidth-2\@tum@logoheight@-\@tum@cover@bcor@}
  \setpartheight{\coverheight-4\@tum@logoheight@}
}

\newbookcovercomponenttype{rotate}{
  \centering\rotatebox[origin=c]{270}{%
    \makebox[\coverheight - 2\@tum@logoheight@][l]{#1}}
}

% helper macros to identify predefined areas
\newcommand{\@colorized@area@text@}[2]{%
  \centering\vfill\textcolor{#1}{\LARGE\textbf{#2}}\vfill}

\newcommand{\showTUMareas}{
  \bookcovercomponent{color}{TUM logo area}{TUMOrange!40}
  \bookcovercomponent{color}{TUM title area}{TUMGreen!40}
  \bookcovercomponent{color}{TUM image area}{TUMBlueLight!40}
  \bookcovercomponent{color}{TUM spine area}{TUMExtGoldenrod!30}
  \bookcovercomponent{color}{TUM back area}{TUMExtViolet!30}
  \bookcovercomponent{normal}{TUM logo area}{%
    \@colorized@area@text@{TUMOrange}{TUM logo area}}
  \bookcovercomponent{normal}{TUM title area}{%
    \@colorized@area@text@{TUMGreen}{TUM title area}}
  \bookcovercomponent{normal}{TUM image area}{%
    \@colorized@area@text@{TUMBlueLight}{TUM image area}}
  \bookcovercomponent{rotate}{TUM spine area}{%
    \hfill\textcolor{TUMExtGoldenrod}{\LARGE\textbf{TUM spine area}}\hfill}
  \bookcovercomponent{normal}{TUM back area}{%
    \@colorized@area@text@{TUMExtViolet}{TUM back area}}
}


% .:: Default content of cover areas
% ----------------------------------------------------------------------------

\renewcommand{\maketitle}{
  \bookcovercomponent{normal}{TUM logo area}{%
    \hfill\theTUMLogo[height=\@tum@logoheight@, color=TUMBlue]
  }
  \bookcovercomponent{normal}{TUM title area}{
    \vspace{\@tum@logoheight@}
    \theTUMTitleBlock
  }
  \bookcovercomponent{normal}{TUM image area}{
    \setlength{\TUMCoverImageWidth}{\partwidth}
    \setlength{\TUMCoverImageHeight}{\partheight}
    \theTUMCoverImage
  }
  \bookcovercomponent{rotate}{TUM spine area}{%
    \usekomafont{author}\usesizeofkomafont{spine}\@author
  }
  \bookcovercomponent{rotate}{TUM spine area}{%
    \hfill\usekomafont{title}\usesizeofkomafont{spine}\@title\hfill
  }
  \pgfmathparse{min(.8\spinewidth,\@tum@logoheight@)}
  \bookcovercomponent{rotate}{TUM spine area}{%
    \hfill\theTUMLogo[height=\pgfmathresult pt, color=TUMBlue]%
  }
}

% expose logo hight to user for curstomizations
\let\TUMLogoHeight\@tum@logoheight@


% .:: Set default PDF metadata
% ----------------------------------------------------------------------------

% avoid opening of bookmarks tree in pdf viewer
\hypersetup{
  pdfpagemode = UseNone,
  pdfpagelayout = SinglePage,
}
