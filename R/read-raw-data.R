library(here)
library(readr)
library(dplyr)
library(tibble)

rawdata <- here("data", "raw", "Patient Satisfaction Survey.csv")
qnames <- as_tibble_col(c("timestamp", paste0("Q", 1:19)), column_name = "qname")

questions <- read_csv(rawdata, n_max = 0) %>% 
  t() %>% 
  tibble::as_tibble(rownames = "qtext") %>% 
  bind_cols(qnames) %>% 
  relocate(qname)

saveRDS(questions, here("data", "tidy", "questions.rds"))

data <- read_csv(rawdata, col_names = c("timestamp", paste0("Q", 1:19)), skip = 1)

yn <- c("Yes", "No", "Don't now")
agree <- c("Strongly agree", "Agree", "Not sure", "Disagree", "Strongly disagree")

data <- data %>% 
  mutate(Q1 = factor(Q1, levels = yn),
         Q2 = factor(Q2, levels = yn),
         Q3 = factor(Q3, levels = yn),
         Q4 = factor(Q4, levels = agree),
         Q5 = factor(Q5, levels = agree),
         Q6 = factor(Q6, levels = c("I was seen early",
                                    "Less than 15 minutes",
                                    "15 - 30 minutes",
                                    "30 minutes to an hour",
                                    "Over 1 hour",
                                    "Not sure")),
         Q7 = factor(Q7, levels = agree),
         Q8 = factor(Q8, levels = agree),
         Q9 = factor(Q9, levels = agree),
         Q10 = factor(Q10, levels = c("Comfortable",
                                      "Less uncomfortable than expected",
                                      "As uncomfortable as expected",
                                      "More uncomfortable than expected",
                                      "I had no expectations")),
         Q11 = factor(Q11, levels = agree),
         Q12 = factor(Q12, levels = agree),
         Q13 = factor(Q13, levels = agree),
         Q14 = factor(Q14, levels = agree),
         Q15 = factor(Q15, levels = agree),
         Q16 = factor(Q16, levels = agree),
         Q17 = factor(Q17, levels = agree),
         Q18 = factor(Q18, levels = c("Excellent",
                                      "Good",
                                      "Satisfactory",
                                      "Poor",
                                      "Very poor"))
         )

saveRDS(data, here("data", "tidy", "data.csv"))
