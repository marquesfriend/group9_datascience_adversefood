install.packages("ggplot2")
install.packages("dplyr")
library(dplyr)
library(plotly)
library(plyr)
library(ggplot2)


rm(list = ls())

# Reading in Data Set
raw_data <- read.csv("CAERS_ASCII_2004_2017Q2.csv")

# Gather only the observations that resulted in "DEATH"
deaths <- subset(raw_data , raw_data$AEC_One.Row.Outcomes == "DEATH")

# Gather the observations that did not have "Concomitant" as the Product Role
onlySuspect <- subset(deaths , deaths$PRI_Product.Role != "Concomitant")

# Count the brands that caused the most deaths
top <- count(onlySuspect$PRI_Reported.Brand.Product.Name)

# Change column name
colnames(top)[1] <- "Brand"
colnames(top)[2] <- "Deaths"

#Arrange the table from highest to lowest
top <- arrange(top,desc(Deaths))

#Create a new table and remove the "Redacted" observation 
topWithoutRedacted <- top
topWithoutRedacted <- subset(topWithoutRedacted , topWithoutRedacted$Brand != "REDACTED")


top5 <- head(topWithoutRedacted , n=5)

top5

# Change the value of row 1 and column 2 to "19"
top5[1,2] <- 19

#Assign top5 to another variable and remove the 3rd row
top4 <- top5[-c(3), ] 


#Plot the top 4 death causing brands
plot <- ggplot(data = top4, aes( x = Brand, y = Deaths ) ) +
  geom_bar(stat= "identity" ,fill="#4876FF") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  ggtitle("Highest Death Causing Brands")+
  theme(plot.title = element_text(hjust = 0.5))
  

plot

#Calculating the average number of deaths
averageNumberOfDeaths <- mean(topWithoutRedacted$Deaths)
averageNumberOfDeaths

