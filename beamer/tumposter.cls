% File: tumposter.cls Copyright (C) 2019 The LaTeX4EI Team
% Provides the TUM Corporate Design poster class (e.g., for scientific
% posters).
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
\ProvidesClass{tumposter}[2021/04/19 v2.0]


% .:: Load base class
% ----------------------------------------------------------------------------

% print debug info to logfile
\typeout{Global options before any option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}

% suppress typearea warnings, because we use geometry for page layouts
\RequirePackage{silence}
\WarningsOff[typearea]

% pass tumposter class options down to scrartcl
\PassOptionsToClass{\@classoptionslist}{scrartcl}
\LoadClass{scrartcl}

% print debug info to logfile
\typeout{Global options after scrartcl option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}


% .:: Load TUM packages
% ----------------------------------------------------------------------------

\RequirePackage{tumbase.sty}
\RequirePackage{tumcolors.sty}
\RequirePackage{tumlogo.sty}
\RequirePackage{tumlang.sty}
\RequirePackage{tumauthblk.sty}
\RequirePackage{tumcaptions.sty}
\RequirePackage{tumpage.sty}
\RequirePackage[font=helvet]{tumfonts.sty}

% define the width of box rules according to the columnsep
% this scales nicely with the paper size
\newlength{\TUMposterrulewidth}
\setlength{\TUMposterrulewidth}{.15\columnsep}
\RequirePackage[rulewidth=\TUMposterrulewidth]{tumboxes.sty}
% load the tcolorbox poster library
\tcbuselibrary{poster}

\RequirePackage{tumuser}


% .:: Font sizes
% ----------------------------------------------------------------------------

\setkomafont{title}{\usekomafont{TUM.H1}}
\setkomafont{subtitle}{\usekomafont{TUM.H2}}
\setkomafont{author}{\usekomafont{TUM.H3}}
\newkomafont{affiliation}{\usekomafont{TUM.H4}}

\pgfqkeys{/tcb}{
  TUMBox/.append style = {
      fonttitle = \usekomafont{TUM.H3}\bfseries,
    },
  TUMBoxVariant/.append style = {
      fonttitle = \usekomafont{TUM.H3}\bfseries,
    },
  TUMBoxInverse/.append style = {
      fonttitle = \usekomafont{TUM.H3}\bfseries,
    },
}


% .:: Poster title
% ----------------------------------------------------------------------------

% provide a boolean switch to print or omit affiliation lines in title
\newbool{@tum@poster@printaffil@}
\booltrue{@tum@poster@printaffil@}

\renewcommand{\maketitle}{
  \newpage
  \begingroup
  \raggedright
  {\usekomafont{title}\@title\par\vspace{.8ex}}
  \ifdefempty{\@subtitle}{}{
    {\usekomafont{subtitle}\@subtitle\par\vspace{.8ex}}
  }
  \ifbool{@tum@poster@printaffil@}{
    {\usekomafont{author}\@author\par\vspace{1ex}}
    {\usekomafont{affiliation}\theAffil\par}
  }{
    {\usekomafont{author}\@author\par}
  }
  \endgroup
}


% .:: Poster layout
% ----------------------------------------------------------------------------

% posters always use the titlepage pagestyle
\pagestyle{TUM.titlepage}

% default settings for the tcbposter environment
\pgfkeys{
  /tcb/posterset/.cd,
  fontsize = \@tum@fontsize@base@,          % base font size
  coverage = {
      fill downwards = -\@tum@logoheight@,  % extend until end of page
      size = minimal,                       % no additional borders
      opacityback = 0,                      % transparent background
      before skip = \columnsep              % space between title and boxes
    },
  /tcb/poster/.cd,
  spacing = \columnsep,                     % spacing between poster boxes
}


% .:: Sanity checks for column number and base font size
% ----------------------------------------------------------------------------

% maximum columns according to the TUM CD PowerPoint templates
\ifbool{@tum@landscape@}{
  \ifdefstring{\@tum@papername@}{a0paper}{\numdef\@tum@poster@maxcol@{5}}{}
  \ifdefstring{\@tum@papername@}{a1paper}{\numdef\@tum@poster@maxcol@{4}}{}
  \ifdefstring{\@tum@papername@}{a2paper}{\numdef\@tum@poster@maxcol@{4}}{}
  \ifdefstring{\@tum@papername@}{a3paper}{\numdef\@tum@poster@maxcol@{3}}{}
  \ifdefstring{\@tum@papername@}{a4paper}{\numdef\@tum@poster@maxcol@{3}}{}
  \ifdefstring{\@tum@papername@}{a5paper}{\numdef\@tum@poster@maxcol@{2}}{}
}{
  \ifdefstring{\@tum@papername@}{a0paper}{\numdef\@tum@poster@maxcol@{4}}{}
  \ifdefstring{\@tum@papername@}{a1paper}{\numdef\@tum@poster@maxcol@{3}}{}
  \ifdefstring{\@tum@papername@}{a2paper}{\numdef\@tum@poster@maxcol@{3}}{}
  \ifdefstring{\@tum@papername@}{a3paper}{\numdef\@tum@poster@maxcol@{2}}{}
  \ifdefstring{\@tum@papername@}{a4paper}{\numdef\@tum@poster@maxcol@{2}}{}
  \ifdefstring{\@tum@papername@}{a5paper}{\numdef\@tum@poster@maxcol@{1}}{}
}

