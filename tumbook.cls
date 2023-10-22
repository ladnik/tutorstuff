% File: tumbook.cls Copyright (C) 2019 The LaTeX4EI Team
% Provides a book class for thesis and lecture notes in TUM Corporate Design.
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
\ProvidesClass{tumbook}[2021/04/19 v2.0]


% .:: Load required packages
% ----------------------------------------------------------------------------

\RequirePackage{pgfkeys}
\RequirePackage{pgfopts}
\RequirePackage{calc}


% .:: Package options for tumbook class
% ----------------------------------------------------------------------------

% print debug info to logfile
\typeout{Global options before any option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}

\newcommand{\@tum@thesispage@}{}
\newif\if@tum@print@coverpage@
\newif\if@tum@print@titlepage@
\newif\if@tum@print@headmarks@

\pgfqkeys{/TUM/book}{
  thesis/.is choice,
  thesis/.default = student,
  thesis/none/.code = {
      \renewcommand{\@tum@thesispage@}{}
    },
  thesis/student/.code = {
      \renewcommand{\@tum@thesispage@}{\@tum@thesispage@student@}
    },
  thesis/phd/.code = {
      \renewcommand{\@tum@thesispage@}{\@tum@thesispage@phd@}
    },
  coverpage/.is if = @tum@print@coverpage@,
  titlepage/.is if = @tum@print@titlepage@,
  headmarks/.is if = @tum@print@headmarks@,
  coverBCOR/.store in = \@tum@cover@bcor@,
}

% set default options
\pgfqkeys{/TUM/book}{
  thesis    = none,
  coverpage = true,
  titlepage = true,
  headmarks = false,
}

% process class options
\ProcessPgfOptions{/TUM/book}

% print debug info to logfile
\typeout{Global options after tumbook option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}


% .:: Load base class
% ----------------------------------------------------------------------------

\PassOptionsToClass{bibliography=totoc,index=totoc,numbers=noenddot}{scrbook}
\PassOptionsToClass{\@classoptionslist}{scrbook}
\LoadClass{scrbook}

% print debug info to logfile
\typeout{Global options after scrbook option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}


% .:: Load TUM packages
% ----------------------------------------------------------------------------

\RequirePackage{tumbase.sty}
\RequirePackage{tumcolors.sty}
\RequirePackage{tumlogo.sty}
\RequirePackage{tumlang.sty}
\RequirePackage{tumcaptions.sty}
\RequirePackage{tumpage.sty}
\RequirePackage{tumfonts.sty}
\RequirePackage{tumboxes.sty}
\RequirePackage{tumuser}

% load book package with common macros for tumbook and tumcover
\RequirePackage{tumbook.sty}


% .:: General layout settings
% ----------------------------------------------------------------------------

\ifbool{@tum@print@headmarks@}{
  \RedeclarePageStyleAlias{TUM.insidepage}{TUM.insidepage.headmarks}
  \RedeclarePageStyleAlias{TUM.margincolumn}{TUM.margincolumn.headmarks}
}{
  % empty because plain pagestyles are the default
}

% load default pagestyle
\pagestyle{TUM.insidepage}
% explicitly set part, chapter, and index pagestyle to plain version
\renewcommand*{\partpagestyle}{TUM.insidepage.plain}
\renewcommand*{\chapterpagestyle}{TUM.insidepage.plain}
\renewcommand*{\indexpagestyle}{TUM.insidepage.plain}


% .:: Default book layout (e.g. for Lecture notes)
% ----------------------------------------------------------------------------

\newlength{\@tum@cover@title@height@}

\newcommand{\@tum@coverpage@}{
  % configure different bindingoffset of coverpage (if coverBCOR was given)
  \ifdef{\@tum@cover@bcor@}{
    \let\@tum@bcor@temp@\@tum@bindingoffset@
    \let\@tum@bindingoffset@\@tum@cover@bcor@
  }{}
  % the titlepage always uses the TUM.titlepage pagestyle
  \pagestyle{TUM.titlepage}
  % determin the dimensions of the titlepage image (50% of the page)
  \setlength{\TUMCoverImageHeight}{.5\paperheight - \@tum@logoheight@}
  \setlength{\TUMCoverImageWidth}{\textwidth}
  \setlength{\@tum@cover@title@height@}{
    \textheight - \TUMCoverImageHeight - \@tum@logoheight@}
  % print the titlepage
  \noindent
  \begin{minipage}[b][\@tum@cover@title@height@][t]{\textwidth}
    \vspace{\@tum@logoheight@}
    \theTUMTitleBlock
  \end{minipage}
  \vfill\noindent
  \parbox[b][\TUMCoverImageHeight][t]{\TUMCoverImageWidth}{
    \theTUMCoverImage
  }
  \cleardoublepage
  % restore bindingoffset of inside pages (if different coverBCOR was given)
  \ifdef{\@tum@bcor@temp@}{
    \let\@tum@bindingoffset@\@tum@bcor@temp@
  }{}
}

