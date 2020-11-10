Bios 611 Project 1
==================
- [Introduction](#introduction)  
- [Usage](#how-to-use-this-project)  
  * [Report](#report)
  * [Shiny Dashboard](#shiny-dashboard)

Introduction
============
Alcoholic Beverage Consumption and Liver Disease
------------------------------------------------

Excessive alcohol consumption can cause a myriad of health problems, one of which is liver disease. An interesting observation from lung cancer is that as the prevalence of smoking decreased, the prevalence of lung cancer slowly ticked down as well. This project will investigate whether a similar trend can be observed from alcohol consumption and alcoholic liver disease. This project will use state level data of liver disease deaths from the CDC and state level data of taxable barrels from the Alcohol and Tobacco Tax and Trade Bureau.

The current version of the project will use taxable barrels as a proxy for overall consumption -- since likely brewers would not produce beer that is not meant to be consumed. Additionally, the first analysis will look at beer consumption, but wine and distilled spirits will be added.

Preliminary analysis shows that the amount of beer produced for consumption remained relatively constant but in recent years has seen a dramatic increase (the Alcohol and Tobacco Tax and Trade Bureau says this is because of an increase in small breweries).

![Beer Production](assets/barrels_by_state.png)

Data from the CDC shows that there has been a steady increase in the crude rate of alcoholic liver disease over the past few years, which may be related to the recent increase in alcohol consumption.

![Liver Mortality](assets/crude_rate_by_state.png)

How To Use This Project
=======================

To run this project, you will need Docker:

    > docker build . -t project1-env
    > docker run -v `pwd`:/home/rstudio -p 8787:8787 -p 8788:8788\
     -e PASSWORD=<yourpassword> -t project1-env

Then connect to port 8787.

Report
------
The Makefile is a good place to understand the dependencies of the project. To make the entire report, run the following line within the Rstudio terminal:

    > make report.pdf
    
Shiny Dashboard
---------------
To start the shiny dashboard, make sure you are connected to port 8787. Then within the rstudio terminal, run:

    > make beer_mortality_shiny

Then connect to port 8788.
    