% sanity check for the column number
% throws a ClassWarning if user selects more columns than recommended
\newcommand{\@tum@poster@maxcol@test@}[1]{
  \ifnumgreater{#1}{\@tum@poster@maxcol@}{
    \ClassWarningNoLine{tumposter}{It is not recommended to have more than
      \@tum@poster@maxcol@\space columns\MessageBreak on an
      \@tum@papername@\space \ifbool{@tum@landscape@}{landscape}{portrait}
      poster!\MessageBreak}
  }{}
}

% sanity check for the font size
% throws a ClassWarning if user selects a fontsize smaller than recommended
\newcommand{\@tum@poster@fontsize@test@}[1]{
  \ifdimless{#1}{\@tum@fontsize@base@}{
    \ClassWarningNoLine{tumposter}{It is not recommended to set the fontsize
      \MessageBreak smaller than \the\@tum@fontsize@base@\space
      on an \@tum@papername@\space poster!\MessageBreak}
  }{}
}


% .:: Macro and keys to configure poster style
% ----------------------------------------------------------------------------

% tex length to store the vertical and horizontal space between poster boxes
\newlength{\TUMposterboxsep}

% keys for poster setup
\pgfqkeys{/TUM/poster/setup}{
  boxes/.is choice,
  boxes/TUMBox/.code = {
      \setlength{\TUMposterboxsep}{.4\columnsep}
      \pgfkeys{
        /tcb/poster/.cd, spacing = \TUMposterboxsep,
        /tcb/posterset/boxes = {TUMBox}
      }
    },
  boxes/TUMBoxVariant/.code = {
      \setlength{\TUMposterboxsep}{.4\columnsep}
      \pgfkeys{
        /tcb/poster/.cd, spacing = \TUMposterboxsep,
        /tcb/posterset/boxes = {TUMBoxVariant}
      }
    },
  boxes/TUMBoxInverse/.code = {
      \setlength{\TUMposterboxsep}{.4\columnsep}
      \pgfkeys{
        /tcb/poster/.cd, spacing = \TUMposterboxsep,
        /tcb/posterset/boxes = {TUMBoxInverse}
      }
    },
  boxes/TUMBoxBlank/.code = {
      \setlength{\TUMposterboxsep}{\columnsep}
      \pgfkeys{
        /tcb/poster/.cd, spacing = \TUMposterboxsep,
        /tcb/posterset/boxes = {TUMBoxBlank}
      }
    },
  columns/.code = {
      \@tum@poster@maxcol@test@{#1}
      \pgfkeys{/tcb/poster/columns=#1}
    },
  rows/.forward to = /tcb/poster/rows,
  showframe/.forward to = /tcb/poster/showframe,
  fontsize/.code =     {
      \@tum@poster@fontsize@test@{#1}
      \pgfkeys{/tcb/posterset/fontsize=#1}
    },
  printaffil/.is if = @tum@poster@printaffil@,
  printaffil/.default = true,
  background/.is choice,
  background/white/.code = {
      \renewcommand{\@tum@headline@color@}{TUMBlue}
      \color{TUMBlack}\let\default@color\current@color
      \RemoveLayersFromPageStyle{TUM.titlepage}{TUM.background.blue}
      \RemoveLayersFromPageStyle{TUM.titlepage}{TUM.background.shaded}
    },
  background/blue/.code = {
      \renewcommand{\@tum@headline@color@}{TUMWhite}
      \color{TUMWhite}\let\default@color\current@color
      \AddLayersAtBeginOfPageStyle{TUM.titlepage}{TUM.background.blue}
      \RemoveLayersFromPageStyle{TUM.titlepage}{TUM.background.shaded}
    },
  background/shaded/.code = {
      \renewcommand{\@tum@headline@color@}{TUMWhite}
      \color{TUMWhite}\let\default@color\current@color
      \AddLayersAtBeginOfPageStyle{TUM.titlepage}{TUM.background.shaded}
      \RemoveLayersFromPageStyle{TUM.titlepage}{TUM.background.blue}
    },
  headline/.forward to = /TUM/page/headline,
}

% macro for TUMposter setup
\newcommand{\TUMpostersetup}[1]{
  % process key-value options
  \pgfqkeys{/TUM/poster/setup}{#1}
}

% process standard setup
\TUMpostersetup{
  background = white,
  boxes = TUMBox,
  fontsize = \@tum@fontsize@base@,
  columns = 2,
  rows = 5,
  printaffil = true,
  showframe = false,
  headline = threeliner,
}


% .:: Use [H] as default float placement to work properly inside boxes
% ----------------------------------------------------------------------------

\RequirePackage{float}
\floatplacement{figure}{H}
\floatplacement{table}{H}


% .:: Set default PDF metadata
% ----------------------------------------------------------------------------

\AtBeginDocument{
  \def\@tum@pdftitle@{\@title\ifdefempty{\@subtitle}{}{~-~\@subtitle}}
  \hypersetup{
    pdftitle = {\@tum@pdftitle@},
    pdfauthor = {\pgfkeysvalueof{/TUM/author list}},
    pdfsubject = {\@subject},
    % pdfkeywords = {},
    pdfcreator = {\theUniversityName}
  }
}

% avoid opening of bookmarks tree in pdf viewer
\hypersetup{
  pdfpagemode=UseNone,
  pdfpagelayout=SinglePage,
}
