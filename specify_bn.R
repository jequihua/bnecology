
# Load packages
library("bnlearn")
library("gRain")
library("tools")

# load misc functions
source("misc_functions.R")

# Read a file with an associated adjacency matrix
adj_csv = read.table("./data/net_matrix/adj_v1.csv",
                     header=TRUE,
                     row.names=1,
                     sep=",",
                     stringsAsFactors=FALSE)

# Initialize an empty graph of appropriate size
bngraph = initAdj(adj_csv)

# Set graph arcs based on adjacency matrix
amat(bngraph) = as.matrix(adj_csv)

# Visualize graph
plot(bngraph)
