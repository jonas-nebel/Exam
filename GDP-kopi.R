#The very first thing that needs to be done is installing the Tidyverse package. 
#If you already have Tidyverse installed, this step can be skipped.
install.packages(“tidyverse”)

#Next we need to initialize the Tidyverse library to be able to use the tools it offers in creating a script
library(tidyverse)

#The data used here are spreadsheets, or CSV-files. 
#Make sure your working directory is set to the folder in which you store scripts and other things produced in R 
#The Data folder the paper instructed you to create should be in this folder.
#Then execute the following line
read_csv("Data/maddison-data-gdp-per-capita-in-2011us.csv")

#Renaming the CSV-file so it is easier to work with
GDP <- read_csv("Data/maddison-data-gdp-per-capita-in-2011us.csv")

#Inspecting the spreadsheet to make sure by a quick glance that it is not broken
#The inspection indicated that countries was gathered in a column called "Entity"
#Now filtering out the 6 chosen countries to make sure they all contain comparable data
Denmark <- GDP %>% filter(Entity == "Denmark")
Canada <- GDP %>% filter(Entity == "Canada")
Brazil <- GDP %>% filter(Entity == "Brazil")
Botswana <- GDP %>% filter(Entity == "Botswana")
Kenya <- GDP %>% filter(Entity == "Kenya")
Afghanistan <- GDP %>% filter(Entity == "Afghanistan")
#An inspection of the 6 new variables confirms that they all contain data from the same years

#Assigning all the countries to one value/variable
#This enables the possibility óne graphical illustrutaion that contains all countries
#As opposed to six illustrations with just one country.
#This simplifies the analysis, and makes it easier to compare the trends in GDP per capita
FocusGDP <- GDP %>% filter(Entity == "Afghanistan" | Entity == "Denmark" | Entity == "Canada" | Entity == "Botswana" | Entity == "Brazil" | Entity == "Kenya")

#The variable have to be modified further to align with the data in child obesity
#Child obesity had data from 1990 and every 5 years onwards until 2016
#Recoding the GDP variable to be able to make a direct comparison in form of a correlation test later
YearGDP <- FocusGDP %>% filter(Year == "1990" | Year == "1995" | Year == "2000" | Year == "2005" | Year == "2010" | Year == "2016")

#After an inspection of this new value steps are taken to improve the graphical illustration
#The column names are either not suited for a graphical illustration or just not descriptive enough
#Column names are therefore being renamed in the following way to avoid confusion
colnames(YearGDP)
colnames(YearGDP)[4] <- "GDPvalue"
colnames(YearGDP)[1] <- "Country" 

#The new value 'FocusObesity' is now ready for a graphical illustration
#To do this ggplot2 is used, which is a part of the Tidyverse package
#First thing done is initializing the library for ggplot2 to use the tools it offers
library(ggplot2)

#Since this assignment is interested in a development over time, it uses "geom_smooth"
#geom_smooth shows the what the average trend looks like
#Year is thrown on the x-axis since it is the undependent variable
#GDP per capita on the Y-axis since it is the dependent variable
ggplot(data = YearGDP) +
  geom_smooth(mapping = aes(x = Year, y = GDPvalue, color = Country))

#Correlation test done on the two deveplotments in each variable
cor.test(FocusObesity$PercentOfObeseChildren, YearGDP$GDPvalue)
#Correlation is 0.73 which suggest a strong correlation