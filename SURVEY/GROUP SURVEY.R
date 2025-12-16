library(tidyverse)
library(ggplot2)
library(scales)
library(forcats)
library(readxl)

survey_xlsx <- read_excel("survey_data.xlsx")
write.csv(survey_xlsx, "Survey.csv", row.names = FALSE)
survey_data <- as.data.frame(survey_xlsx)

clean_names <- function(names) {
  names <- gsub("\\.", "_", names)
  names <- gsub(" ", "_", names)
  names <- gsub("__", "_", names)
  names <- gsub("_$", "", names)
  return(names)
}
colnames(survey_data) <- clean_names(colnames(survey_data))

likert_columns <- 8:13
names(likert_columns) <- c(
  "Continuing_studies_better_long_term",
  "Freelancing_faster_income",
  "Confident_freelancer_without_degree",
  "College_degree_important",
  "Freelancing_more_freedom",
  "Confident_reaching_dream_job"
)

for (i in seq_along(likert_columns)) {
  survey_data[[names(likert_columns)[i]]] <- factor(
    survey_data[[likert_columns[i]]],
    levels = 1:5,
    labels = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"),
    ordered = TRUE
  )
}

question_col <- grep("quit_studying.*freelancing.*continue", colnames(survey_data), value = TRUE)[1]

plot_single_choice <- function(column, title, fill_colors = c("steelblue", "orange")) {
  df <- survey_data %>%
    filter(!is.na(.data[[column]])) %>%
    count(.data[[column]]) %>%
    mutate(percentage = n / sum(n) * 100)
  
  ggplot(df, aes(x = .data[[column]], y = percentage, fill = .data[[column]])) +
    geom_bar(stat = "identity", width = 0.6) +
    geom_text(aes(label = paste0(round(percentage,1), "%")), vjust = -0.3, size = 3) +
    scale_fill_manual(values = fill_colors) +
    scale_y_continuous(expand = expansion(mult = c(0,0.15))) +
    labs(title = title, x = NULL, y = "Percentage") +
    base_theme +
    theme(legend.position = "none")
}

base_theme <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(size = 13, face = "bold"),
    axis.text.x = element_text(angle = 30, hjust = 1),
    plot.margin = margin(5, 5, 5, 5)
  )

print(plot_single_choice(question_col, "1. Would you quit studying and do freelancing or continue studying?"))

base_theme <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(size = 13, face = "bold"),
    axis.text.x = element_text(angle = 30, hjust = 1),
    plot.margin = margin(5, 5, 5, 5)
  )

create_likert_chart <- function(question_data, title) {
  summary <- data.frame(Response = question_data) %>%
    filter(!is.na(Response)) %>%
    count(Response) %>%
    mutate(percentage = n / sum(n) * 100)
  
  ggplot(summary, aes(Response, percentage, fill = Response)) +
    geom_bar(stat = "identity", width = 0.7) +
    geom_text(
      aes(label = paste0(round(percentage,1), "%")),
      vjust = -0.3,
      size = 3
    ) +
    scale_y_continuous(
      labels = percent_format(scale = 1),
      limits = c(0, max(summary$percentage) * 1.15)
    ) +
    scale_fill_brewer(palette = "RdYlBu", direction = -1) +
    labs(title = title, x = NULL, y = "Percentage") +
    base_theme +
    theme(legend.position = "none")
}

likert_titles <- c(
  "2. Freelancing offers faster income",
  "3. Confidence freelancing without a degree",
  "4. College degree is important",
  "5. Freelancing gives more freedom",
  "6. Confidence reaching dream job"
)

p_q2 <- create_likert_chart(survey_data$Freelancing_faster_income, 
                            "2. Freelancing offers faster income")
print(p_q2)

p_q3 <- create_likert_chart(survey_data$Confident_freelancer_without_degree, 
                            "3. Confidence freelancing without a degree")
print(p_q3)

p_q4 <- create_likert_chart(survey_data$College_degree_important, 
                            "4. College degree is important")
print(p_q4)

p_q5 <- create_likert_chart(survey_data$Freelancing_more_freedom, 
                            "5. Freelancing gives more freedom")
print(p_q5)

p_q6 <- create_likert_chart(survey_data$Confident_reaching_dream_job, 
                            "6. Confidence reaching dream job")
print(p_q6)

