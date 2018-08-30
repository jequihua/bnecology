# load packages
library("bnlearn")
library("gRain")
library("raster")

# load misc functions
source("misc_functions.R")

# List of independent variable rasters
indep_var_paths = list_files_with_exts("./data/indep_vars",
                                  exts = "tif")

# Load dependent variable raster (will be used as base raster)
dep_var_path = "./data/dep_vars/ghf_co_disc.tif"

# Create raster brick where bands are [dep_var,indep_var_1,...,indep_var_n]
bnbrik = bnBrick(dep_var_path,indep_var_paths)

# To df and drop incomplete rows
bnbrik_df = data.frame(rasterToPoints(bnbrik))
bnbrik_df = bnbrik_df[complete.cases(bnbrik_df),]

# User must know which variables are factors and coerce them to factor
bnbrik_df = factorCols(bnbrik_df,
                       c("ghf_co_disc",
                         "Alouatta_arctoidea_current",
                         "Alouatta_palliata_current",
                         "Alouatta_seniculus_current",
                         "bioma_eco2008",
                         "Colibri_coruscans_current",
                         "Hydrochoerus_hydrochaeris_current",
                         "Panthera_onca_current"))

# User must know which variables are numeric and discretize them
bnbrik_df = discretizeCols(bnbrik_df,
                           c("cropCol_raw_sd",
                             "dem_1000m",
                             "distancia_vias",
                             "hansen_tree_cover_1000m",
                             "tree_height",
                             "zhong_cropland_1000m"))

# extract sample for training data
sampsize = 0.2
idx = 1:nrow(bnbrik_df)
idx_sample = sample(idx,sampsize*nrow(bnbrik_df))
bnbrik_df_sample = bnbrik_df[idx_sample,]

# fit network
fitted_network <- bn.fit(bngraph,
                         data=bnbrik_df_sample[,3:ncol(bnbrik_df)],
                         method='bayes')

# We use the junction tree algorithm to create 
# an independence network that we can query
prior <- compile(as.grain(fitted_network))
