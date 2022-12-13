library(bigrquery)
library(dplyr)
library(ggplot2)

# Query for data in BigQuery
sql_query <- "SELECT * FROM `mpg-data-warehouse.geo.reveg_test`"

df_bq <- bq_project_query('mpg-data-warehouse', sql_query) %>%
  bq_table_download() %>%
  as.data.frame()

d <- st_as_sf(df_bq, wkt = "geometry", crs=4326)

d %>% str()

ggplot() +
  geom_sf(data = d, aes(fill = as.factor(Season))) +
  facet_wrap(~Year)