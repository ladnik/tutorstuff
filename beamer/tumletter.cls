% File: tumletter.cls Copyright (C) 2019 The LaTeX4EI Team
% Provides the TUM Corporate Design letter class.
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
\ProvidesClass{tumletter}[2021/04/19 v2.0]


% .:: Load base class
% ----------------------------------------------------------------------------

% print debug info to logfile
\typeout{Global options before any option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}

% pass tumletter class options down to scrlttr2
\PassOptionsToClass{\@classoptionslist}{scrlttr2}
\LoadClass{scrlttr2}

% print debug info to logfile
\typeout{Global options after scrlttr2 option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}


% .:: Load TUM packages
% ----------------------------------------------------------------------------

\RequirePackage{tumbase.sty}
\RequirePackage{tumcolors.sty}
\RequirePackage{tumlogo.sty}
\RequirePackage{tumlang.sty}
\RequirePackage[a4paper, layout=letterpage]{tumpage.sty}
\RequirePackage[font=helvet]{tumfonts.sty}
\RequirePackage{tumuser}


% .:: Load required packages
% ----------------------------------------------------------------------------

\RequirePackage{calc}
\RequirePackage{hyperref}


% .:: Package options for tumletter class
% ----------------------------------------------------------------------------

\newif\if@tum@hidelinks@

\pgfqkeys{/TUM/letter}{
  showframe/.code = {
      \LoadLetterOptions{visualize}
      \showfields{address, head, foot, refline}
      \setkomafont{field}{\color{TUMOrange}}
    },
  hidelinks/.is if = @tum@hidelinks@,
}

% set default options
\pgfkeys{/TUM/letter/hidelinks=true}

% process package options
\ProcessPgfOptions{/TUM/letter}

% print debug info to logfile
\typeout{Global options after tumletter option parsing.}
\typeout{classoptions: \@classoptionslist}
\typeout{unused classoptions: \@unusedoptionlist}


% .:: Layout
% ----------------------------------------------------------------------------

% activate the TUM letter pagestyle
\renewcommand*{\letterpagestyle}{TUM.letterpage}
\pagestyle{TUM.letterpage}

% by default the \opening command selects the pagestyle "empty"
% to avoid users have to load the TUM pagestyle manually, we overwrite this
\apptocmd{\opening}{\thispagestyle{TUM.letterpage}}{%
  \ClassInfo{tumletter}{%
    Successfully patched \string\opening\space macro\MessageBreak
    to use the "TUM.letterpage" pagestyle.}
}{%
  \ClassError{tumletter}{Patching the \string\opening\space macro failed.}{}
}

% activate parskip
\KOMAoptions{parskip=full}

% Address field
\@setplength{toaddrhpos}{25mm}
\@setplength{toaddrvpos}{45mm}         %  27mm (45mm) stated in DIN 5008A(B)
\@setplength{toaddrwidth}{85mm}
\@setplength{toaddrheight}{40mm}
\@setplength{toaddrindent}{0mm}
\@setplength{backaddrheight}{9mm}
\setkomafont{addressee}{\normalsize}
\setkomafont{backaddress}{\scriptsize}
\setkomavar{backaddressseparator}{\;|\;}
\newkomavar{backaddress2}{}
\KOMAoptions{backaddress=plain, addrfield=topaligned}

% modify the way the backaddress is printed matching the
% TUM Corporate Design Word templates
% (automatic indentation seems not to work because of the '\def\\{}' line)
%\begin{noindent}
\renewcommand{\backaddr@format}[1]{%
  \hspace*{\useplength{toaddrindent}}%
  \parbox[b][\useplength{backaddrheight}][t]{%
    \dimexpr\useplength{toaddrwidth}-\useplength{toaddrindent}%
  }{%
    \def\\{\usekomavar{backaddressseparator}\@ogobble}%
    \ignorespaces\usekomafont{backaddress}\usekomavar{backaddress}%
    \ifkomavarempty{backaddress2}{}{\newline\usekomavar{backaddress2}}%
  }%
}
%\end{noindent}

