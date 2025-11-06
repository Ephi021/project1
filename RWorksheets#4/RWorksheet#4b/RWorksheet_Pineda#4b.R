#Using Loop Function for() loop

#1.) Using the for loop, create an R script that will display a 5x5 matrix as shown in Figure 1. It must contain vectorA = [1,2,3,4,5] and a 5 x 5 zero matrix.
#Hint Use abs() function to get the absolute value

vectorA <- c(1, 2, 3, 4, 5)
matrix_result <- matrix(0, nrow = 5, ncol = 5)

for (i in 1:5) {
  for (j in 1:5) {
    matrix_result[i, j] <- abs(i - j)
  }
}

print(matrix_result)



#2.) Print the string "*" using for() function. The output should be the same as shown in Figure

for (i in 1:5) {
  for (j in 1:i) {
    cat("* ")
  }
  cat("\n")
}

#Output:
#"* 
#"* * 
#"* * * 
#"* * * * 
#"* * * * * 
  


#3. Get an input from the user to print the Fibonacci sequence starting from the 1st input
#up to 500. Use repeat and break statements. Write the R Scripts and its output.

first <- as.numeric(readline(prompt = "Enter first number: "))
second <- as.numeric(readline(prompt = "Enter second number: "))

cat(first, second, " ")

repeat {
  next_num <- first + second
  if (next_num > 500) {
    break
  }
  cat(next_num, " ")
  first <- second
  second <- next_num
}

#Output:
#Enter first number: 1
#Enter second number: 1
#1 1 2 3 5 8 13 21 34 55 89 144 233 377



Using Basic Graphics (plot(),barplot(),pie(),hist())

#4. Import the dataset as shown in Figure 1 you have created previously.

#a. What is the R script for importing an excel or a csv file? Display the first 6 rows of the dataset? Show your codes and its result

shoe_data <- read.csv("shoe_sizes.csv")

head(shoe_data)

#Output:
#  Shoe.size Height Gender
#1       6.5   66.0      F
#2       9.0   68.0      F
#3       8.5   64.5      F
#4       8.5   65.0      F
#5      10.5   70.0      F
#6       8.5   66.0      F


#b. Create a subset for gender(female and male). How many observations are there in Male? How about in Female? Write the R scripts and its output.

female <- subset(shoe_data, Gender == "F")
male <- subset(shoe_data, Gender == "M")

cat("Number of Female observations:", nrow(female), "\n")
cat("Number of Male observations:", nrow(male), "\n")

#Output:
#Number of Female observations: 13 
#Number of Male observations: 12 


#c. Create a graph for the number of males and females for Household Data. Use plot(), chart type = barplot. Make sure to place title, legends, and colors. Write the R scripts and its result.

gender_count <- table(shoe_data$Gender)

barplot(gender_count,
        main = "Number of Males and Females in Shoe Size Data",
        xlab = "Gender",
        ylab = "Count",
        col = c("pink", "lightblue"),
        legend.text = c("Female", "Male"))



#5.) The monthly income of Dela Cruz family was spent on the following:
#Food  Electricity  Savings  Miscellaneous
# 60        10         5          25

#a. Create a piechart that will include labels in percentage.Add some colors and title of the chart. Write the R scripts and show its output.
# Data

expenses <- c(60, 10, 5, 25)
categories <- c("Food", "Electricity", "Savings", "Miscellaneous")

percent <- round(expenses / sum(expenses) * 100)

labels <- paste(categories, percent, "%")

pie(expenses,
    labels = labels,
    col = c("gold", "skyblue", "lightgreen", "tomato"),
    main = "Monthly Income Distribution of Dela Cruz Family")



#6.) Use the iris dataset.
#data(iris)

#a. Check for the structure of the dataset using the str() function. Describe what you have seen in the output.

data(iris)

str(iris)

#Output:
#'data.frame':	150 obs. of  5 variables:
#$ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#$ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#$ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#$ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#$ Species     : Factor w/ 3 levels "setosa","versicolor","virginica": 1 1 1 1 1 1 1 1 1 1 ...


#b. Create an R object that will contain the mean of the sepal.length, sepal.width,petal.length,and petal.width. What is the R script and its result?

iris_means <- colMeans(iris[, 1:4])

iris_means

#Output:
# Sepal.Length  Sepal.Width  Petal.Length   Petal.Width 
#5.843333      3.057333      3.758000      1.199333 


#c. Create a pie chart for the Species distribution. Add title, legends, and colors. Write the R script and its result.

species_count <- table(iris$Species)

pie(species_count,
    labels = names(species_count),
    col = c("lightgreen", "skyblue", "pink"),
    main = "Distribution of Iris Species")

legend("topright",
       legend = names(species_count),
       fill = c("lightgreen", "skyblue", "pink"))


#d. Subset the species into setosa, versicolor, and virginica. Write the R scripts and show the last six (6) rows of each species.

setosa <- subset(iris, Species == "setosa")
versicolor <- subset(iris, Species == "versicolor")
virginica <- subset(iris, Species == "virginica")

tail(setosa)
tail(versicolor)
tail(virginica)

#Output:
#    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#45           4.8         3.0          1.4         0.3  setosa
#46           5.1         3.8          1.6         0.2  setosa
#47           4.6         3.2          1.4         0.2  setosa
#48           5.3         3.7          1.5         0.2  setosa
#49           5.0         3.3          1.4         0.2  setosa
#50           5.0         3.3          1.4         0.2  setosa


#e. Create a scatterplot of the sepal.length and sepal.width using the different species(setosa,versicolor,virginica). Add a title = “Iris Dataset”, subtitle = “Sepal width and length, labels for the x and y axis, the pch symbol and colors should be based on the species.
#Hint: Need to convert to factors the species to store categorical variables.

iris$Species <- as.factor(iris$Species)

plot(iris$Sepal.Length, iris$Sepal.Width,
     col = c("red", "green", "blue")[iris$Species],
     pch = 19,
     main = "Iris Dataset",
     sub = "Sepal Width and Length",
     xlab = "Sepal Length (cm)",
     ylab = "Sepal Width (cm)")

legend("topright",
       legend = levels(iris$Species),
       col = c("red", "green", "blue"),
       pch = 19)


#f. Interpret the result.

#Setosa flowers generally have shorter sepal lengths but wider sepals.
#Versicolor species lie in the middle range for both measurements.
#Virginica species have longer sepals and narrower widths.
#This shows how sepal dimensions can be used to distinguish between iris species.



