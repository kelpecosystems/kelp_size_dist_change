#setwd
library(readr)
library(visdat)
here::here()

#where are we copying from - don't forget the open single quote
d <- "'/Users/jebyrnes/Dropbox (Byrnes Lab)/Byrnes Lab Shared Folder/KEEN Data Processing/Monitoring/cleaned_data/"

#what files are we copying over and to where - don't forget the single close quote
system(paste0("cp ", d, "keen_kelp.csv' ../data/"))
system(paste0("cp ", d, "keen_sites.csv' ../data/"))
system(paste0("cp ", d, "keen_quads.csv' ../data/"))

#data diagnostics
kelp <- read_csv("../data/keen_kelp.csv")

vis_dat(kelp)

kelp_summary <- kelp %>%
  group_by(YEAR, SITE, SP_CODE) %>%
  summarize(n_transects = length(unique(TRANSECT)),
            n_kelp = length(BLADE_LENGTH_CM))

View(kelp_summary)

ggplot(kelp_summary %>% filter(SP_CODE=="SL"),
       aes(y = n_transects, x = SITE)) + geom_col() +
  facet_wrap(~YEAR, nrow=1) +
  coord_flip() +
  ylim(c(0,4)) 


ggplot(kelp_summary %>% filter(SP_CODE=="SL"),
       aes(y = n_kelp, x = SITE)) + geom_col() +
  facet_wrap(~YEAR, nrow=1) +
  coord_flip() +
  ylim(c(0,45)) 
