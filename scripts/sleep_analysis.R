daily_sleep_cleaned <- sleepDay %>%
  clean_names() %>%
  mutate(sleep_day = mdy_hms(sleep_day),
          day = wday(sleep_day, label = TRUE),
          id = as.factor(id)) %>%
  select(-sleep_day,-total_sleep_records)

head(daily_sleep_cleaned)

Median.Sleep = median((daily_sleep_cleaned$total_minutes_asleep / 60))

ggplot(daily_sleep_cleaned, aes(x = total_minutes_asleep / 60)) +
  geom_density(alpha = .5, fill = "#0099CC", color = "#0099CC") +
  geom_vline(
    aes(xintercept = Median.Sleep),
    color = "red",
    size = 0.5) +
  theme_bw() +
  annotate(x = 9.2, y =+Inf, label = paste0 ("Median Sleep: ", round(Median.Sleep, 2), " hours"), vjust = 1.5, geom = "label")+
  scale_y_continuous(expand = c(0, 0)) +
  theme(panel.border = element_blank(), panel.grid.minor.y = element_blank()) +
  labs(x = "User Hours of Sleep", y = "Sleep Frequency", fill = NULL)