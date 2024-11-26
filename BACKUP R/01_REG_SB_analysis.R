# # # # # # # # # # R E G E N E R A # # # # # # # # # #

# # # # # STEP 1 - Centralyties (degree and betweennes)

# Library import
library(dplyr)
library(readr)

# Data import
node_db <- read.csv("00_BN001_dn_cleaned.csv", stringsAsFactors = FALSE)
is.data.frame(node_db)

# Chart and average lines for quadrant definition
plot(node_db$Degree.unDir, node_db$Betweenness.unDir, xlab="Degree", ylab="Betweeness", col = "blue")
abline(h=median(node_db$Betweenness.unDir), v=median(node_db$Degree.unDir))

# Hubs and Bottlenecks classification
hb <- node_db[node_db$Degree.unDir >= median(node_db$Degree.unDir) & node_db$Betweenness.unDir >= median(node_db$Betweenness.unDir),] # Hub-Bot
hnb <- node_db[node_db$Degree.unDir > median(node_db$Degree.unDir) & node_db$Betweenness.unDir < median(node_db$Betweenness.unDir),] # Hub-NonBot
nhb <- node_db[node_db$Degree.unDir < median(node_db$Degree.unDir) & node_db$Betweenness.unDir > median(node_db$Betweenness.unDir),] # NonHub-Bot
nhnb <- node_db[node_db$Degree.unDir < median(node_db$Degree.unDir) & node_db$Betweenness.unDir < median(node_db$Betweenness.unDir),] # NonHub-NonBot

hb$Centrality <-"HB"
hnb$Centrality <-"HnB"
nhb$Centrality <-"nHB"
nhnb$Centrality <- "nHnB"

node_centrality <- bind_rows(hb, hnb, nhb, nhnb)

# # # # # STEP 1 - End

# # # # # # # # # # B. A. R. T. # # # # # # # # # #