library(tidyverse)
library(plotly)
library(car)
## Analysis of premise + bottle + keg beer
## Beer consumption
beerTidy <- read.csv("derived_data/tidy_allBeer_consump.csv")

## All beer
png("assets/allBarrels_by_state.png")
beerTidy %>%
  ggplot(aes(x = year, y = barrels, color = state)) + 
  geom_line(show.legend = F) +
  coord_cartesian(xlim = c(2008,2019)) + 
  scale_x_continuous(name = "Year", 
                     breaks = seq(2008,2019,2),
                     limits = c(2008,2019)) +
  labs(y= "Barrels",
       title = "Barrels of Beer Produced from 2008 - 2019") 
dev.off()

comb_data <- read.csv("derived_data/combined_allBeer_liver.csv")

png(filename = "figures/all_barrels_vs_crudeRate.png")
ggplot(comb_data, aes(x = barrels, y = crude.rate, color = state)) +
  geom_point(show.legend = F)
dev.off()

model1 <- lm(crude.rate ~ barrels + year, data = comb_data)
summary(model1)
saveRDS(model1, file = "derived_data/lm_all_barrel_year.rds")

png(filename = "figures/all_beer_avPlots.png")
avPlots(model1)
dev.off()
