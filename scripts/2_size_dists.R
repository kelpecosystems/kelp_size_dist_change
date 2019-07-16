library(ggridges)
library(ggmaps)

#load kelp_sites
suppressMessages(
  source("./1_import_data.R")
)

kelp_sites <- kelp_sites %>%
  mutate(SITE = factor(SITE),
         SITE = fct_reorder(SITE, START_LATITUDE))

#Plot ridges!

make_size_plot <- function(sp_code, title, measure_name, measure){
  
  ggplot(data = kelp_sites %>% filter(SP_CODE==sp_code),
         aes(x = {{measure}}, y = SITE, fill = as.factor(YEAR))) +
    stat_density_ridges(alpha = 0.5) +
    labs(fill = "Year", y = "", x = measure_name,
         title = title) +
    scale_fill_brewer(palette = "PRGn")
}

make_size_plot("SL", "Saccharina latissima", "Average\nBlade Length (cm)", BLADE_LENGTH_CM)
make_size_plot("LADI", "Laminaria digitata", "Average\nBlade Length (cm)", BLADE_LENGTH_CM)
make_size_plot("AGCL", "Agarum clathratum", "Average\nBlade Length (cm)", BLADE_LENGTH_CM)

make_size_plot("SL", "Saccharina latissima", "Average\nBlade Length (cm)", BLADE_LENGTH_CM) +
  facet_wrap(~YEAR)

make_size_plot("SL", "Saccharina latissima", "Average\nWet Weight (g)", WET_WEIGHT)
make_size_plot("LADI", "Laminaria digitata", "Average\nWet Weight (g)", WET_WEIGHT)
make_size_plot("AGCL", "Agarum clathratum", "Average\nWet Weight (g)", WET_WEIGHT)



make_size_plot_time <- function(sp_code, title, measure_name, measure){
  
  ggplot(data = kelp_sites %>% filter(SP_CODE==sp_code),
         aes(x = {{measure}}, fill = SITE, y = factor(YEAR))) +
    stat_density_ridges(alpha = 0.5) +
    labs(y = "", x = measure_name,
         title = title) +
    scale_fill_viridis_d()
}


make_size_plot_time("SL", "Saccharina latissima", "Average\nBlade Length (cm)", BLADE_LENGTH_CM)
make_size_plot_time("LADI", "Laminaria digitata", "Average\nBlade Length (cm)", BLADE_LENGTH_CM)
make_size_plot_time("AGCL", "Agarum clathratum", "Average\nBlade Length (cm)", BLADE_LENGTH_CM)


