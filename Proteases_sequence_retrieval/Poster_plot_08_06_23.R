#### Aprendendo R ####

'295358.protein.links.detailed.v11.5' <- read.delim("/home/bryan/Documentos/GitHub/Systems_biology_analysis/295358.protein.links.detailed.v11.5.txt", sep="", stringsAsFactors=FALSE)

string_database_experimental <- subset(`295358.protein.links.detailed.v11.5`, select = c(1, 2, 7, 8))

# Normalização dos valores das colunas Experimental e Database
string_database_experimental$experimental<-string_database_experimental$experimental/1000
string_database_experimental$database<-string_database_experimental$database/1000
#
string_database_experimental$s_exp_nop =(string_database_experimental$experimental - 0.041)/(1-0.041)
string_database_experimental$s_db_nop =(string_database_experimental$database - 0.041)/(1-0.041)
#
string_database_experimental$s_exp_nop <-ifelse(string_database_experimental$s_exp_nop < 0, 0, string_database_experimental$s_exp_nop)
string_database_experimental$s_db_nop <-ifelse(string_database_experimental$s_db_nop < 0, 0, string_database_experimental$s_db_nop)
string_database_experimental$s_tot_nop = 1-(1-string_database_experimental$s_exp_nop)*(1-string_database_experimental$s_db_nop)
string_database_experimental$combined_score = string_database_experimental$s_tot_nop + 0.041*(1-string_database_experimental$s_tot_nop)
string_database_experimental$combined_score <- ifelse(string_database_experimental$combined_score == 0.041, 0, string_database_experimental$combined_score)
string_database_experimental$combined_score <- signif(string_database_experimental$combined_score,digits=3)
#Filter data using combined_score
string_database_experimental_b <-string_database_experimental %>% filter(combined_score>=0.4)
#Remove "4932." number from gene names
string_database_experimental_b$protein1<-gsub("4932.", "\\1", string_database_experimental_b$protein1)
string_database_experimental_b$protein2<-gsub("4932.", "\\1",string_database_experimental_b$protein2)

print(labels)
print(resp)
print(x)


###############

# # # # # # 

##### Example data
set.seed(123) # Set seed for reproducibility
data <- matrix(rnorm(100, 0, 10), nrow = 10, ncol = 10) # Create example data
colnames(data) <- paste0("Col", 1:10) # Column names
rownames(data) <- paste0("Row", 1:10) # Row names

# # # # # MyTry # # # # # HeatmapPlot

#link video: https://www.youtube.com/watch?v=xerW2TvZHbQ

name_col <-
name_row <- 
  
test <- matrix(c(c(0,0,0,1,1,0,0,1,0,1,0,0), c(0,0,0,1,1,0,0,1,0,1,0,0), c(0,0,0,1,1,0,0,1,0,1,0,0), c(0,0,0,1,1,0,0,1,0,1,0,0), c(0,0,0,1,1,1,1,1,0,1,0,0), c(0,0,0,1,1,0,0,1,1,1,1,1)), nrow = 12 , ncol = 6)
mycolor <- colorRampPalette(c('green', 'darkgreen'))
heatmap(test, col = mycolor(100))
test

# # # # # OthersTry # # # # PresenceAbsencePlot

# Link: https://www.youtube.com/watch?v=zsY-dFuIWYs
# Link: https://stats.stackexchange.com/questions/489508/best-way-to-visualise-presence-absence-of-specific-events-in-multiple-case-contr
# Link: https://stackoverflow.com/questions/51641988/ggplot2-plotting-the-data-in-geom-tile-for-absence-or-presence
# Link: https://stackoverflow.com/questions/65558154/r-dplyr-add-increasing-number-to-columns
# Link: https://stackoverflow.com/questions/58222681/ploting-bianary-presence-absence-data-with-ggplot2-geom-point
# Link: https://stackoverflow.com/questions/62876384/how-to-plot-binary-data-and-colour-presence-by-group-in-r