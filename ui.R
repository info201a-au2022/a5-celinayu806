
library(shiny)
library(tidyverse)
library(plotly)
data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

##Introduction
intro <- tabPanel(
  "Introduction",
  fluidPage(
    h2(style = "color:green", "Introduction"),
    img(src = "https://media.istockphoto.com/id/1340519929/photo/concept-depicting-the-issue-of-carbon-dioxide-emissions-and-its-impact-on-nature-in-the-form.jpg?s=612x612&w=0&k=20&c=6u0Q-VfW1YHp1qPRPXw-_zR3VlyZX-8xGuX6lWbd-rA=", 
        width = "50%", align = "right"),
    p("The dataset that was presented in this assignment gave me an influx of data that I could observe.
      There were so many different varaibles and I found myself having to refer to the codebook to even be able to 
      actually conceptualize what I wanted to measure. With that being said, after closely analyzing the data presented, 
      I knew that I wanted to choose very concrete and clear values. I wanted my data to be presented in a very clear 
      and concise way.
      "),
    p("Thus, the three relevant values of interest that I chose to focus on were the ",
      strong("Absoulute Growth of CO2 Emissions", inline = TRUE),
      ", ",
      strong("The Country with the Max Absoulute Growth of CO2 Emissions", inline = TRUE),
      ", and the ",
      strong("Amount of Change that Occurred within this Country in the  past 5 Years"),
      "."),
    p("I chose to focus on these values because I am interested to know which country does emit the most CO2
      and what the growth has looked like over the course of the years. I am using this project to really allow 
      me to research my own interests. Additionally, for my data visualization on the next tab I decided to narrow
      in my data on the top CO2 emitting countries for the year of 2020.   
      "),
    h2(style = "color:green", "Key Questions"),
    strong("What is the max absoulute growth of CO2 emissions across the world in the most recent calendar year?"),
    p("I started by flitering my dataset to figure out what the highest CO2 emission produced in was 2020.
      I found that the absolute growth value of the highest CO2 emissions produced in 2020 was ", 
      strong("215.217 million tonnes"),
      ".",
      "This was quite unsettling to discover because it is such a tremendous amount of emissions. It makes 
      me wonder which country it was which I will answer in my next question. 
      "),
    strong("Which country had the max growth of CO2 across the world in the most recent calendar year?"),
    p("Based on my previous finding, I was curious to find out which country had the max growth of this much CO2
      emissions. Through pulling the country from the data, I discouvered that the country that had the max growth
      of CO2 emissions in 2020 was",
      strong("China"),
      "."),
    strong("What is the difference in growth between 2020 and 5 years ago in China?"),
    p("Due to how high the absoulute growth was for China, I wanted to see how much the absolute growth per year 
    had changed over the past 5 years to further give myself a scope of the situation. I pulled the absolute 
    growth emission from 2015 and 2020 and subtracted them from each other to ultimately find the difference 
    in growth over the past 5 years to be ",
      strong("83.423 million tonnes."),
      "This was quite upsetting to learn.",
      
     )),
 
  )


# Chart Page
sidebar <- sidebarPanel(
  selectInput(
    inputId = "y_input",
    label = "Emission Measurement",
    choices = list(
      "Total Co2" = "co2",
      "Change in Co2" = "co2_growth_abs"),
    selected = "co2"
  ),
  radioButtons(
    inputId = "colorchoice",
    label = "Color Choice",
    choices = list(
      "Blue" = "Blue", 
      "Red" = "Red")
  )
  
)

visualization_main <- mainPanel(
  plotlyOutput(outputId = "co2_barchart"),
  h2(style = "color:green", "Main Purpose"),
  p("The purpose of the above data visualization is to display the top 10 countries with the highest CO2 emissions in 2020 and to also show
    the comparison between them. Additionally, I thought it would be beneficial to show the change in CO2 emissions for each country to provide
    more of a scope for everyone including myself. I specifically choose to evaluate the top 10 CO2 emission producing companies to really provide 
    more context for this topic and to kind of shine a lot on how they are negatively impacting our environment."),
  h2(style = "color:green", "Key Findings"),
  p("As we can see, the Total CO2 emissions chart shows a pretty wide range of CO2 emissions across the board. The most obvious is clearly China with 
    their emissions quite literally towering comparitively to the others. I would say this is somewhat expected due to the size of the country and the 
    denisty of their population which could be a heavy factor that contributes to the CO2 emissions. Then we have the United States which is second in 
    terms of highest CO2 emissions however it was no where near China. While the United States still holds a reasonable lead in front of the 
    other 8 countries but comparitively is still on the lower end of the range. India follows behind the US along with then Russia being our fourth."),
  p("Moving onto our second chart, some that I believe is very important to note is that the United States made a very huge effort to decrease their CO2 
  emissions because they have the biggest decrese in emissions as seen on the graph. As a matter of fact, all of the countries decreaseed in emissions 
  except for China, Iran, and Saudi Arabia. Something that I find intresting is that China holds the highest CO2 emissions and they are not improving at 
  all. It makes me wonder if there are any efforts at all being made or if the envrionment is just not apart of the countries values.")
)

page2 <- tabPanel(
  "Chart",
  sidebar,
  visualization_main
)
ui <- navbarPage(
  "CO2 Emissions",
  intro,
  page2
)
