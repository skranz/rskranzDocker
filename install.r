# install required R packages

library(methods)

path = .libPaths()[1]
glob.overwrite = TRUE
path = "/usr/local/lib/R/site-library"

success = failed = NULL

from.cran = function(pkg, lib = path, overwrite = glob.overwrite,...) {
  if (!overwrite) {
    if (require(pkg,character.only = TRUE)) {
      cat("\npackage ",pkg," already exists.")
      return()
    }
  }
  res = try(install.packages(pkg, lib=lib))
  if (require(pkg,character.only = TRUE)) {
    success <<- c(success,pkg)
  } else {
    failed <<- c(failed,pkg)
  }
}

from.github = function(pkg, lib = path, ref="master", overwrite = glob.overwrite,upgrade_dependencies = FALSE,...) {
  repo = pkg
  pkg = strsplit(pkg,"/",fixed=TRUE)[[1]]
  pkg = pkg[length(pkg)]

  if (!overwrite) {
    if (require(pkg,character.only = TRUE)) {
      cat("\npackage ",pkg," already exists.")
      return()
    }
  }

  library(devtools)
  res = try(
  with_libpaths(new = path,
    install_github(repo,ref = ref,upgrade_dependencies = upgrade_dependencies,...)
  ))
  if (require(pkg,character.only = TRUE)) {
    success <<- c(success,pkg)
  } else {
    failed <<- c(failed,pkg)
  }

}



# First install all required linux software
from.cran("curl",lib = path)
from.cran("openssl",lib = path)
#from.cran("devtools", lib=path)
from.cran("roxygen2", lib=path)
from.cran("DT",lib = path)
from.cran("formatR",lib = path)
#from.cran("dplyr",lib = path)

#from.cran("knitr",lib = path)
from.cran("shinyjs",lib = path)
from.cran("V8",lib = path)
#from.cran("rmarkdown", lib=path)
## apt-get install libv8-dev

from.cran("rJava",lib = path)
from.cran("mailR",dep=TRUE, lib=path)

#from.cran("shiny",lib = path)
from.cran("shinyBS",lib = path)
from.cran("shinyAce",lib = path)

from.cran("RColorBrewer",lib = path)
from.cran("memoise", lib=path)

from.cran("mime", lib=path)

from.cran("xtable", lib=path)
#from.cran("RJSONIO", lib=path)

#from.cran("readr", lib=path)

from.cran("texreg", lib=path)
from.cran("lmtest", lib=path)
from.cran("DescTools", lib=path)

#from.cran("tidyr",lib=path)


#from.cran("RAppArmor",lib = path)

# Install github packages
from.github(lib=path,"rstats-db/DBI",ref = "master", overwrite=!TRUE)
from.github(lib=path,"rstats-db/RSQLite",ref = "master", overwrite=!TRUE)

from.github(lib=path,"skranz/restorepoint",ref = "master")
from.github(lib=path,"skranz/stringtools",ref = "master")
from.github(lib=path,"skranz/codeUtils",ref = "master")
from.github(lib=path,"skranz/rmdtools",ref = "master")
from.github(lib=path,"skranz/dplyrExtras",ref = "master")
from.github(lib=path,"skranz/dbmisc",ref = "master")
#from.github(lib=path,"skranz/rowmins",ref = "master", overwrite=!TRUE)

from.github(lib=path,"skranz/shinyEvents",ref = "develop")
from.github(lib=path,"skranz/shinyEventsUI",ref = "master")
from.github(lib=path,"skranz/shinyEventsLogin",ref = "master")


#from.github(lib=path,"skranz/loginPart",ref = "master")

#from.github(lib=path,"skranz/armd",ref = "master")
#from.github(lib=path,"skranz/RTutor3",ref = "master")


cat("\n\nFailed installations:\n")
print(failed)

cat("\n\nSuccessfully installed:\n")
print(success)