% Foldmarks
\@setplength{tfoldmarkvpos}{100mm}     %  87mm (105mm) stated in DIN 5008A(B)
\@setplength{bfoldmarkvpos}{199mm}     % 192mm (210mm) stated in DIN 5008A(B)
\@setplength{foldmarkhpos}{3.5mm}
\@setplength{tfoldmarklength}{2mm}
\@setplength{bfoldmarklength}{2mm}
\@setplength{pfoldmarklength}{4mm}
\@setplength{foldmarkthickness}{.3pt}
\KOMAoptions{foldmarks=true, foldmarks=BmTPv}

% Headline
\@setplength{firstheadvpos}{20mm}
\@setplength{firstheadhpos}{25mm}
\@setplength{firstheadwidth}{165mm}
\setkomavar{firsthead}{}
\setkomavar{nexthead}{}
\KOMAoptions{firsthead=false}

% Footline
\@setplength{firstfootvpos}{277mm}
\@setplength{firstfoothpos}{25mm}
\@setplength{firstfootwidth}{165mm}
\setkomafont{pagefoot}{\fontsize{8pt}{8.7pt}\selectfont\raggedright}
\setkomafont{pagenumber}{\scriptsize}
\setkomavar{firstfoot}{\usebox{\@tum@footer@}}
\setkomavar{nextfoot}{}
\KOMAoptions{firstfoot=true, pagenumber=false}

% Reference line
\@setplength{refvpos}{93.46mm}         % 75.46mm (93.46mm)
\@setplength{refhpos}{25mm}
\@setplength{refwidth}{165mm}
\@setplength{refaftervskip}{8.46mm}
\setkomafont{refname}{\footnotesize}
\setkomafont{refvalue}{\normalsize}
\setkomavar{placeseparator}{,~}

% only use the fields "yourref" and "myref" in the reference line
\removereffields
\addtoreffields{yourref}
\addtoreffields{myref}

