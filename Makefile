.PHONY: beer_mortality_shiny

## Project 3 dependencies - python/R analysis + all beer (on premise + bottle + keg)
python-report.pdf:\
 ~/Project3_scripts/python-report.Rmd\
 ~/assets/allBarrels_by_state.png\
 ~/assets/crude_rate_by_state.png\
 ~/figures/aggregated_mortality_barrels.png\
 ~/figures/allBeer_crudeRate_lm_p9.png
	Rscript -e "rmarkdown::render('~/Project3_scripts/python-report.Rmd',\
    output_format='pdf_document',\
    output_dir='~')"
    
figures/allBeer_crudeRate_lm_p9.png:\
 derived_data/allBeer_state_aggregated.csv\
 Project3_scripts/allBeer_lm.py
		python3 Project3_scripts/allBeer_lm.py

figures/allBeer_years_p9.png:\
 derived_data/allBeer_state_aggregated.csv\
 Project3_scripts/allBeer_lm.py
		python3 Project3_scripts/allBeer_lm.py

figures/allBeer_liver_years_p9.png:\
 derived_data/allBeer_state_aggregated.csv\
 Project3_scripts/allBeer_lm.py
		python3 Project3_scripts/allBeer_lm.py

derived_data/allBeer_state_aggregated.csv:\
 derived_data/combined_allBeer_liver.csv\
 Project3_scripts/aggregated_analysis_allBeer.R
		Rscript ~/Project3_scripts/aggregated_analysis_allBeer.R

derived_data/combined_allBeer_liver.csv:\
 ~/source_data/aggr-data-beer_2008-2019.xlsx\
 ~/Project3_scripts/clean_all.R
		Rscript ~/Project3_scripts/clean_all.R

assets/allBarrels_by_state.png:\
 derived_data/tidy_allBeer_consump.csv\
 ~/Project3_scripts/aggregated_analysis_allBeer.R
		Rscript ~/Project3_scripts/aggregated_analysis_allBeer.R

derived_data/tidy_allBeer_consump.csv:\
 ~/Project3_scripts/clean_all.R
		Rscript ~/Project3_scripts/clean_all.R

## Project2 dependencies - shiny app
beer_mortality_shiny: ~/derived_data/combined_beer_liver.csv
	Rscript ~/Project2_scripts/beer_mortality_plots.R

## Project 1 dependencies -on premises beer only
report.pdf:\
 ~/Project1_scripts/report.Rmd\
 ~/assets/barrels_by_state.png\
 ~/assets/crude_rate_by_state.png\
 ~/figures/avPlots.png\
 ~/figures/aggregated_mortality_barrels.png\
 ~/derived_data/lm_barrel_year.rds
	Rscript -e "rmarkdown::render('~/Project1_scripts/report.Rmd',\
    output_format='pdf_document',\
    output_dir='~')"

assets/barrels_by_state.png:\
 ~/derived_data/tidy_beer_consump.csv\
 ~/Project1_scripts/analysis.R\
 ~/Project1_scripts/clean.R
	Rscript ~/Project1_scripts/analysis.R

derived_data/lm_barrel_year.rds:\
 ~/derived_data/combined_beer_liver.csv\
 ~/Project1_scripts/analysis.R
	Rscript ~/Project1_scripts/analysis.R
	
derived_data/tidy_beer_consump.csv:\
 ~/source_data/aggr-data-beer_2008-2019.xlsx\
 ~/Project1_scripts/clean.R
	Rscript ~/Project1_scripts/clean.R

derived_data/combined_beer_liver.csv:\
 ~/source_data/aggr-data-beer_2008-2019.xlsx\
 ~/source_data/mortality.txt\
 ~/Project1_scripts/clean.R
	Rscript ~/Project1_scripts/clean.R

assets/crude_rate_by_state.png:\
 ~/derived_data/tidy_liver_mortality.csv\
 ~/Project1_scripts/analysis.R
	Rscript ~/Project1_scripts/analysis.R

figures/avPlots.png:\
 derived_data/combined_beer_liver.csv\
 Project1_scripts/analysis.R
	Rscript Project1_scripts/analysis.R
	
figures/aggregated_mortality_barrels.png:\
 ~/derived_data/combined_beer_liver.csv\
 ~/Project1_scripts/aggregated_analysis.R
	Rscript ~/Project1_scripts/aggregated_analysis.R

