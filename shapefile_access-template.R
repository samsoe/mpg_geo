library(sf)
library(mapview)
library(tidyverse)
library(ggplot2)

# Download and Unzip Shapefiles
bucket <- 'https://storage.googleapis.com/mpg-data-warehouse/mpg_geo/'
url_veg_man <- paste(bucket, 'vegetation_management/shapefile/vegetation_management.zip', sep="")
url_reveg <- paste(bucket, 'revegetation/shapefile/revegetation.zip', sep="")
url_spray <- paste(bucket, 'spraying/shapefile/spraying.zip', sep="")

target_urls <- c(url_veg_man, url_reveg, url_spray)
target_files <- basename(target_urls) %>% str_replace("(?<=.zip).*$","")

download.file(target_urls, destfile = paste0("raw_data/zipped/", target_files), method = "libcurl")

zipped_files <- list.files("raw_data/zipped", pattern = ".zip$", full.names = TRUE)

# This is not working as expected, files were manually unzipped on the command line
# walk(zipped_files, unzip, exdir = "raw_data/unzipped", list = TRUE)
# OR
# unzip(zipped_files, exdir = "raw_data/unzipped")

# Select Category
veg_man <- "vegetation_management"
spray <- "spraying"
reveg <- "revegetation"

select_category <- reveg

# Read Shapefile
category_sf <- read_sf(paste0('raw_data/unzipped/', select_category, '.shp')) 

# Interactive map with mapview
mapview(category_sf)

# Plot with ggplot
category_sf %>%
  filter(Year > 2000) %>%
  ggplot() +
    geom_sf(mapping = aes(fill = as.factor(Action), alpha=0.4)) +
    facet_wrap(~ Action)