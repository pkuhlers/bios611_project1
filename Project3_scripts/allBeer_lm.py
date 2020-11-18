import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import os
from plotnine import ggplot, aes, labs, geom_point, geom_text, annotate, stat_smooth, positions

os.chdir("/home/rstudio")
beer = pd.read_csv("derived_data/allBeer_state_aggregated.csv")

barrels = beer.loc[:, 'barrels'].values.reshape(-1, 1)
crude_rate = beer.loc[:, 'crude.rate'].values.reshape(-1, 1) 

## Linear model of barrels vs crude
lm = LinearRegression()
model = lm.fit(barrels, crude_rate)
pred = lm.predict(barrels)
r2 = model.score(barrels, crude_rate)

## Plot barrels and crude rate
g = (ggplot(beer, aes(x = 'barrels', y = 'crude.rate')) + 
 geom_point(color = 'black') + 
 geom_text(aes(label = 'year'),
           position = positions.position_nudge(0,1)) + 
 stat_smooth(aes(x = 'barrels', y = 'crude.rate'), color = 'blue',
             method = 'lm',
             se = False) + 
 labs(title = "Crude Rate versus Beer Production", 
 x = "Ten Thousands of Barrels", 
 y = "Deaths per Million") + 
 annotate("text", x = 18250, 
          y = 65, 
          label = "R2:" + str(round(r2, 3))))
g.save("figures/allBeer_crudeRate_lm_p9.png")

g2 = (ggplot(beer, aes(x = 'year', y = 'barrels')) + 
 geom_point() +
 labs(title = "National Beer Production 2008-2015",
      x = "Ten Thousands of Barrels",
      y = "Year"))
g2.save("figures/allBeer_years_p9.png")

g3 =  (ggplot(beer, aes(x = 'year', y = 'crude.rate')) + 
  geom_point() + 
  labs(title = "National Liver Disease Mortality 2008-2015",
       x = "Year", 
       y = "Mortality per Million"))
g3.save("figures/allBeer_liver_years_p9.png")