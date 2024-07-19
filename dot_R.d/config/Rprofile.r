
## loading essential libraries
#defPack <- getOption("defaultPackages")
#options(defaultPackages = c(defPack, "tikzDevice"))

## options
options(width=170)

## loading custom functions
source("~/.R.d/functions/regr.r") # functions for regression from Werner Stahel
source("~/.R.d/functions/draw.contour.r")
source("~/.R.d/functions/expand.dft.r")
source("~/.R.d/functions/saveTrianglesAsASY.r")
source("~/.R.d/functions/relweights.r")

# set JAVA_HOME for rJava
Sys.setenv('JAVA_HOME' = '$(/usr/libexec/java_home)')
