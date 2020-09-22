install.packages("openxlsx")
library(openxlsx)
x1 <- read.xlsx("source_data/covid19-table1-2020-05.xlsx",startRow = 2) ## Teleworking by age & edu
x2 <- read.xlsx("source_data/covid19-table10-2020-05.xlsx") ## Not in work force and not looking distribution
x3 <- read.xlsx("source_data/covid19-table2-2020-05.xlsx") ## Teleworked by industry
x4 <- read.xlsx("source_data/covid19-table4-2020-05.xlsx") ## Unable to work by age & edu
x5 <- read.xlsx("source_data/covid19-table5-2020-05.xlsx")
x6 <- read.xlsx("source_data/covid19-table6-2020-05.xlsx")
x7 <- read.xlsx("source_data/covid19-table7-2020-05.xlsx") ## Unable to work by industry
x8 <- read.xlsx("source_data/covid19-table9-2020-05.xlsx") ## Not in labor force & not looking totals
