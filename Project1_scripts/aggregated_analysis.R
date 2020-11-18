## Aggregate the state data and run analysis
library(tidyverse)
library(ggrepel)
comb <- read.csv("derived_data/combined_beer_liver.csv")

## Scale barrels to 10,000 barrels
aggr <- comb %>%
  group_by(year) %>%
  summarise(deaths = sum(deaths), 
            pop = sum(population), 
            barrels = sum(barrels,na.rm = T)/1e4)

## Change deaths/pop to deaths / mil
aggr$crude.rate <- aggr$deaths / aggr$pop * 1e6


ggplot(data = aggr, aes(x = year, y = crude.rate)) +
  geom_line()

ggplot(data = aggr, aes(x = year, y = barrels)) +
  geom_line()

png("figures/aggregated_mortality_barrels.png")
ggplot(data = aggr, aes(x = barrels, y = crude.rate, label = year)) +
  geom_point() +
  stat_smooth(method = "loess", se = F, formula = y ~ x) +
  geom_text_repel(size = 4) + 
  labs(x = "Ten Thousands of Barrels",
       y = "Crude Mortality per Million",
       title = "National Alcoholic Liver Mortality and Beer Production")
dev.off()

