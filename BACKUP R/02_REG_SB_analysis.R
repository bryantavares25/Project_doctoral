# # # # # # # # # # R E G E N E R A # # # # # # # # # #

# # # # # STEP 2 - Community and Module

# Library import
library(dplyr)
library(readr)
library(igraph)

# Data import
string_interaction <- read.delim("00_BN001_dn_string_interactions_short.tsv")

# Network selection
network <- string_interaction[,c(1,2,13)]
network_graph <- graph_from_data_frame(network, directed = FALSE, vertices = NULL)
plot(network_graph)


# # # # # STEP 2 - End

# # # # # # # # # # B. A. R. T. # # # # # # # # # #