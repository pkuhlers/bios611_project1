library(openxlsx)
library(tidyverse)

beer <- read.xlsx(xlsxFile = "source_data/aggr-data-beer_2008-2019.xlsx",
                  startRow = 7)
beer$"2008" <- as.numeric(beer$"2008")

beer %>%
  rename_with(~ gsub(pattern = "[**]",
                     replacement = "", 
                     .x)) %>%
  slice(n = -(52:57)) %>%
  pivot_longer(cols = !STATE,
               names_to = "year",
               values_to = "barrels",
               values_ptypes = list(year = numeric(),barrels=numeric())) -> beerTidy
beerTidy$year <- as.numeric(beerTidy$year)

beerTidy %>%
  ggplot(aes(x = year, y = barrels, color = STATE)) + geom_line()
         