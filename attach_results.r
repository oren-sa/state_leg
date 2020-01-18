library (sp)
library(raster)
library (rgdal)
library(stringr)

#make sure to download the files from the repository
setwd("WD_HERE")

#load historical state house results and shapefile boundaries
results_all <- read.csv("https://rawgit.com/PrincetonUniversity/historic_state_legislative_election_results/master/state_legislative_election_results_post1971.csv")
boundaries <- readOGR ("Dists_L.gpkg")

#create a district code within the results dataframe
results_all$SLDLST<- str_pad(results_all$District, 3,side= "left",pad="0")
results_all$dist_code <- paste0(results_all$State,results_all$SLDLST)

#select one year to add results to boundaries. change year in subset and dataframe name below
results_2018 <- subset(results_all, results_all$Year==2018)

#merge boundaries with results from year
boundaries <- merge(boundaries,results_2018, by= "dist_code")

#write the results to a shapefile
writeOGR(results_2018, ".", "statehouse_results_2018", driver="ESRI Shapefile",overwrite_layer = TRUE)

#et voila! now your dataset is ready!
