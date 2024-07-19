This article documents some ideas about the best way to upgrade R libraries.

### Mac OS X

## CRAN Installer Package
On Mac OS X the R base package is installed to the folder /Library/Frameworks/R.framework by default. Inside this folder there are several simlinks pointing to subfolders inside another symlink named /Versions/Current, which is pointing to the folder with the active R installation. The real data is stored in subfolders inside /Versions which are denoting the respective R version number. By default the Subfolder /Resources/library contains the installed libraries.

Optionally users can install private packages in their ~/Library/R/x.y/library directory where x.y denotes the R version without the patch level (such as 2.14) - see startup preferences.

If you happen to use install.packages R function instead of the Package Installer, the regular unix behavior applies (see help pages for details). For default setup this means that the packages are installed according to the startup preference setting. You can check the current defaults by issuing

.libPaths()

## custom library path
A cutom library path can be set via .Renviron

## Mac Ports
I case R was installed via the r-framework port in Mac Ports, R binary is in /opt/local/bin/R.

## Debian

# binary packages
The easiest way to install R packages is as .deb packge via apt-get. Unfortunately far from all packages have available a corresponding .deb packages for installation. Fortunately there are binary R packages for i386 and amd64 architectures available as well.

# compiling from source
If you are working on a platform other than i386 or amd64 or in case you need a custom setup or want to keep up with bleeding edge development the best option is to compile everything from source. For easy maintainance it is a good idea to compile everything from source instead of mixing packages that are available as .deb packages and those compiled from source. The main obstacle when compiling from source is to meet the requirements for compilation.

To install an R framework ready for compiling R packages
1. add source of backport of the latest R release to /etc/apt/sources.list. i.e. deb http://<favorite-cran-mirror>/bin/linux/debian squeeze-cran/ where <favorite-cran-mirror> must be substituted by one of the mirror URLs listed in http://cran.r-project.org/mirrors.html
2. run apt-get update
3. run apt-get install r-base r-base-dev

This should suffice for most packages. But some R packages require additional software. How to meet these requirements? In many cases there is a .deb package availabel for those "complex" libraries with special requirements. If so, the .deb package can help you understanding the build-dependencies of a R package. To have a look at the dependencies run apt-cache depends <package> (i.e. apt-cache depends r-cran-rgl)
To install only the dependencies of a package, but NOT the package itself run apt-get build-dep <package> (i.e. apt-get build-dep r-cran-rgl).

# old R installation
oldpckgs<-.packages(TRUE)
save(oldpckgs, file="oldpckgs20130614.rda")
length(oldpckgs)

# new R installation
preinstpckgs<-.packages(TRUE)
save(preinstpckgs, file="preinstpckgs.rda")
length(preinstpckgs)

setwd~("/R")
load("preinstpckgsDebianSqueeze.rda")
load("oldpckgs20130614.rda")
length(oldpckgs)

pckgstoinst <- oldpckgs[-which(oldpckgs %in% preinstpckgs)]
save(pckgstoinst, file="pckgstoinst.rda")
length(pckgstoinst)

load("pckgstoinst.rda")
update.packages(checkBuilt=TRUE)
# the following will install in first directory of .libPaths(). Choose a differetn folder by adding lib="path/to/folder"
install.packages(pckgstoinst, type="source", dependencies=TRUE)

#check after installation
instpckgs<-.packages(TRUE)
#should be TRUE
pckgstoinst %in% instpckgs

# install missing packages
pckgsleft <- oldpckgs[-which(oldpckgs %in% instpckgs)]
install.packages(pckgsleft, type="source", dependencies=TRUE)

#
identical(oldpckgs,instpckgs)

library(compare)
compare(oldpckgs,instpckgs,allowAll=TRUE)

match(instpckgs,oldpckgs)

.libPaths()
[1] "/Library/Frameworks/R.framework/Versions/2.14/Resources/library"

#special packages
install.packages("tikzDevice", repos="http://R-Forge.R-project.org")

source("http://bioconductor.org/biocLite.R")
biocLite("Rgraphviz")
biocLite() # for Bioconductor basic install

# RMySQL

R CMD INSTALL ~/Downloads/RMySQL_0.9-3.tar.gz --configure-args="--with-mysql-dir=/usr/local/mysql" "--with-mysql-inc=/usr/local/mysql/include" "--with-mysql-lib=/usr/local/mysql/lib"

1. Define and export the 2 shell variables PKG_CPPFLAGS and
   PKG_LIBS to include the directory for header files (*.h)
   and libraries, for example (using Bourne shell syntax):

      export PKG_CPPFLAGS="-I<MySQL-include-dir>"
      export PKG_LIBS="-L<MySQL-lib-dir> -lmysqlclient"

   Re-run the R INSTALL command:

      R CMD INSTALL RMySQL_<version>.tar.gz

2. Alternatively, you may pass the configure arguments
      --with-mysql-dir=<base-dir> (distribution directory)
   or
      --with-mysql-inc=<base-inc> (where MySQL header files reside)
      --with-mysql-lib=<base-lib> (where MySQL libraries reside)
   in the call to R INSTALL --configure-args='...' 

   R CMD INSTALL --configure-args='--with-mysql-dir=DIR' RMySQL_<version>.tar.gz

* Windows
