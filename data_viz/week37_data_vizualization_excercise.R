#########################
### Comment data from ###
### beautiful dataviz ###
#########################

setwd("C:/Users/esben/Documents/Experimental-Methods-1/data_viz")
read.csv("commentdata.dat")

### User activity as +1 for each upvote and downvote in 15 minute intervals
### n = 30,000 for hidden 0 minutes, 30 minutes, and 60 minutes
### Score calculated