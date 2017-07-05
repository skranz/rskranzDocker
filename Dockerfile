FROM rocker/tidyverse

# News: Base now on rocker/rstudio since shiny is now supported

# based on skranz/shinyrstudio
# so we already have
# rstudio + shiny + tidverse R packages

MAINTAINER Sebastian Kranz "sebastian.kranz@uni-ulm.de"

RUN export ADD=shiny && bash /etc/cont-init.d/add

RUN apt-get update && apt-get install -y \
  default-jre \
  libv8-3.14-dev

# copy and run package installation file
COPY install.r /tmp/install.r
RUN Rscript /tmp/install.r
