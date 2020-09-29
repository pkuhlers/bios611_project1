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

png("assets/barrels_by_state.png")
beerTidy %>%
  ggplot(aes(x = year, y = barrels, color = STATE)) + 
  geom_line(show.legend = F) +
  coord_cartesian(xlim = c(2008,2019)) + 
  scale_x_continuous(name = "Year", 
                     breaks = seq(2008,2019,2),
                     limits = c(2008,2019)) +
  labs(y= "Barrels",
       title = "Barrels of Beer Prouduced from 2008 - 2009")
dev.off()
         