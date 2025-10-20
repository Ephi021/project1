# R Basics (Part 2)

# ------------------------------------------------------------------------------
# The R Data Types
a <- 2 + 3     # numeric - floating point values
b <- "Hello World"   # character
c <- 4 < 5     # logical (is 4 less than 5)
d <- 3 + 4i    # complex
e <- 3L

#checking the type of data is using class()
class(a)
class(b)
class(c)
class(d)
class(e)

#additional examples
class(1:10) #indicates that this is an integer

# ------------------------------------------------------------------------------
#Conversion of Data types
#convert numeric to character
x <- 1001
class(x)

as.character(x)
class(x)

#using "factor" where Female = 1 and Male = 2 when converted into integer
gender <- factor(c("Male","Female","Female","Male","Female"))
class(gender)

as.integer(gender)

# ------------------------------------------------------------------------------
# Creating variables using the (<-)
#reserved words cannot be used as variable names
#special characterers such as $ or * cannot be used as a variable name
#A variable name is case sensitive
num1 <- 5 #num1 is the variable name that contains the data values
name <- "Jose Rizal"
age <- 18

#displaying the output
num1 #output is 5
name #output is "Jose Rizal"
age #output is 18


# ------------------------------------------------------------------------------
# Calculating with R
#Arithmetic Operations are used with numeric values to perform mathematical operations
# +(add); -(subtract); *(multiply); and /(divide)
6 + 9 #add
5 - 4 #subtract
x <- 5
x - 4

5 * 4 #multiply
10 / 5 #divide

help("+") #get the documentation from all the arithmetic operations
?"+"

?"<=" #get the documentation from relational operators


#-------------------------------------------------------------------------------
2^3 #to compute for power with ^ operator
31 %% 7 #compute for the modulus(remainder after division of 31 by 7 (mod 7)

31 %/% 7 #compute for the integer part of the fraction

#31 is the sum of its remainder plus seven times the integer part of the fraction
7 * 4 + 3

# ------------------------------------------------------------------------------
# Math functions
# min() is used to find the lowest number in a set
# max() is used to find the highest number in a set
a <- c(4,7,8)
min(a)
max(a)

#getting the mean() - calculate the average
x <- c(1:10)
mean(x)

#getting the median() - is the middle value in the list of numbers
z <- c(3,6,8,9,11)
median(z)

#getting the square root of a number using sqrt()
k1 <- 9 + 7
sqrt(k1)

log(exp(1)) #functions are evaluated from the inside first when using a nested equation
log(x = 32,base = 2)
log(8,2)

#quadratic formula
a <- 1
b <- 1
c <- -1
(-b + sqrt(b^2 - 4*a*c))/(2*a)
(-b - sqrt(b^2 - 4*a*c))/(2*a)
