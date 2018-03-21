# - Work Challenges: Albert 
# - FK-FP Time
# - FR WorkChallengesSelect
# - FS - GQ WorkChallengeFrequency

library(tidyr)
library(tidyverse)
library(splitstackshape)

raw.data <- read_csv("https://raw.githubusercontent.com/brian-cuny/607project3/master/multipleChoiceResponses.csv", na = c('')) %>%
  subset(DataScienceIdentitySelect == 'Yes' & CodeWriter == 'Yes') %>%
  rowid_to_column('id')

# Create table to store challenges in long format
challenges <- raw.data %>% 
  select(id, "WorkChallengesSelect") %>% 
  cSplit("WorkChallengesSelect", sep = ",", direction = "long") # split cells containing comma delimited challenges into rows

# Create table to store the frequency of respondents challenges
challenges.frequency <- raw.data %>%  
  select(id, starts_with("WorkChallenge"), -WorkChallengesSelect) %>%
  gather("WorkChallengeFrequency", "Frequency", -id )


# Create table to store the time spent on each category
time.spent <- raw.data %>%  
  select(id, starts_with("Time"), - TimeSpentStudying) %>%
  gather("Activity", "Time", -id )

# Create CSV for `challenges` table
write.csv(challenges, file = "../tidied_csv/challenges.csv", row.names = FALSE, quote = FALSE)

# Create CSV for `challenges.frequency` table
write.csv(challenges.frequency, file = "../tidied_csv/challenges.frequency.csv", row.names = FALSE, quote = FALSE)

# Create CSVs for `time.spent` table
write.csv(time.spent, file = "../tidied_csv/time.spent.csv", row.names = FALSE, quote = FALSE)


# Plot: Distribution of Time Spent
filter( time.spent, !is.na(`Time`), `Time` != 'NA') %>% 
  mutate(`Time` = as.integer(`Time`)) %>% 
  group_by(`Activity`) %>% 
  summarise(`Time`= round(mean(`Time`), digits = 2)) %>% 
  ggplot(aes(x = Activity, y = Time,fill=Activity, label = `Time`) ) + 
  geom_bar(stat = "identity", show.legend = F) + 
  geom_text(size = 2, position = position_stack(vjust = 0.5)) + 
  coord_flip() +  
  labs(title = "Distribution of Time Spent")

# Plot: Challenges at Work
  ggplot(data = challenges, aes(challenges$WorkChallengesSelect,fill=WorkChallengesSelect)) + 
  geom_histogram( stat='count', show.legend = F ) + 
  coord_flip() +  
  labs( title = "Challenges at Work", x = "Challenges", y = "Count" )
  

# Frequency of Workplace Challenges
  filter( challenges.frequency, !is.na(`Frequency`) ) %>% 
  group_by(`WorkChallengeFrequency`, `Frequency`) %>% 
  summarise(`Count`= n()) %>% 
  mutate(`Ratio` = round(  ( `Count` / sum( `Count` ) ) * 100, digits = 2 ) ) %>% 
  factor( `Frequency`, levels = c("Most of the time", "Often" , "Sometimes", "Rarely") ) 
  ggplot(c,aes( x = WorkChallengeFrequency, y = Ratio, fill = Frequency,label = Ratio ) ) + 
  geom_bar( stat = "identity" ) + 
  geom_text(size = 2, position = position_stack(vjust = 0.5)) + 
  coord_flip() +  
  scale_fill_brewer(palette = 'RdYlBu') + 
  labs( title = "Frequency of Workplace Challenges", x = "Challenge", y = "Frequency" )