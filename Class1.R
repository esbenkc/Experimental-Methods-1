# Jaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
a <- 8; b <- 9;
10 -> c;
d <- "eleven";
e <- a * b;
f <- c(d, a);
g <- c(1,2,3,4);
g + 3;

class(g);
g <- NULL;
rm(g);

a_vector <- c("Søren","Lærke", "Verus", "Anne-Line");
a_vector <- c(a_vector, "Marcus");
a_vector[2:3];
b_vector <- a_vector[-1]; # Returns the a_vector without array element 1
b_vector <- a_vector[-1:-2]; # Returns the a_vector without 1 and 2
b_vector;

length(a_vector) > length(b_vector);

number_vector <- c(1,140,2,24);
sum(number_vector);
# alt + - = <- 

a_vector[-c(1:2)];
a_vector[c(1,3)];

a_vector <- c("Søren","Lærke", "Verus", "Anne-Line");
s_vector <- c(3,2,3,2);
s_vector;
a_vector + 2; # Clear binary operator mismatch
s_vector + 2;
class(a_vector);
class(s_vector);
sum(s_vector);
s_vector[1] * s_vector[2];
s_vector <- c(s_vector, "duck");
s_vector;
class(s_vector);
s_vector <- as.numeric(s_vector[-c(5)]);
s_vector

dataFrame <- data.frame(Name = c("Me", "Søren", "Verus"), Favorite = c("Person name", "Missekatter?", "Vovsers?"));
View(dataFrame);
dataFrame$Vovers <- c("Ja", "Ja", "Nej");
dataFrame$Missers <- c("Ja", "Nej", "Ja");

dataFrame$Vovers; # Returns a list of the column
dataFrame["Vovers"]; # Returns a one-column data-frame
dataFrame[,3]; # Returns a list of the columng

siblingData <- data.frame(Name = a_vector, Siblings = s_vector);

mean(siblingData$Siblings);
class(siblingData$Name);
siblingData$Name <- as.character(siblingData$Name);
siblingData <- rbind(siblingData,c("Jesus",1)); # Creates a whole neew wooorld!! A new row item
