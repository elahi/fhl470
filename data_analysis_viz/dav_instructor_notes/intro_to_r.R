##' Robin Elahi 
##' intro-to-r
##' 2018-04-27

##### CREATING OBJECTS #####

3 + 5
7 / 12
3 * 5

##
weight_kg <- 55 # this is my weight
wt_kg <- 3
weight_kg

ls()

# rm(list = "wt_kg")
# rm(list = ls())

weight_kg * 2.2

weight_lb <- 2.2 * weight_kg

weight_kg
weight_lb

weight_kg <- 100

weight_lb <- 2.2 * weight_kg

##### FUNCTIONS #####

#' argument = input in a function
#' value = returned by a function
#' calling = executing
#' options = argument that has a default value, but that can be changed

round(3.14159)
args(round)
round(x = 3.14159, digits = 3)

round(3.14159, 3)
round(3, 3.141)

dat <- c(3.145, 10.913)
dat

##### VECTORS ######

# numeric 
weight_g <- c(50, 60, 65, 82)
weight_g

# character
animals <- c("mouse", "rat", "dog")
animals
mouse

length(weight_g)
length(animals)

class(weight_g)
class(animals)

str(weight_g)
str(animals)

## c()
weight_g <- c(weight_g, 90)
weight_g
weight_g <- c(30, weight_g)
weight_g

typeof(weight_g)
typeof(animals)

## other vector data types
integer(20)
weight_g_integer <- as.integer(weight_g)
str(weight_g_integer)
typeof(weight_g_integer)

## Logical
logical_vector <- c(TRUE, FALSE, TRUE)
typeof(logical_vector)

dat <- c(1, 5, 10, -3)
dat
my_logical_vector <- dat > 3

#' factor
#' matrices
#' arrays
#' dataframes
#' lists
#' 

animals
weight_g
my_list <- list(animals, weight_g)
my_list

## We’ve seen that atomic vectors can be of type character, 
## numeric (or double), integer, and logical. 
## But what happens if we try to mix these types in a single vector?

## What will happen in each of these examples?
# hint(use class() to check the data type)
## Why do you think it happens?
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

## How many values in combined_logical are "TRUE" as a 
## character in the following example?
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

## You’ve probably noticed that objects of different types get 
## converted into a single, shared type within a vector. 
## In R, we call converting objects from one class into another class coercion. 

##### SUBSETTING VECTORS #####

animals <- c("mouse", "rat", "dog", "cat")
animals[2]
animals[c(3,2)]

more_animals <- animals[c(1,2,3,2,1,4)]
more_animals

## Conditional subsetting
weight_g <- c(21, 23, 34, 39, 54)
weight_g[c(TRUE, FALSE, TRUE, FALSE, FALSE)]
weight_g[c(1, 3)]

# weight_g[c(TRUE, FALSE, TRUE, FALSE)]
# weight_g[c(TRUE, FALSE, TRUE)]
# weight_g[c(TRUE)]

## We use output from a logical test
weight_g
weight_g > 50

weight_g[weight_g > 50]

my_logical_test <- weight_g > 50
my_logical_test
weight_g[my_logical_test]

## Combining multiple tests
weight_g
weight_g[weight_g < 30 | weight_g > 50]

weight_g[weight_g > 30 | weight_g == 21]

weight_g[weight_g >= 30 & weight_g == 21]

weight_g <- 5
weight_g = 25
weight_g

## Function %in%
animals <- c("mouse", "rat", "dog", "cat")
animals[animals == "cat" | animals == "rat"]

animals %in% c("rat", "cat", "dog", "duck", "goat")

### Challenge 3

## Can you figure out why:
"four" >  "five" 

"four" > "flavor"

"four" < "five"

"zebra" > "apple"

"four" > "fruit"
