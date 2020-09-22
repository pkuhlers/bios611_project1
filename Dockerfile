FROM rocker/verse
MAINTAINER Peyton Kuhlers <pkuhlers@unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages("openxlsx")"
