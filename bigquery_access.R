library(bigrquery)
library(dplyr)
library(ggplot2)

# BigQuery tables in mpg-data-warehouse.geo
veg_man <- "vegetation_management"
spray <- "spraying"
reveg <- "revegetation"

select_category <- veg_man

# SQL Query for data in BigQuery
sql_query <- paste0("SELECT * FROM `mpg-data-warehouse.geo.", select_category, "`")

# Pull data and load into dataframe
df_bq <- bq_project_query('mpg-data-warehouse', sql_query) %>%
  bq_table_download() %>%
  as.data.frame()

# This might not be necessary
d <- st_as_sf(df_bq, wkt = "geometry", crs=4326)

d %>% glimpse()

ggplot() +
  geom_sf(data = d, aes(fill = as.factor(Type)))
