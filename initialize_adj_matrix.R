# load packages
library("tools")

# load misc functions
source("misc_functions.R")

# List of independent variable rasters file names
indep_var_paths = list_files_with_exts("./data/indep_vars",
                                       exts = "tif",
                                       full.names = FALSE)

# File name of dependent variable raster to be used
dep_var_file = "ghf_co_disc.tif"

adj_matrix = data.frame(matrix(0,length(indep_var_paths)+1,
                                 length(indep_var_paths)+1))

# set column and row names as file names 
# (dependent and independent variables)
colnames(adj_matrix)=c(dep_var_file,indep_var_paths)
rownames(adj_matrix)=c(dep_var_file,indep_var_paths)

# Remove file extensions from dimension names
# Replace "." and spaces with "_"
adj_matrix = fixDimnames(adj_matrix)

# write initialized adjacency matrix to disk
write.table(adj_matrix,"./data/net_matrix/adj_v1.csv",sep=",",
            row.names=TRUE,col.names=NA)
