% -- Encoding UTF-8 without BOM

\ProvidesClass{cv-style}[2015/02/27 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%----------------------------------------------------------------------------------------
% Colors %
%----------------------------------------------------------------------------------------

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{262626}
\definecolor{mediumgray}{HTML}{444444}
\definecolor{gray}{HTML}{555555}
\definecolor{lightgray}{HTML}{888888}

\definecolor{blue}{HTML}{3399FF}
\definecolor{red}{HTML}{F0506E}
\definecolor{orange}{HTML}{FF9419}
\definecolor{green}{HTML}{A7E22E}
\definecolor{purple}{HTML}{9358FE}
\definecolor{aquamarine}{HTML}{36AF90}
\definecolor{twitter}{RGB}{85,172,238}

\definecolor{date}{HTML}{A4A4A4}


\colorlet{textcolor}{gray}
\colorlet{headercolor}{mediumgray}

\ifdefined\@cv@print
  \colorlet{blue}{headercolor}
  \colorlet{red}{headercolor}
  \colorlet{orange}{headercolor}
  \colorlet{green}{headercolor}
  \colorlet{purple}{headercolor}
  \colorlet{aquamarine}{headercolor}
  \colorlet{twitter}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{darkgray}
\else
  \colorlet{fillheader}{darkgray}
  \colorlet{header}{white}
\fi

%----------------------------------------------------------------------------------------
% Fonts %
%----------------------------------------------------------------------------------------

\RequirePackage[quiet]{fontspec}
\RequirePackage{unicode-math}
\RequirePackage{fontawesome5}

% download and install Inter from https://rsms.me/inter/
\newfontfamily\bodyfont[]{Inter Regular}
\newfontfamily\bodyfontit[]{Inter Italic}
\newfontfamily\thinfont[]{Inter Extra Light}
\newfontfamily\headingfont[]{Inter Bold}
% https://github.com/tonsky/FiraCode
\newfontfamily\monospacefont[]{Fira Code Regular}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor]{Inter Light}

\newcommand{\italica}[1]{%
    {\color{gray}\bodyfontit #1}%
}

\newcommand{\code}[1]{%
    {\color{gray}\monospacefont #1}%
}

%----------------------------------------------------------------------------------------
% Header %
%----------------------------------------------------------------------------------------

\RequirePackage{tikz}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=3cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\headingfont #1 #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{0.75cm}
}

%----------------------------------------------------------------------------------------
%   Last updated command %
%----------------------------------------------------------------------------------------

\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{polyglossia}

\setlength{\TPHorizModule}{0.01\paperwidth}
\setlength{\TPVertModule}{0.01\paperwidth}

\newcommand{\lastupdated}{ 
  \begin{textblock}{10}(11.3, 0.2)
    \raggedleft
    \fontsize{10pt}{12pt}\color{date}\thinfont 
    Updated on \today
  \end{textblock}}

%----------------------------------------------------------------------------------------
% Structure %
%----------------------------------------------------------------------------------------
\RequirePackage{parskip}
\usepackage[none]{hyphenat}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        red\or%
        orange\or%
        green\or%
        purple\or%
        aquamarine\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  {\par\vspace{0.75\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{0.5\parskip}}
}

\renewcommand{\subsection}[2]{
  \par\vspace{0.5\parskip}%
  \Large\headingfont\color{headercolor} #2%
  \par\vspace{0.25\parskip}%
}

\newcommand{\jobtitle}[2][]{%
    {\color{mediumgray}\bodyfontit #2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #1}
}

\pagestyle{empty}

%----------------------------------------------------------------------------------------
% List environment %
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  #1&\parbox[t]{11.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}

%----------------------------------------------------------------------------------------
% Side block %
%----------------------------------------------------------------------------------------

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{3.6}(1.5, 3)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%----------------------------------------------------------------------------------------
% Other tweaks %
%----------------------------------------------------------------------------------------

\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=5.5mm}

% used for formatting updated date to ISO format
\RequirePackage{datetime2}


\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=1cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true, % while it is set to color links, it doesn't actually do that, but it disables the border, which is what we want
    pdftitle={CV/Resume \textbar{} Brian Mitchell},
    pdfauthor={Brian Mitchell},
    pdfsubject={CV/Resume}
}
