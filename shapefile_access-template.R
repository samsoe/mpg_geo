library(sf)
library(mapview)
library(tidyverse)
library(ggplot2)

# Download and Unzip Shapefiles
bucket <- 'https://storage.googleapis.com/mpg-data-warehouse/mpg_geo/'
url_mpg_restoration <- paste(bucket, 'mpg_restoration/shapefile/MPG_Restoration.zip', sep="")
filename = 'MPG_Restoration.zip'

download.file(url_mpg_restoration, 
              destfile = paste0("raw_data/zipped/", filename), 
              method = "libcurl")

# Unzipping is currently a manual process

# Consider change shapefile Layer name to MPG_Restoration or vice versa zip named All_Restoration
select_category <- 'All_Restoration'

# Read Shapefile
category_sf <- read_sf(paste0('raw_data/shp/', select_category, '.shp')) 

category_sf %>% glimpse()

# Interactive map with mapview
mapview(category_sf)

# Plot with ggplot
category_sf %>%
  filter(Year > 2000) %>%
  ggplot() +
    geom_sf(mapping = aes(fill = as.factor(Action), alpha=0.4)) +
    facet_wrap(~ Action)