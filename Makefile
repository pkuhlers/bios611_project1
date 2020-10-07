
figures/report.pdf:\
 report.Rmd\
 assets/barrels_by_state.png\
 assets/crude_rate_by_state.png\
 figures/avPlots.png
	Rscript -e "rmarkdown::render('report.Rmd',output_format='pdf_document')"

assets/barrels_by_state.png:\
 derived_data/tidy_beer_consump.csv\
 analysis.R\
 clean.R
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