% modify the way reference fields are printed matching the
% TUM Corporate Design Word templates
\renewcommand*{\@set@reffield}[1]{%
  \ifkomavarempty{#1}{}{%
    \if@tempswa\hspace{10mm}\fi%
    \mbox{\usekomafont{refname}\usekomavar*{#1}:}%
    \mbox{\usekomafont{refvalue}~\usekomavar{#1}}%
    \@tempswatrue%
  }%
}

% scrlttr2 treats the date field differently if references are printed or not.
% According to the TUM Corporate Design the date should always be printed on
% the left side of the reference line. The references (if defined) are flushed
% to the right.
% By changing this macro, the KOMAoptions modifying the behaviour of the
% reference line are silently ignored.
\renewcommand*{\@datefield}{%
  \begingroup%
  \setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative%
  \move@topt\vskip\useplength{refvpos}%
  \rlap{\noindent\move@topl\hskip\useplength{refhpos}%
    \vbox{\hsize\useplength{refwidth}%
      \noindent\usekomafont{placeanddate}%
      \ifkomavarempty{place}{}{\usekomavar{place}\usekomavar{placeseparator}}%
      \usekomavar{date}\hfill%
      \let\do@set@reffield\@set@reffield%
      \@set@reffields}}%
  \vskip\useplength{refaftervskip}%
  \endgroup%
}

% Subject
\@setplength{subjectbeforevskip}{0mm}
\@setplength[2]{subjectaftervskip}{\baselineskip}
\setkomafont{subject}{\sffamily\normalsize\bfseries}
\KOMAoptions{subject=beforeopening, subject=untitled}

% Signature
\@setplength{sigindent}{0mm}
\@setplength[3.5]{sigbeforevskip}{\baselineskip}
\renewcommand*{\raggedsignature}{\raggedright}

% Enclosures
\setkomavar{enclseparator}[\enclname]{: }


% .:: Footer content
% ----------------------------------------------------------------------------

% KOMA variables to store the content of the four footer columns
\newkomavar{tum.footer.col1}
\newkomavar{tum.footer.col2}
\newkomavar{tum.footer.col3}
\newkomavar{tum.footer.col4}

% KOMA pseudo lengths for the footer column widths
\@newplength{tum.footcolsep}
\@newplength{tum.footwidth.col1}
\@newplength{tum.footwidth.col2}
\@newplength{tum.footwidth.col3}
\@newplength{tum.footwidth.col4}
\@newplength{tum.footwidth.total}
\@newplength{tum.footheight.max}
\@newplength{tum.footheight}

\@setplength{tum.footcolsep}{2mm}
\@setplength{tum.footwidth.col1}{44mm}
\@setplength{tum.footwidth.col2}{44mm}
\@setplength{tum.footwidth.col3}{35mm}
\@setplength{tum.footwidth.col4}{36mm}
\@setplength{tum.footheight.max}{130.5pt} % max should be 15 lines

% configure default content of footer columns
% according to the TUM Corporate Design
\newcommand{\TUMdefaultfooter}{
  \setkomavar{tum.footer.col1}{%
    \textbf{\theUniversityName}\\\theDepartmentName\\\theChairName%
  }
  \setkomavar{tum.footer.col2}{%
    \textbf{\usekomavar{fromname}}\\\usekomavar{fromaddress}%
  }
  \setkomavar{tum.footer.col3}{%
    \makebox[\widthof{Fax:}][l]{Tel:}~%
    \TUMPhoneNumber{\usekomavar{fromphone}}\\
    \ifkomavarempty{fromfax}{}{%
      Fax:~\TUMPhoneNumber{\usekomavar{fromfax}}\\}
    \vspace{\baselineskip}
    \ifkomavarempty{fromemail}{}{%
      \usekomavar[\edef\tempvar]{fromemail}\TUMEmail{\tempvar}\\}
    \ifkomavarempty{fromurl}{}{%
      \usekomavar[\edef\tempvar]{fromurl}\TUMWebsite{\tempvar}\\}
    \TUMWebsite{www.tum.de}
  }
  \setkomavar{tum.footer.col4}{%
    \theBankName\\IBAN: \theBankIBAN\\BIC:~\theBankBIC\\
    \taxidname:~\theTaxId\\\vatidname:~\theVatId
  }
}
\TUMdefaultfooter

% LaTeX boxes to store the content of footer columns
\newsavebox{\@tum@footer@one@}
\newsavebox{\@tum@footer@two@}
\newsavebox{\@tum@footer@three@}
\newsavebox{\@tum@footer@four@}
\newsavebox{\@tum@footer@}

% Generate the footer column boxes at the beginning of the letter
\AtBeginLetter{
  \savebox{\@tum@footer@one@}{\parbox[t]{\useplength{tum.footwidth.col1}}{%
      \usekomafont{pagefoot}\usekomavar{tum.footer.col1}}}
  \savebox{\@tum@footer@two@}{\parbox[t]{\useplength{tum.footwidth.col2}}{%
      \usekomafont{pagefoot}\usekomavar{tum.footer.col2}}}
  \savebox{\@tum@footer@three@}{\parbox[t]{\useplength{tum.footwidth.col3}}{%
      \usekomafont{pagefoot}\usekomavar{tum.footer.col3}}}
  \savebox{\@tum@footer@four@}{\parbox[t]{\useplength{tum.footwidth.col4}}{%
      \usekomafont{pagefoot}\usekomavar{tum.footer.col4}}}
  \savebox{\@tum@footer@}{\parbox{\useplength{firstfootwidth}}{%
      \usebox{\@tum@footer@one@}\hfill\usebox{\@tum@footer@two@}\hfill%
      \usebox{\@tum@footer@three@}\hfill\usebox{\@tum@footer@four@}}}
  % calculate total footer height and set vertical position accordingly
  \@setplength{tum.footheight}{\ht\@tum@footer@}
  \@addtoplength{tum.footheight}{\dp\@tum@footer@}
  \@setplength{firstfootvpos}{\paperheight}
  \@addtoplength{firstfootvpos}{-\useplength{tum.footheight}}
  \@addtoplength{firstfootvpos}{-10mm}
  % calculate total footer width
  \@setplength{tum.footwidth.total}{\useplength{tum.footwidth.col1}}
  \@addtoplength{tum.footwidth.total}{\useplength{tum.footwidth.col2}}
  \@addtoplength{tum.footwidth.total}{\useplength{tum.footwidth.col3}}
  \@addtoplength{tum.footwidth.total}{\useplength{tum.footwidth.col4}}
  \@addtoplength[3]{tum.footwidth.total}{\useplength{tum.footcolsep}}
  % throw class warnign if foothight exceedes 15 lines
  \ifdimgreater{\useplength{tum.footheight}}{
    \useplength{tum.footheight.max}
  }{
    \ClassWarningNoLine{tumletter}{%
      The hight of your footer exceedes
      \the\useplength{tum.footheight.max}.\MessageBreak
      The TUM Corporate Design recommends using\MessageBreak
      no more than 15 lines in the footer}
  }{}
  % throw class warning if footwidth exceedes allowed textwidth
  \ifdimgreater{\useplength{tum.footwidth.total}}{
    \useplength{firstfootwidth}
  }{
    \ClassWarningNoLine{tumletter}{%
      The width of your footer columns and\MessageBreak
      separators add up to \the\useplength{tum.footwidth.total}.\MessageBreak
      This is larger than the maximum allowed\MessageBreak
      footer width of \the\useplength{firstfootwidth}.\MessageBreak
      Consider decreasing your column widths}
  }{}
}

% helper macros to typeset footer content
\newcommand*{\TUMWebsite}[1]{\href{http://#1}{#1}}
\newcommand*{\TUMEmail}[1]{\href{mailto:#1}{#1}}
\newcommand*{\TUMPhoneNumber}[1]{+49\:(89)\:289\:-\:#1}
\newcommand*{\TUMPhoneNumbers}[2][]{%
  \makebox[\widthof{Fax:}][l]{Tel:}~\TUMPhoneNumber{#2}
  \ifblank{#1}{}{\\Fax:~\TUMPhoneNumber{#1}}
}


% .:: Captions for Enclosures and bank information
% ----------------------------------------------------------------------------

\provideName{\enclname}{encl.}{Anlage}
\provideName{\taxidname}{Tax~ID}{Steuer-Nr.}
\provideName{\vatidname}{VAT~ID}{USt-IdNr.}


% .:: Set default values of KOMA Variables according to tumuser.sty
% ----------------------------------------------------------------------------

% author contact information
\setkomavar{fromname}{%
  \ifdefempty{\theAuthorTitlePrefix}{}{\theAuthorTitlePrefix\ }%
  \theAuthorName%
  \ifdefempty{\theAuthorTitleSuffix}{}{\ \theAuthorTitleSuffix}%
}
\setkomavar{fromemail}{\theAuthorEmail}
\setkomavar{fromphone}{\theAuthorPhoneExt}
\setkomavar{fromfax}{\theAuthorFaxExt}
\setkomavar{fromurl}{\theAuthorWebsite}
% author address
\setkomavar{fromaddress}{\theAuthorAddress\\\theAuthorZipCode~\theAuthorCity}
% default back address
\setkomavar{backaddress}{\theUniversityName\\\usekomavar{fromaddress}}
\setkomavar{backaddress2}{}
% default place and date
\setkomavar{place}{\theAuthorCity}
\setkomavar{date}{\today}
% default signature
\setkomavar{signature}{\usekomavar{fromname}}


% .:: Set default PDF metadata
% ----------------------------------------------------------------------------

\provideName{\@tum@letterto@}{Letter to}{Brief an}

\AtBeginLetter{
  \begingroup
  \renewcommand{\@}{}
  \usekomavar[\def\@tum@pdfauthor@]{fromname}
  \usekomavar[\def\@tum@pdfsubject@]{subject}
  \usekomavar[\def\@tum@pdfrecipient@]{toname}
  \hypersetup{
    pdftitle = {\@tum@letterto@~\@tum@pdfrecipient@},
    pdfauthor = {\@tum@pdfauthor@},
    pdfsubject = {\@tum@pdfsubject@},
    % pdfkeywords = {},
    pdfcreator = {\theUniversityName}
  }
  \endgroup
}

% avoid opening of bookmarks tree in pdf viewer
\hypersetup{
  pdfpagemode=UseNone,
  pdfpagelayout=SinglePage,
}

% hide links
\if@tum@hidelinks@
  \hypersetup{hidelinks}
\fi
