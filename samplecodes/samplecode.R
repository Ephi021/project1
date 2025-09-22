name <- readline(prompt = "Enter your name: ")

age_input <- readline(prompt = "Enter your age (number): ")

age <- as.integer(age_input)

if (is.na(age)) {
  cat("You didn't enter a valid number for age!\n")
} else {
  cat("Hello,", name, "!\n")
  cat("You are", age, "years old.\n")
}

