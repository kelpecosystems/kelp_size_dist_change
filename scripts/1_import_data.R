######################################################################
#' Read and Merge KEEN data with invasives sheet
#' 
#' 
######################################################################
  
library(tidyverse)
library(readr)
library(sf)


kelp <- read_csv("../data/keen_kelp.csv") %>%
  dplyr::select(-DAY, -MONTH) %>%
  filter(SP_CODE != "SADE")

site <- read_csv("../data/keen_sites.csv")

kelp_sites <- left_join(kelp, site) %>%
  filter(!is.na(START_LATITUDE)) %>%
  st_as_sf(coords = c("START_LONGITUDE", "START_LATITUDE"),
           remove = FALSE)


#aggregate with biomass at transect level

quads <- read_csv("../data/keen_quads.csv") %>%
  dplyr::select(-DAY, -MONTH) %>%
  filter(SP_CODE %in% c("SL", "SLJ", "AGCL", "LADI"))

kelp_transects <- kelp_sites %>%
  group_by(SITE, TRANSECT, YEAR, SP_CODE) %>%
  summarise(mean_wet_weight = mean(WET_WEIGHT, na.rm=T),
            mean_dry_weight = mean(DRY_WEIGHT, na.rm=T),
            median_wet_weight = median(WET_WEIGHT, na.rm=T),
            mean_dry_weight = median(DRY_WEIGHT, na.rm=T),
  ) %>%
  left_join(quads) %>%
  mutate(transect_mean_wet_weight = mean_wet_weight*COUNT,
         transect_mean_dry_weight = mean_dry_weight*COUNT,
         transect_median_wet_weight = median_wet_weight*COUNT,
         transect_mean_dry_weight = mean_dry_weight*COUNT)
