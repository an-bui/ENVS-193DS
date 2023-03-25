
##########################################################################-
# 0. Introduction to Scripts ----------------------------------------------
##########################################################################-

# This is an R Script. It allows you to write your code (recipe) and run the code in the console (kitchen).

# R considers everything in the script as code to run, so you can write comments in the R Script by putting a pound sign at the beginning of the line. This is especially useful when you want to explain what your code is doing at each line in plain language.

# Try writing a comment of your own in the line below.


##########################################################################-
# 1. Assigning values to objects ------------------------------------------
##########################################################################-

# We'll start with some basics. We'll assign values to objects.

# assign the number 5 to an object called snail_length
snail_length <- 5

# print snail_length
snail_length
# you'll see the output of this in the console, not your script.

# Now that you've assigned this value to an object, you can start to work with it.
# Let's see what snail_length/2 is.
snail_length/2
# This doesn't change the value of snail_length - check this in the console.

# You can save this new variable as another object.
half <- snail_length/2

##########################################################################-
# 2. Using functions ------------------------------------------------------
##########################################################################-

# Functions are where R gets interesting. R allows you to apply functions to do calculations, from simple to complex structures.

# We can start by calculating the square root of snail_length.
sqrt(snail_length)

# We might not want all the digits in that calculation, so we could round it using the round() function.
round(sqrt(snail_length))

# This rounds root to 4. However, we want to be a little more precise than that. Check out what round() does in the console by typing ?round.

# Let's round root to 3 digits instead of the next whole number.
round(sqrt(snail_length), digits = 3)

##########################################################################-
# 3. Basic sorting and filtering ------------------------------------------
##########################################################################-

# Now, let's try a vector of numbers. Let's say that we measured a bunch of different fish and recorded their weights in kilograms.
fish_weights <- c(1, 2, 3, 1, 2)

# Let's say "small" fish are any fish that are < 2 kilograms. We want to know the weights of all the "small" fish that we collected.
fish_weights[fish_weights < 2]

# What if we want all the "big" fish?
fish_weights[fish_weights > 2]

##########################################################################-
# 4. Packages -------------------------------------------------------------
##########################################################################-

# Packages (or libraries) have functions that aren't already built into R.

# You can install packages in one of two ways. The first (most common) way is to use the function`install.packages()`. This is for any package that is on CRAN, or the Comprehensive R Archive Network. Try installing the package `tidyverse` using the following command:
# install.packages("tidyverse")

# Now you have a package installed! But you now need to "load it in". Installing a package is like buying a pan - you only need to do it once if you want to cook. However, you still need to put the pan on the stove in order to start cooking.

# You can load in any package using the function `(library)`. Try loading in the package below.

# Nothing shows up once you've loaded in the package, but now you're ready to use the functions in it!

##########################################################################-
# 5. working with data in R -----------------------------------------------
##########################################################################-

# Later in the quarter, we'll work with data sets from real examples (i.e. from research). To get acquainted with how to work with data in R, we'll use some of the built-in examples. Go to https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html to see the list of data sets that are pre-installed with R. The topics are all over the place, but they are useful for testing things out if the data you have to work with is big and unwieldy.

# One of the packages that has a cool dataset to test things out with is called `palmerpenguins`. Install it in your console and load it in to your environment.

# What is {palmerpenguins}? Read about it here: https://allisonhorst.github.io/palmerpenguins/

# The first step to using data is looking at it! Use `View(penguins)` to see what it is. 
# (Hint: did that not work? Remember to load in the package before you start using it.)

# `penguins` is a data frame. Data frames have rows and columns, and their cells contain data. In this case, this data frame has 8 columns and 344 rows, which you can see in the visual display.

# Figure out what the columns are by using`colnames(penguins)`

# In a comment below, write out 1) the column name, 2) what type of variable it is, and 3) what data are in them. For example:
# species: categorical, penguin species
# island: categorical, islands were penguins were sampled
# bill_length_mm: continuous, bill length in mm
# bill_depth_mm: continuous, bill depth in mm
# flipper_length_mm: continuous, flipper length in mm
# body_mass_g: continuous, body mass in grams
# sex: categorical, male or female
# year: categorical (ordinal), year sampled

# You can learn about the structure of a data frame by running the function `str()`. What is the output for that?


# Let's figure out some basic information about the data set. What's the longest bill length they measured on a penguin? Save that as an object called `long_bill`.
long_bill <- 59.6

# We did that visually, but you can do that in code. The function `max()` allows you to get the maximum number in a vector, which is a list of numbers. (Note: how would you double check how the function works if you hadn't used it before?)
max(penguins$bill_length_mm)

# Huh. That was weird. We knew the longest bill was 59.6, but why does this say NA?
max(penguins$bill_length_mm, na.rm = TRUE)

# That's a lot better!

# Try finding the minimum bill length, and saving that as an object called `short_bill`.

##########################################################################-
# 6. data exploration -----------------------------------------------------
##########################################################################-

# Let's say you think the three different penguin species have different body masses, on average. This is where the `tidyverse` package we were using before comes in handy.

# We know that there's a column in the data frame that has species, and another column that has body masses. So if there's a way we can get all the rows belonging to a species, then take all the numbers for body mass and average them, we can figure out the average body mass for a penguin species in the sample.

# there are tidyverse functions that can help with that:
# `group_by()`: identifying natural groups in the data frame (categorical variables) 
# `summarize()`: summarizes the data based on what you want
# %>% : a very!!! useful operator (not a function). This is called a "pipe" and it allows you to string functions together. You're basically telling R, "... and then". An example below:

# tell R what data frame you want to use
penguins %>% 
  # and then, group the data frame by species
  group_by(species) %>% 
  # and then, summarize: create a new column called `mean_body_mass` from body_mass_g
  summarize(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

# Try figuring out what the maximum flipper length is by island.

penguins %>% 
  group_by(island) %>% 
  summarize(max_flipper_length = max(flipper_length_mm, na.rm = TRUE))

# You can also group by multiple columns.

penguins %>% 
  group_by(island, species) %>% 
  summarize(max_flipper_length = max(flipper_length_mm, na.rm = TRUE))
  
# What if you only want Biscoe island? 
# `filter()`: filters a data frame by data in a column

penguins %>% 
  filter(island == "Biscoe") %>% 
  group_by(species) %>% 
  summarize(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

and_vertebrates %>% 
  group_by(species) %>% 
  tally()