\newcommand{\@tum@titlepage@}{
  \noindent
  \begin{minipage}[b][.5\textheight][t]{\textwidth}
    \vspace{\@tum@logoheight@}
    \theTUMTitleBlock
  \end{minipage}
  \vfill\noindent
  \begin{minipage}[b]{\textwidth}
    \usekomafont{publishers}\@publishers
  \end{minipage}
  \if@twoside
    % print uppertitleback and lowertitleback only in twosided layouts
    \clearpage\noindent
    \begin{minipage}[b]{\textwidth}
      \@uppertitleback
    \end{minipage}
    \vfill\noindent
    \begin{minipage}[b]{\textwidth}
      \@lowertitleback
    \end{minipage}
  \else
    % uppertitleback and lowertitleback are usually not configured in a
    % onesided layout. Throw a class warning if they are set anyways.
    \ifdefempty{\@uppertitleback}{}{
      \ClassWarning{tumbook}{non empty \string\uppertitleback\space
        ignored by \string\maketitle \MessageBreak in 'oneside' mode}
    }
    \ifdefempty{\@lowertitleback}{}{
      \ClassWarning{tumbook}{non empty \string\uppertitleback\space
        ignored by \string\maketitle \MessageBreak in 'oneside' mode}
    }
  \fi
  \cleardoublepage
}

\newcommand{\@tum@dedicationpage@}{
  \vspace*{0pt plus 1fill minus 0pt}
  {\centering\usekomafont{dedication}\@dedication\par}
  \vspace{0pt plus 3fill minus 0pt}
  \cleardoublepage
}


% .:: Student thesis layout (for bachelor and master thesis)
% ----------------------------------------------------------------------------

\newcommand{\@tum@thesispage@student@}{%
  \noindent\@tum@threeliner@[\theChairName]{\theDepartmentName}
  \hfill\theTUMLogo\par
  \vspace{2\@tum@logoheight@}\par
  \noindent\parbox[t][.5\textheight - 4\@tum@logoheight@][t]{\textwidth}{%
    \theTUMTitleBlock
  }%
  \vspace{\@tum@logoheight@}\par
  \theTUMStudentFineprintBlock
  \vfill
  \theTUMStudentCommitteeBlock
  \vfill
  \cleardoublepage
  \null\vfill
  \@tum@student@disclamer@block@
  \cleardoublepage
}

\newcommand{\@tum@student@disclamer@block@}{{
    \raggedright\noindent
    \@tum@student@disclamer@\par
    \vspace{2cm}
    \noindent
    \rlap{\theAuthorCity\@tum@date@separator@\theDateSubmitted}{%
      \hspace{.5\textwidth}\@author}\par
  }}

\provideName{\@tum@student@disclamer@}{%
  I hereby declare that this thesis is entirely the result of my own work
  except where otherwise indicated. I have only used the resources given in
  the list of references.%
}{%
  Ich versichere hiermit, dass ich die von mir eingereichte Abschlussarbeit
  selbstständig verfasst und keine anderen als die angegebenen Quellen und
  Hilfsmittel benutzt habe.%
}


% .:: PhD thesis layout
% ----------------------------------------------------------------------------

\newcommand{\@tum@thesispage@phd@}{%
  \begin{otherlanguage}{ngerman}
    \noindent\@tum@threeliner@[\theChairName]{\theDepartmentName}
    \hfill\theTUMLogo[height=\@tum@logoheight@]\par
    \vspace{2\@tum@logoheight@}
    \noindent\parbox[t][.5\textheight - 4\@tum@logoheight@][t]{\textwidth}{%
      \theTUMTitleBlock
    }%
    \vspace{\@tum@logoheight@}\par
    \theTUMPhDFineprintBlock
    \vfill
    \theTUMPhDCommitteeBlock
    \vfill
    \theTUMPhDSubmissionBlock
    \vspace{\@tum@logoheight@}
  \end{otherlanguage}
  \cleardoublepage
}


%  .:: maketitle command
% ----------------------------------------------------------------------------

\renewcommand{\maketitle}{%
  % store currently defined page style
  \let\@tum@pagestyle@temp@\currentpagestyle
  % print coverpage only if selected
  \ifbool{@tum@print@coverpage@}{\@tum@coverpage@}{}
  % titlepages should always use an empty insidepage and onecolumn layout
  \pagestyle{TUM.insidepage}\pagestyle{empty}\onecolumn
  \ifbool{@tum@print@titlepage@}{\@tum@titlepage@}{}
  \ifdefempty{\@tum@thesispage@}{}{\@tum@thesispage@}
  \ifdefempty{\@dedication}{}{\@tum@dedicationpage@}
  % restore page style (twocolumn should also be restored automatically)
  \pagestyle{\@tum@pagestyle@temp@}
}


% .:: Set default PDF metadata
% ----------------------------------------------------------------------------

% open bookmarks tree, use SinglePage layout for onesided documents
% and use TwoPageRight layout for twosided documents
\hypersetup{
  bookmarksnumbered = true,
  bookmarksopen = true,
  bookmarksopenlevel = 1,
  pdfpagemode = UseOutlines,
}

\ifbool{@twoside}{
  \hypersetup{pdfpagelayout = TwoPageRight}
}{
  \hypersetup{pdfpagelayout = SinglePage}
}
