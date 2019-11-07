# Jaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
a <- 8
b <- 9

10 -> c

d <- "eleven"

e <- a * b

f <- c(d, a)

g <- c(1, 2, 3, 4)

g + 3


class(g)

g <- NULL

rm(g)


barrysBuddies <- c("Søren", "Lærke", "Verus", "Anne-Line")

barrysBuddies <- c(barrysBuddies, "Marcus")

barrysBuddies[2:3]

b_vector <-
  barrysBuddies[-1]
# Returns the barrysBuddies without array element 1
b_vector <- barrysBuddies[-1:-2]
# Returns the barrysBuddies without 1 and 2
b_vector


length(barrysBuddies) > length(b_vector)


number_vector <- c(1, 140, 2, 24)

sum(number_vector)

# alt + - = <-

barrysBuddies[-c(1:2)]

barrysBuddies[c(1, 3)]


dataFrame <-
  data.frame(
    Name = c("Me", "Søren", "Verus"),
    Favorite = c("Person name", "Missekatter?", "Vovsers?")
  )

View(dataFrame)

dataFrame$Vovers <- c("Ja", "Ja", "Nej")

dataFrame$Missers <- c("Ja", "Nej", "Ja")


dataFrame$Vovers
# Returns a list of the column
dataFrame["Vovers"]
# Returns a one-column data-frame
dataFrame[, 3]
# Returns a list of the columng

siblingData <- data.frame(Name = barrysBuddies, Siblings = siblings)


mean(siblingData$Siblings)

class(siblingData$Name)

siblingData$Name <- as.character(siblingData$Name)

siblingData <-
  rbind(siblingData, c("Jesus", 1))
# Creates a whole neew wooorld!! A new row item

##################
### Excercises ###
##################

barrysBuddies <- c("Søren", "Lærke", "Verus", "Anne-Line")

siblings <- c(3, 2, 3, 2)

siblings

#barrysBuddies + 2
# Clear binary operator mismatch
#siblings + 2

### Check class of the vectors
class(barrysBuddies)
class(siblings)
sum(siblings)

### Product of person 1 and 2's sibling numbers
siblings[1] * siblings[2]

# siblings <- c(siblings, "duck")
# siblings
# class(siblings)

siblings <- as.numeric(siblings[-c(5)])

siblings

### Excercise 2 ###

barrysBuddiesData <- data.frame(barrysBuddies, siblings)

barrysBuddiesData

barrysBuddiesData$gender <- c("Male","Female","Female","Female")

barrysBuddiesData

barrysBuddiesData$barrysBuddies <- as.character(barrysBuddiesData$barrysBuddies)

barrysBuddiesData <- rbind(barrysBuddiesData, c("Esben",1,"Male"))

barrysBuddiesData

barrysBuddiesData$siblings <- as.numeric(barrysBuddiesData$siblings)

mean(barrysBuddiesData$siblings)

barrysBuddiesData

### Finding hypothesized sibling amounts and finding the difference

barrysBuddiesData$hypothesizedSiblings <- c(1,2,0,2,3)

barrysBuddiesData$deviation <- abs(barrysBuddiesData$siblings - barrysBuddiesData$hypothesizedSiblings)

barrysBuddiesData$deviation

###################
### Excercise 3 ###
###################

barrysBuddiesData

withThreeSiblings <- subset(barrysBuddiesData, c("siblings") == 3,select = c("barrysBuddies","siblings","gender"))

withThreeSiblings

