library(sf)
library(mapview)
library(dplyr)
library(ggplot2)

# GeoDatabase
gd_url <- "https://storage.cloud.google.com/mpg-data-warehouse/mpg_geo/GeoDatabase/DATA_SHARE_TEST_GDB.zip"

# Shapefile
shp_url <- "https://storage.googleapis.com/mpg-data-warehouse/mpg_geo/Shapefile/Test_Shapefile/Revegetation_All_Years_Test.shp"

# Download object
download.file(shp_url, "Revegetation_All_Years_Test.shp", mode="wb")

# Read object
veg_sf <- read_sf('./Test_Shapefile/Revegetation_All_Years_Test.shp') 

veg_sf %>%
  filter(Year > 2000) %>%
  ggplot() +
    geom_sf(mapping = aes(fill = as.factor(Action), alpha=0.4)) +
    facet_wrap(~ Year)