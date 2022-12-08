library(sf)
library(dplyr)
library(rgdal)

# Shapefile
shp_url <- "https://storage.googleapis.com/mpg-data-warehouse/mpg_geo/Shapefile/Test_Shapefile/Revegetation_All_Years_Test.shp"

# Download object
download.file(shp_url, "Revegetation_All_Years_Test.shp", mode="wb")

# Read object
veg_sf <- read_sf('./Test_Shapefile/Revegetation_All_Years_Test.shp') 

# Update Coordinate System
veg_4326 <- st_transform(veg_sf, crs = 4326)

# Explore
veg_4326 %>% head()

# Output to GeoJSON
st_write(veg_4326, "Revegetation_All_Years_Test.geojson")