#############Commands for processing interactome data from STRING 11.0 - selecting only databases and experimental evidences and calculate the combined score from evidences#############

##Download the last interactome file from STRING containing subscores per channel and open in R##

'4932.protein.links.detailed.v11.0' <- read.delim("4932.protein.links.detailed.v11.0.txt", sep="", stringsAsFactors=FALSE)
string_database_experimental<-subset(`4932.protein.links.detailed.v11.0`, select = c(1, 2, 7, 8))
string_database_experimental$experimental<-string_database_experimental$experimental/1000
string_database_experimental$database<-string_database_experimental$database/1000
string_database_experimental$s_exp_nop =(string_database_experimental$experimental - 0.041)/(1-0.041)
string_database_experimental$s_db_nop =(string_database_experimental$database - 0.041)/(1-0.041)
string_database_experimental$s_exp_nop<-ifelse(string_database_experimental$s_exp_nop < 0, 0, string_database_experimental$s_exp_nop)
string_database_experimental$s_db_nop<-ifelse(string_database_experimental$s_db_nop < 0, 0, string_database_experimental$s_db_nop)

string_database_experimental$s_tot_nop = 1-(1-string_database_experimental$s_exp_nop)*(1-string_database_experimental$s_db_nop)
string_database_experimental$combined_score = string_database_experimental$s_tot_nop + 0.041*(1-string_database_experimental$s_tot_nop)
string_database_experimental$combined_score<-ifelse(string_database_experimental$combined_score == 0.041, 0, string_database_experimental$combined_score)
string_database_experimental$combined_score <- signif(string_database_experimental$combined_score,digits=3)
string_database_experimental_b<-string_database_experimental %>% filter(combined_score>=0.4) #Filter data using combined_score
string_database_experimental_b$protein1<-gsub("4932.", "\\1", string_database_experimental_b$protein1) #Remove "4932." number from gene names
string_database_experimental_b$protein2<-gsub("4932.", "\\1",string_database_experimental_b$protein2)

##Add gene name for each ORF##
library(dplyr)
ORF_Genes_names_processed_update_2019 <- read.delim("ORF_Genes_names_processed_update_2019.tsv", stringsAsFactors=FALSE)
ORF_Genes_names_processed_update_2019$Feature<-sapply(ORF_Genes_names_processed_update_2019$Feature, function(f){is.na(f)<-which(f == '');f}) #Completing empty rows from /ORF_Genes_names information from YeastMine
ORF_Genes_names_processed_update_2019$Feature[is.na(ORF_Genes_names_processed_update_2019$Feature)] <- as.character(ORF_Genes_names_processed_update_2019$Genes[is.na(ORF_Genes_names_processed_update_2019$Feature)])
string_database_experimental_c<-left_join(string_database_experimental_b, ORF_Genes_names_processed_update_2019, by=c("protein1"="Genes"))

#merging string_database_experimental_b with ORF_Genes_names information from YeastMine
string_database_experimental_c_2<-left_join(string_database_experimental_b, ORF_Genes_names_processed_update_2019, by=c("protein2"="Genes"))
#merging string_database_experimental_b with ORF_Genes_names information from YeastMine
string_database_experimental_c$Feature_2<-cbind(string_database_experimental_c_2$Feature)

##Generate a "graph_string_db_exp" dataframe to open in Cytoscape##

graph_string_db_exp<-string_database_experimental_c[,8:10]
graph_string_db_exp<-graph_string_db_exp[c(2,3,1)]
write.table(cbind(rownames(graph_string_db_exp),graph_string_db_exp),
            file = 'graph_string_db_exp.txt', sep='\t', row.names=F, quote=F)
###In Cytoscape environment import network from 'graph_string_db_exp.txt'###

################################################################################################################################################################################
# Commands to generate a subgraph named "ALP_network" from "graph_string_db_exp" containing the shortest pathways among the DEGs from ALP_9423_10205_16376_pan_DEGs_metalogFC_SD #
##################################################################################################################################################################################

library(RCy3)
library(igraph)

##Reimport "graph_string_db_exp" from Cytoscape to igraph##

g <- createIgraphFromNetwork() 
string_graph <-g
string_graph <-as.undirected(string_graph, mode = "collapse")
key_vertices_ALP <- as.vector(ALP_9423_10205_16376_pan_DEGs_metalogFC_SD$Feature)
match(key_vertices_ALP,V(string_graph)$name) #Verify if all gene names in key_vertices_ALP are present in graph "string_graph"
match_ls <- match(key_vertices_ALP,V(string_graph)$name)
data_lsb <- data.frame(key_vertices_ALP,match_ls)
data_lsb[is.na(data_lsb$match_ls),]
remove <- c("FAT3","IZH2","IZH4","MZM1","OPI10","PPX1","TMA17") #Remove list with unmatched genes in g
key_vertices_ALP <- subset(key_vertices_ALP, !(key_vertices_ALP %in% remove))
get_path <- function(x){
  # Get atomic vector of two key verteces and return their shortest
  path as vector.
  i <- x[1]; j <- x[2]
  # Check distance to see if any verticy is outside component. No possible
  # connection will return infinate distance:
  if(distances(string_graph,i,j) == Inf){
    path <- c()
  } else {
    path <- unlist(shortest_paths(string_graph, i, j, mode="all",
                                  weights=NULL)$vpath)
  }
}
key_el_ALP <- expand.grid(key_vertices_ALP, key_vertices_ALP)
key_el_ALP <- key_el_ALP[key_el_ALP$Var1 != key_el_ALP$Var2,]
paths <- apply(key_el_ALP, 1, get_path)
path_vertices <- setdiff(unique(unlist(paths)), key_vertices_ALP)
mark_edges <- function(path, edges=c()){
  # Get a vector of id:s of connected vertices, find edge-id:s of all
  edges between them.
  for(n in 1:(length(path)-1)){
    i <- path[n]
    j <- path[1+n]
    edge <- get.edge.ids(string_graph, c(i,j), directed = FALSE,
                         error=FALSE, multi=FALSE)
    edges <- c(edges, edge)
  }
  # Return all edges in this path
  (edges)
}
key_edges <- lapply(paths, function(x) if(length(x) > 1){mark_edges(x)})
key_edges <- unique(unlist(key_edges))
g_names<-as.data.frame(V(string_graph)$name)

library(data.table)
setDT(g_names, keep.rownames = "V_number")
names(g_names)[names(g_names)=="V(string_graph)$name"] <- "V_name"
g_names$V_number<-as.integer(g_names$V_number)
path_vertices_df<-as.data.frame(path_vertices)
names(path_vertices_df)[names(path_vertices_df)=="path_vertices"] <-
  "V_number"

##Generate an unidirect "ALP_network" and export to Cytoscape (Figure 2A)##
library(dplyr)
res <- inner_join(path_vertices_df,g_names,by="V_number")
path_vertices_b<-as.vector(res$V_name)
sg_vertices_lipid_stress <- sort(union(key_vertices_ALP, path_vertices_b))
unclean_sg <- induced_subgraph(string_graph, sg_vertices_lipid_stress)
plot(unclean_sg)
sg <- delete.edges(unclean_sg, which(E(unclean_sg)$color=="gray"))
sg_lipid_stress_simplify<-simplify(sg, remove.multiple = TRUE,
                                   remove.loops = TRUE,edge.attr.comb = igraph_opt("edge.attr.comb"))
createNetworkFromIgraph(sg_lipid_stress_simplify,"ALP_network")