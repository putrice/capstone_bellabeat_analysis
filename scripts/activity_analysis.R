daily_activity_cleaned <- dailyActivity %>%
  clean_names() %>% 
  mutate(activity_date = mdy(activity_date),
         day = wday(activity_date, label = TRUE),
         id = as.factor(id))

skim(daily_activity_cleaned)

daily_activity_cleaned <- daily_activity_cleaned %>% 
  mutate(activity_level = case_when(total_steps <= 5000 ~ "Sedentary", 
                                    total_steps > 5000 & total_steps <= 7499 ~ 
                                      "Lightly Active", total_steps >= 7500 & 
                                      total_steps <= 9999 ~ "Fairly Active", 
                                    total_steps >= 10000 ~ "Very Active"))

head(daily_activity_cleaned)

trimmed_daily_activity <- daily_activity_cleaned %>%
  subset(!(sedentary_minutes %in% c(1440)))

head(trimmed_daily_activity)

Mean.TotalSteps = mean(trimmed_daily_activity$total_steps)

ggplot(trimmed_activity, aes(x = total_steps, fill = activity_level)) +
  geom_histogram(bins= 50, position = "identity", colour="white") +
  geom_vline(xintercept = Mean.TotalSteps, color = "red")+
  theme_bw()+
  labs(x = "Daily Number of Steps", y = "Total",
       title = "Majority of Users are Active",
       subtitle = "Distribution of user daily total steps categorized by activity level")+
  guides(fill = guide_legend(title = "Activity Level"),
         colour = guide_legend(title = "Activity Level"))+
  annotate(x = Mean.TotalSteps, y =+Inf, label = "Mean", vjust = 1.5, geom = "label")+
  scale_fill_brewer(palette = "RdPu")