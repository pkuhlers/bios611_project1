.PHONY: beer_mortality_shiny

beer_mortality_shiny: derived_data/combined_beer_liver.csv
	Rscript Bios611-Project2/beer_mortality_plots.R

report.pdf:\
 report.Rmd\
 assets/barrels_by_state.png\
 assets/crude_rate_by_state.png\
 figures/avPlots.png\
 figures/aggregated_mortality_barrels.png\
 derived_data/lm_barrel_year.rds
	Rscript -e "rmarkdown::render('report.Rmd',output_format='pdf_document')"

assets/barrels_by_state.png:\
 derived_data/tidy_beer_consump.csv\
 analysis.R\
 clean.R
	Rscript analysis.R

derived_data/lm_barrel_year.rds:\
 derived_data/combined_beer_liver.csv\
 analysis.R
	Rscript analysis.R
	
derived_data/tidy_beer_consump.csv:\
 source_data/aggr-data-beer_2008-2019.xlsx\
 clean.R
	Rscript clean.R

derived_data/combined_beer_liver.csv:\
 source_data/aggr-data-beer_2008-2019.xlsx\
 source_data/mortality.txt\
 clean.R
	Rscript clean.R

assets/crude_rate_by_state.png:\
 derived_data/tidy_liver_mortality.csv\
 analysis.R
	Rscript analysis.R

figures/avPlots.png:\
 derived_data/combined_beer_liver.csv\
 analysis.R
	Rscript analysis.R
	
figures/aggregated_mortality_barrels.png:\
 derived_data/combined_beer_liver.csv\
 aggregated_analysis.R
	Rscript aggregated_analysis.R

