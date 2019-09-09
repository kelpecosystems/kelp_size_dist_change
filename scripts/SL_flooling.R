source("./1_import_data.R")
library(ggplot2)

ggplot(data = kelp_transects %>% filter(SP_CODE=="SL"),
       aes(x = log(quadrat_mean_wet_weight+1), y = SITE, fill = as.factor(YEAR))) +
  stat_density_ridges(alpha = 0.5) +
  labs(fill = "Year", y = "", x = "quadrat_mean_wet_weight",
       title = "SL") +
  scale_fill_brewer(palette = "PRGn") +
  facet_wrap(~YEAR) 


ggplot(data = kelp_transects %>% filter(SP_CODE=="SL"),
       aes(y = log10(quadrat_median_wet_weight+1), color = SITE, 
           x = YEAR)) +
  stat_summary() +
 # scale_color_brewer(palette = "PRGn") +
  facet_wrap(~SITE) 



ggplot(data = kelp_transects %>% filter(SP_CODE=="SL"),
       aes(y = quadrat_mean_wet_weight, color = SITE, 
           x = COUNT)) +
  geom_point()


ggplot(data = kelp_transects %>% filter(SP_CODE=="SL") %>%
         group_by(SITE, YEAR, TRANSECT) %>%
         summarize(mean_wet_weight = mean(mean_wet_weight),
                   COUNT = mean(COUNT, na.rm=T)),
       aes(y = mean_wet_weight, color = SITE, 
           x = COUNT)) +
  geom_point()



library(lme4)
library(DHARMa)
mod <- lmer(log10(quadrat_median_wet_weight+1) ~ as.numeric(YEAR) +
              (1|SITE) + (1|SITE:TRANSECT) + (1|SITE:TRANSECT:YEAR),
            data = kelp_transects %>% filter(SP_CODE=="SL"))

plot(simulateResiduals(mod))
car::Anova(mod, test = "F")
summary(mod)





