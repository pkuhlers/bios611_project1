library(openxlsx)
library(tidyverse)
#library(plotly)
## Cleans the beer dataset (premise use only!!)
## Cleans the liver mortality data and joins with on-premise beer data
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
names(beerTidy) <- tolower(names(beerTidy))

write.csv(beerTidy,"derived_data/tidy_beer_consump.csv")

## Liver disease
liver <- read.table("source_data/mortality.txt",
                    header = T,
                    sep = "\t",
                    colClasses = c("NULL",NA,"NULL",NA,"NULL",NA,NA,NA),
                    nrows = 867)

liverTidy <- liver %>%
  mutate(Crude.Rate = str_replace(Crude.Rate,
                                  pattern = ".Unreliable.",
                                  replacement = ""))

liverTidy$Crude.Rate <- as.numeric(liverTidy$Crude.Rate)
names(liverTidy) <- tolower(names(liverTidy))
liverTidy$state <- state.abb[match(liverTidy$state,state.name)]

write.csv(liverTidy, file = "derived_data/tidy_liver_mortality.csv")

comb_data <- inner_join(beerTidy, 
                       liverTidy,
                       by = c("state", "year"))
write.csv(comb_data,"derived_data/combined_beer_liver.csv")