mc_columns <- 15:18
names(mc_columns) <- c(
  "Factors_affecting_decision",
  "Concerns_quitting_studies",
  "Benefits_freelancing",
  "Motivations_continue_studying"
)

process_multiple_choice <- function(column_name, title) {
  if (!column_name %in% colnames(survey_data)) {
    cat(paste("Column", column_name, "not found.\n"))
    return(NULL)
  }
  
  column_data <- survey_data[[column_name]]
  
  all_choices <- character()
  
  for (response in as.character(column_data)) {
    if (!is.na(response) && response != "") {
      split_choices <- unlist(strsplit(response, ",\\s*"))
      all_choices <- c(all_choices, split_choices)
    }
  }
  
  if (length(all_choices) == 0) {
    cat(paste("No data for", title, "\n"))
    return(NULL)
  }
  
  summary_df <- data.frame(Choice = all_choices) %>%
    filter(Choice != "") %>%
    count(Choice) %>%
    mutate(percentage = n / sum(n) * 100) %>%
    arrange(desc(n))
  
  p <- ggplot(summary_df, aes(x = reorder(Choice, n), y = percentage)) +
    geom_bar(stat = "identity", fill = "steelblue", width = 0.7) +
    geom_text(
      aes(label = paste0(round(percentage, 1), "%")),
      hjust = -0.1,
      size = 3
    ) +
    coord_flip(clip = "off") +
    scale_y_continuous(
      expand = expansion(mult = c(0, 0.15)),
      limits = c(0, max(summary_df$percentage) * 1.2)
    ) +
    labs(title = title, x = NULL, y = "Percentage") +
    base_theme
  
  return(p)
}

mc_titles <- c(
  "7. Factors Affecting Decision",
  "8. Concerns About Quitting Studies",
  "9. Benefits of Freelancing",
  "10. Motivations to Continue Studying"
)

mc_column_names <- colnames(survey_data)[mc_columns]

if (1 <= length(mc_column_names)) {
  p7 <- process_multiple_choice(mc_column_names[1], mc_titles[1])
  if (!is.null(p7)) {
    print(p7)
  }
}

if (2 <= length(mc_column_names)) {
  p8 <- process_multiple_choice(mc_column_names[2], mc_titles[2])
  if (!is.null(p8)) {
    print(p8)
  }
}

if (3 <= length(mc_column_names)) {
  p9 <- process_multiple_choice(mc_column_names[3], mc_titles[3])
  if (!is.null(p9)) {
    print(p9)
  }
}

if (4 <= length(mc_column_names)) {
  p10 <- process_multiple_choice(mc_column_names[4], mc_titles[4])
  if (!is.null(p10)) {
    print(p10)
  }
}

question11_col <- grep("stable.*income", colnames(survey_data), value = TRUE)[1]
question12_col <- grep("mental.*well", colnames(survey_data), value = TRUE)[1]

plot_yesno <- function(column, title, fill_color) {
  df <- survey_data %>%
    filter(!is.na(.data[[column]])) %>%
    count(.data[[column]]) %>%
    mutate(percentage = n/sum(n)*100)
  
  ggplot(df, aes(as.factor(.data[[column]]), percentage)) +
    geom_bar(stat = "identity", fill = fill_color, width = 0.6) +
    geom_text(
      aes(label = paste0(round(percentage,1), "%")),
      vjust = -0.3,
      size = 3
    ) +
    scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
    labs(title = title, x = NULL, y = "Percentage") +
    base_theme
}

print(plot_yesno(
  question11_col,
  "11. Quit studying if freelancing guaranteed income?",
  "darkgreen"
))

print(plot_yesno(
  question12_col,
  "12. Continue studying if jobs care about well-being?",
  "purple"
))

if ("Gender" %in% colnames(survey_data)) {
  p_gender <- ggplot(survey_data, aes(Gender)) +
    geom_bar(fill = "coral", width = 0.6) +
    labs(title = "Gender Distribution", x = NULL, y = "Count") +
    base_theme 
  
  print(p_gender)
}

if ("Age" %in% colnames(survey_data)) {
  survey_data$Age <- as.numeric(survey_data$Age)
  
  p_age <- ggplot(survey_data, aes(Age)) +
    geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
    labs(title = "Age Distribution", x = "Age", y = "Count") +
    base_theme 
  
  print(p_age)
}

