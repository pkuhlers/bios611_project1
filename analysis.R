library(tidyverse)
#library(plotly)
library(car)

## Beer consumption
beerTidy <- read.csv("derived_data/tidy_beer_consump.csv")

png("assets/barrels_by_state.png")
beerTidy %>%
  ggplot(aes(x = year, y = barrels, color = state)) + 
  geom_line(show.legend = F) +
  coord_cartesian(xlim = c(2008,2019)) + 
  scale_x_continuous(name = "Year", 
                     breaks = seq(2008,2019,2),
                     limits = c(2008,2019)) +
  labs(y= "Barrels",
       title = "Barrels of Beer Produced from 2008 - 2009")
dev.off()

## Crude death rate by state
liverTidy <- read.csv("derived_data/tidy_liver_mortality.csv")

png(filename = "assets/crude_rate_by_state.png")
liverTidy %>%
  ggplot(aes(x = year, y = crude.rate, color = state)) + 
  geom_line(show.legend = F) +
  coord_cartesian(xlim = c(2008,2015)) + 
  scale_x_continuous(name = "Year", 
                     breaks = seq(2008,2015,2),
                     limits = c(2008,2015))
dev.off()

comb_data <- read.csv("derived_data/combined_beer_liver.csv")
png(filename = "figures/barrels_vs_crudeRate.png")
ggplot(comb_data, aes(x = barrels, y = crude.rate, color = state)) +
  geom_point(show.legend = F)
dev.off()

model1 <- lm(crude.rate ~ barrels + year, data = comb_data)
summary(model1)

png(filename = "figures/avPlots.png")
avPlots(model1)
dev.off()