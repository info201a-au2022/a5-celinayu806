
library(dplyr)
library(tidyverse)
library(plotly)
data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
source("ui.R")


data_cleaned <- data %>%
  filter(country != "Antarctica") %>%
  filter(country != "Asia") %>%
  filter(country != "South America") %>%
  filter(country != "North America (excl. USA)") %>%
  filter(country != "North America") %>%
  filter(country != "World") %>%
  filter(country != "Europe") %>%
  filter(country != "Africa") %>%
  filter(country != "Oceania") %>%
  filter(country != "EU-27") %>%
  filter(country != "EU-28") %>%
  filter(country != "Asia (excl. China & India)") %>%
  filter(country != "Europe (excl. EU-27)") %>%
  filter(country != "Europe (excl. EU-28)") %>%
  filter(country != "International transport") %>%
  filter(country != "High-income countries") %>%
  filter(country != "European Union (28)") %>%
  filter(country != "European Union (27)") %>%
  filter(country != "Lower-middle-income countries") %>%
  filter(country != "Asia (excl. China and India)") %>%
  filter(country != "Upper-middle-income countries")
  

#Values: 
#What is the max absoulute growth of CO2 emissions across the world in the most recent calendar year? 
Co2_max_growth <- data_cleaned %>%
  filter(year == "2020") %>%
  filter(co2_growth_abs == max(co2_growth_abs, na.rm = TRUE)) %>%
  pull(co2_growth_abs)

#Which country had the max growth of CO2 across the world in the most recent calendar year? 
Co2_max_country <- data_cleaned %>%
  filter(year == "2020") %>%
  filter(co2_growth_abs == max(co2_growth_abs, na.rm = TRUE)) %>%
  pull(country)
#How much has the absolute growth changed in this nation over the past 5 years?
Co2_growth_5 <- data_cleaned %>%
  filter(year == "2015") %>%
  filter(co2_growth_abs == max(co2_growth_abs, na.rm = TRUE)) %>%
  pull(co2_growth_abs)

diff_5 <- Co2_max_growth_rate - Co2_rate_5

#Part 2
top10_growth_countrydftemp <- data_cleaned %>%
  filter(year == "2020") %>%
  summarise(country = country, co2_growth_abs = co2_growth_abs, co2 = co2)

newdfffff <- na.omit(top10_growth_countrydftemp)

temp2df <- newdfffff %>%
  arrange(desc(co2))

tempppp <- temp2df %>%
  top_n(10)

##CHART

templabs <- list("co2 = Total Co2 Emission",
                 "co2_growth_abs = Change in Co2 Emissions")

server <- function(input, output) {
  
output$co2_barchart <- renderPlotly({
  df <-tempppp
  plot <- ggplot(data = df) + 
    geom_col(color = input$colorchoice, mapping = aes (x = country, y = !!as.name(input$y_input))) +
    labs(x = "country", y = templabs[[input$y_input]]) 
  
  return(plot)
})
}






