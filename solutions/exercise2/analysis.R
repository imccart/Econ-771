# Meta --------------------------------------------------------------------

## Date Created:  7/17/2020
## Date Edited:   7/17/2020
## Description:   Analysis file for exercise 2


# Analytic Datasets -----------------------------------------------------------
final.data <- data.hh %>%
  mutate(channel = as.factor(channel),
         new_enrollee = is.na(previous_plan_number),
         any_assist = (channel=="Insurance Agent" | channel=="Other Assistance"),
         assist_agent = (channel=="Insurance Agent"),
         assist_other = (channel=="Other Assistance"),
         low_income = (FPL<1.5),
         hh_single = (household_size==1),
         hmo_ppo = (plan_network_type %in% c("HMO","PPO")),
         bad_obs = (new_enrollee==0 & year==2014),
         insurer = replace(insurer, 
                           insurer %in% c("Chinese_Community","LA_Care","Western","Contra_Costa","SHARP"),
                           "Other")) %>%
  filter( flagged==0 & !is.na(plan_number_nocsr) & bad_obs==0 & FPL<2.0)%>%
  select(lang_english, lang_spanish, lang_other,
         perc_0to17, perc_18to25, perc_26to34, perc_35to44, perc_45to54,
         perc_male, perc_asian, perc_black, perc_hispanic, perc_other, 
         FPL, low_income, household_size, hh_single, SEP, new_enrollee, 
         insurer, hmo_ppo, metal,
         channel, any_assist, assist_agent, assist_other, dominated_choice, 
         region, rating_area, year, household_id)


# Summary Statistics ------------------------------------------------------


## metal by type of assistance (all enrollees)
metal.assist.all <- final.data %>% group_by(channel, metal) %>%
  summarize(metal_count=n()) %>%
  mutate(metal_pct=metal_count/sum(metal_count),
         metal_pct=round(metal_pct,3))


# Summary values for markdown ---------------------------------------------

mean.dom.choice <- mean(final.data$dominated_choice, na.rm=T)
tot.enroll <- sum(enrollee.count$all_count)
tot.enroll.new <- sum(enrollee.count$new_count)
first.year <- min(enrollee.count$year)
last.year <- max(enrollee.count$year)
