library(bigrquery)
library(dplyr)
library(ggplot2)

# SQL Query for data in BigQuery
sql_query <- paste0("SELECT * FROM `mpg-data-warehouse.geo.all_restoration`")

# Pull data and load into dataframe
df_bq <- bq_project_query('mpg-data-warehouse', sql_query) %>%
  bq_table_download() %>%
  as.data.frame()

# Format geometry
d <- st_as_sf(df_bq, wkt = "geometry", crs=4326)

# Plot
ggplot() +
  geom_sf(data = d, aes(fill = as.factor(Year))) +
  theme(axis.text.x=element_blank(), #remove x axis labels
        axis.ticks.x=element_blank(), #remove x axis ticks
        axis.text.y=element_blank(),  #remove y axis labels
        axis.ticks.y=element_blank()  #remove y axis ticks
  )