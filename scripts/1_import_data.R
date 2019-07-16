######################################################################
#' Read and Merge KEEN data with invasives sheet
#' 
#' 
######################################################################
  
library(tidyverse)
library(readr)
library(sf)


kelp <- read_csv("../data/keen_kelp.csv") %>%
  dplyr::select(-DAY, -MONTH)

site <- read_csv("../data/keen_sites.csv")

kelp_sites <- left_join(kelp, site) %>%
  filter(!is.na(START_LATITUDE)) %>%
  st_as_sf(coords = c("START_LONGITUDE", "START_LATITUDE"),
           remove = FALSE)
