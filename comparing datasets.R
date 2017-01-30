library(tidyverse)

roster_1516 <- read.delim("clipboard")
write_csv(roster_1516, "roster_1516.csv")

roster_1617 <- read.delim("clipboard")
write_csv(roster_1617, "roster_1617.csv")

roster_1516 <- read.csv("roster_1516.csv")
roster_1617 <- read.csv("roster_1617.csv")


#Check classes of roster_1
str(roster_1516) #roster_1$Player is a factor (fct). It needs to be a character (chr)
roster_1516$Player <- as.character(roster_1516$Player)
is.character(roster_1516$Player)


#Check classes of roster_2
str(roster_1617)#roster_2$Player is a factor (fct). It needs to be a character (chr)
roster_1617$Player <- as.character(roster_1617$Player)
is.character(roster_1617$Player)

#Which players from 1516 are in the roster for 1617?
roster_1516[which(roster_1516$Player %in% roster_1617$Player), ]

#Which players from 1516 are NOT (!) in the roster for 1617?
roster_1516[which(!(roster_1516$Player %in% roster_1617$Player)), ]

#But what about Matt Murray?
roster_1516[grep("Murray", roster_1516$Player), ]
roster_1617[grep("Murray", roster_1617$Player), ]

"Matt Murray" == "Matthew Murray"


#Adding a check column to a dataframe
roster_1516 <- roster_1516 %>% #Make changes to roster_1516 and assign it back to roster_1516
  mutate(check = Player %in% roster_1617$Player) #Create a new column that checks if the rows in Player column from roster_1516 match the rows in roster_1617

#Create a new dataframe with just the matches
new_dataframe <- roster_1516 %>% #Make changes to roster_1516 and assign it to a new object, new_dataframe
  filter(check == TRUE) #Filter only the rows where the check column is TRUE

#View the first 10 rows of new_dataframe
head(new_dataframe)



