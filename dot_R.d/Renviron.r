## set precedence of libs
R_LIBS=${R_LIBS_SITE}

## setting R User Library path
R_LIBS_USER="~/.R.d/library"

## macrtools - gfortran: start
PATH=${PATH}:/opt/gfortran/bin
## macrtools - gfortran: end

## TeX
R_LATEXCMD="/Library/TeX/texbin/latex"
R_PDFLATEXCMD="/Library/TeX/texbin/pdflatex"

# pandoc
#RSTUDIO_PANDOC="/Users/frems/bin"
#PATH="/Users/frems/bin:${PATH}"

#options(citr.use_betterbiblatex = FALSE)
