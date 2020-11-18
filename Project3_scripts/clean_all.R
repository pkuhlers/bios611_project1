library(openxlsx)
library(tidyverse)
#library(plotly)
## cleans all 
beerTav <- read.xlsx(xlsxFile = "source_data/aggr-data-beer_2008-2019.xlsx",
                     startRow = 7,
                     sheet = "Tax Determined (Premise Use)",
                     rows = 1:62, rowNames = T) %>% 
  rename_with(~ gsub(pattern = "[**]",                                                          
                     replacement = "",
                     .x))
beerTav$"2008" <- as.numeric(beerTav$"2008")
beerTav[is.na(beerTav)] <- 0

beerBot <- read.xlsx(xlsxFile = "source_data/aggr-data-beer_2008-2019.xlsx",
                     startRow = 7,sheet = "Taxable Bottles and Cans",
                     rows = 1:62, rowNames = T)
beerBot$"2008" <- as.numeric(beerBot$"2008")
beerBot[is.na(beerBot)] <- 0

beerKeg <- read.xlsx(xlsxFile = "source_data/aggr-data-beer_2008-2019.xlsx",
                     startRow = 7,
                     sheet = "Taxable Barrels and Kegs", 
                     rows = 1:62, rowNames = T)
beerKeg$"2008" <- as.numeric(beerKeg$"2008")
beerKeg[is.na(beerKeg)] <- 0

beer <- (beerTav + beerBot + beerKeg)
beer <- beer[-dim(beer)[1],]

beerTidy <- beer %>% 
  rownames_to_column("STATE") %>%
  pivot_longer(cols = !STATE ,
               names_to = "year",
               values_to = "barrels",
               values_ptypes = list(year = numeric(),barrels=numeric())) 
beerTidy$year <- as.numeric(beerTidy$year)
names(beerTidy) <- tolower(names(beerTidy))

write.csv(beerTidy,"derived_data/tidy_allBeer_consump.csv")

liverTidy <- read.csv("derived_data/tidy_liver_mortality.csv")
comb_data <- inner_join(beerTidy, 
                        liverTidy,
                        by = c("state", "year"))
write.csv(comb_data,"derived_data/combined_allBeer_liver.csv")
