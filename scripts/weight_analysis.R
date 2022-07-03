weight_log_cleaned <- weightLogInfo %>%
  clean_names() %>% 
  mutate(date = mdy_hms(date),
         id = as.factor(id)) %>% 
  separate(date, into = c("date", "time"), sep = " ", remove = FALSE) %>% 
  select( -time)

skim(weight_log_cleaned)

weight_records <- full_join(weight_log_cleaned , activity_summary, keep = FALSE) %>% 
  group_by(id, is_manual_report) %>% 
  summarise(count = n()) %>% 
  replace_na(list(is_manual_report = "Not Recorded"))

weight_recording_type <- weight_records %>% 
  group_by(is_manual_report) %>% 
  summarise(count = n())

weight_recording_type$is_manual_report[weight_recording_type$is_manual_report == "True"] <- "Manual Record"
weight_recording_type$is_manual_report[weight_recording_type$is_manual_report == "False"] <- "Auto Record"

ggplot(weight_recording_type, aes(x = "", y = count, fill=is_manual_report)) +
  geom_col() +
  geom_text(aes(label = paste0(round(count/.33,0), '%')), color = c("#36454F", "#36454F", "#36454F"),
            position = position_stack(vjust = 0.5), size = 5,
            show.legend = FALSE) +
  guides(fill = guide_legend(title = "Weight Recording Type")) +
  scale_fill_brewer(palette = "OrRd") +
  coord_polar(theta = "y") +
  theme_void()+
  labs(title = "Percentage of Users Weight Data",
       subtitle = "Most of users didn't record weight. The data categorized by weight recording type.")