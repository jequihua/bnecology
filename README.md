# bnecology

This repository provides tools to perform automated estimation of Ecological Integrity (EI). This is performed in a supervised manner so reference values are required, as well as independent variables available wall-to-wall over the region of interest.

The general workflow is as follows:

* Initialize an empty adjacency matrix including the available variables.
* Specify the model (Set arcs between nodes/variables).
* Fit the bayesian network based on the available evidence.
* Using the fitted network, predict/estimate the level of EI for the region of interest.

### 1.- Initialize empty adjacenty matrix (initialize_adj_matrix.R)

It's assumed that the user has a collection of independente variables located in the folder "./data/indep_vars" and at least one dependent variable. All these are assumed to be rasters with the same projection, resolution and extent.

This script receives the folder filled with independen variable rasters and the filename of the dependent variable rasters and produces a csv file with an empty adjacency matrix.

The row and column names of the matrix are the filenames. The first column and row corresponds to the dependent variable.

### 2.- Specify the bayesian network model (specify_bn.R)

Once the empty adjacency matrix is created, it can be manipulated in other software, for example excel.

The matrix should be filled with 1's where experts agree there is an arc.

The arc direction is of the form: row ---> column. 

### 3.- Fit bayesian network (fit_bn.R)

Once the adjacency matrix is devised it's time to fit the model.

The same folders mentioned in 1.- must be associated to the bayesian network model. In this script, all the rasters are loaded into a raster brick, and then converted into a data frame where each raster becomes a column.

The network is fit using this data frame.

### 4.- Predict IE over the region of interest (predict_with_bn.R)

Once the model fit is complete, the model can use the full data frame to produce an IE map of the region.
