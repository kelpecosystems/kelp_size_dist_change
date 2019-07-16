library(ggmap)

#load kelp_sites
suppressMessages(
  source("./1_import_data.R")
)


ne_map <- get_stamenmap(c(left=-71.82, bottom=40.86, 
                          right=-67.05, top=44.83),
                        zoom = 7
)


make_map_site <- function(sp_code, title, measure_name, measure){

  dat <- kelp_sites %>% filter(SP_CODE==sp_code) %>%
  group_by(SITE) %>%
  summarise(BLADE_LENGTH_CM = mean({{measure}}, na.rm=T),
            LAT = START_LATITUDE[1],
            LON = START_LONGITUDE[1]) %>%
  as_tibble() %>%
  st_as_sf(coords = c("LON", "LAT"))

ggmap(ne_map) +
  geom_sf(data = dat,
             mapping = aes(size = BLADE_LENGTH_CM,
                           fill = BLADE_LENGTH_CM,
                           color = BLADE_LENGTH_CM), inherit.aes = FALSE,
          shape = 19, alpha = 0.9) +
  labs(x = "", y = "", title = title) +
  scale_size_continuous(guide = guide_legend(measure_name)) +
  scale_color_viridis_c(guide = guide_legend(measure_name),
                        option = "B") +
  scale_fill_viridis_c(guide = guide_legend(measure_name),
                       option = "B") 
}


make_map_site("SL", "S. latissima", "Average\nBlade\nLength\n(cm)", BLADE_LENGTH_CM)
make_map_site("AGCL", "Agarum", "Average\nBlade\nLength\n(cm)", BLADE_LENGTH_CM)
make_map_site("LADI", "Laminaria digitata", "Average\nBlade\nLength\n(cm)", BLADE_LENGTH_CM)
make_map_site("LADI", "Laminaria digitata", "Average\nBlade\nWidth\n(cm)", WIDTH_CM)



make_map_site("SL", "Saccharina latissima", "Average\nWet Weight\n(g)", WET_WEIGHT)
make_map_site("LADI", "Laminaria digitata", "Average\nWet Weight\n(g)", WET_WEIGHT)
make_map_site("AGCL", "Agarum clathratum", "Average\nWet Weight\n(g)", WET_WEIGHT)


