#### Aprendendo R ####

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