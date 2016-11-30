FROM skranz/shinyrstudio:latest

# based on skranz/shinyrstudio
# so we already have
# rstudio + shiny + hadleyverse R packages

MAINTAINER Sebastian Kranz "sebastian.kranz@uni-ulm.de"

# copy and run package installation file
COPY install.r /tmp/install.r
RUN Rscript /tmp/install.r
