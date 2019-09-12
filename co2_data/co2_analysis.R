global_carbon_dioxide_emissions_by_sector = read.csv("global-carbon-dioxide-emissions-by-sector.csv", header = TRUE)

global_carbon_dioxide_emissions_by_sector


#########################
### Excercice page 25 ###
#########################

runTimes <-
  c(18,
    16,
    18,
    24,
    23,
    22,
    22,
    23,
    26,
    29,
    32,
    34,
    34,
    36,
    36,
    43,
    42,
    49,
    46,
    46,
    57)
n <- length(runTimes)
mean <- sum(runTimes) / n
median <- runTimes[(n + 1) / 2]
mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
runMode <- mode(runTimes)
upper <- runTimes[length(runTimes) - ((n + 1) / 4)]
lower <- runTimes[(n + 1) / 4]
runRange <- runTimes[length(runTimes)] - runTimes[1]
interquartileRange <- upper - lower


