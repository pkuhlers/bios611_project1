FROM rocker/verse
MAINTAINER Peyton Kuhlers <pkuhlers@unc.edu>
RUN echo "Hello World"
RUN R -e "install.packages('openxlsx',dependencies=TRUE, repos='http://cran.rstudio.com/')"
#RUN R -e "install.packages('plotly', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('car', dependencies=TRUE, repos='http://cran.rstudio.com/')"
