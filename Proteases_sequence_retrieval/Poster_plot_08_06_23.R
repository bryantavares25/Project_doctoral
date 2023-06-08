#### Aprendendo R ####

library(dplyr)

##### Example data
set.seed(123) # Set seed for reproducibility
data <- matrix(rnorm(100, 0, 10), nrow = 10, ncol = 10) # Create example data
colnames(data) <- paste0("Col", 1:10) # Column names
rownames(data) <- paste0("Row", 1:10) # Row names

# # # # # MyTry # # # # # HeatmapPlot

#link video: https://www.youtube.com/watch?v=xerW2TvZHbQ


test <- matrix(c(c(0,0,0,1,1,0,0,1,0,1,0,0),
                 c(0,0,0,0,0,1,0,0,1,1,1,0),
                 c(0,0,0,0,0,0,0,1,0,1,0,0),
                 c(0,0,0,1,0,0,0,0,1,0,0,1),
                 c(0,0,1,1,0,1,0,1,1,1,0,0),
                 c(0,0,1,0,0,1,0,0,1,1,0,0),
                 c(1,1,1,1,1,0,1,1,0,1,0,1),
                 c(0,0,0,0,0,0,1,1,0,0,0,0),
                 c(0,0,0,0,0,0,1,1,0,0,0,0),
                 c(0,0,0,0,1,0,0,1,0,1,0,1),
                 c(0,0,0,0,0,0,0,0,0,0,0,0),
                 c(0,0,1,0,0,0,0,1,0,1,0,1),
                 c(0,0,1,1,0,1,0,1,1,1,0,0),
                 c(0,0,1,1,0,0,0,1,1,0,0,0),
                 c(0,0,0,1,0,0,1,1,1,1,0,0),
                 c(0,0,1,1,0,0,0,1,0,1,0,0),
                 c(1,0,0,0,1,0,1,1,0,0,0,0),
                 c(1,1,1,1,0,1,1,0,0,1,0,0),
                 c(0,0,0,0,0,0,0,1,0,0,0,0),
                 c(1,1,1,0,0,0,1,1,1,1,1,1),
                 c(1,0,0,0,1,1,0,0,1,1,1,1),
                 c(0,1,1,0,1,1,0,1,1,1,0,0),
                 c(0,0,1,1,1,1,0,1,0,0,0,0),
                 c(0,0,0,1,0,1,0,1,1,1,0,1),
                 c(0,0,0,0,0,0,0,0,0,1,0,0),
                 c(0,0,0,0,1,1,1,0,0,1,0,0),
                 c(0,0,1,0,0,0,0,1,1,1,0,0)),
               nrow = 12, ncol = 27)

colnames(test) <- c("MHP7448_RS00135 to MFC_RS03415", "MHP7448_RS00160 to MFC_RS02380", "MHP7448_RS00735 to MFC_RS01840", "MHP7448_RS00780 to MFC_RS01885", "MHP7448_RS00895 to MFC_RS02000", "MHP7448_RS00965 to MFC_RS02075", "MHP7448_RS01125 to MFC_RS02215", "MHP7448_RS01645 to MFC_RS00940",	"MHP7448_RS01695 to MFC_RS03005", "MHP7448_RS01760 to MFC_RS02360", "MHP7448_RS01830 to MFC_RS02980", "MHP7448_RS01965 to MFC_RS01350", "MHP7448_RS02430 to MFC_RS03175", "MHP7448_RS02535 to MFC_RS02885", "MHP7448_RS02710 to Without ortholog", "MHP7448_RS02825 to MFC_RS01090", "MHP7448_RS02840 to MFC_RS01070", "MHP7448_RS02910 to MFC_RS01005",	"MHP7448_RS03080 to MFC_RS01430", "MHP7448_RS03310 to MFC_RS01635", "MHP7448_RS03360 to MFC_RS01680", "MHP7448_RS03395 to MFC_RS02845", "MHP7448_RS03465 to MFC_RS02780", "MHP7448_RS03555 to MFC_RS00335", "MHP7448_RS03865 to Without ortholog", "MHP7448_RS03870 to Without ortholog", "MHP7448_RS04050 to MFC_RS03340")
rownames(test) <- 

mycolor <- colorRampPalette(c('white', 'green'))
heatmap(test, col = mycolor(2))
test

t(heatmap)
# # # # # OthersTry # # # # PresenceAbsencePlot

# Link: https://www.youtube.com/watch?v=zsY-dFuIWYs
# Link: https://stats.stackexchange.com/questions/489508/best-way-to-visualise-presence-absence-of-specific-events-in-multiple-case-contr
# Link: https://stackoverflow.com/questions/51641988/ggplot2-plotting-the-data-in-geom-tile-for-absence-or-presence
# Link: https://stackoverflow.com/questions/65558154/r-dplyr-add-increasing-number-to-columns
# Link: https://stackoverflow.com/questions/58222681/ploting-bianary-presence-absence-data-with-ggplot2-geom-point
# Link: https://stackoverflow.com/questions/62876384/how-to-plot-binary-data-and-colour-presence-by-group-in-r