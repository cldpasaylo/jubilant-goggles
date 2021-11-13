library(shiny)
library(shinythemes)
library(ggplot2)

source("curl.R")

#UI
ui <- navbarPage(
  theme = shinytheme("slate"),
  "MovieAnalysis", 
  tabPanel(
    "Home",
    sidebarPanel(
      tags$h3("Select Input"),
      selectInput(
        "type", 
        "Select Type:",
        choices = c("Movies" = "Movie", 
                    "TV Show" = "TV Show")
      ), #select input type
      hr(),
      helpText("Data from Kaggle, Netflix Movies and TV Shows.")
    ), #sidebar Panel
    mainPanel(
      h3("Data Visualization"),
      h5("A visualization of 10 countries in Asia, and visualization of netflix ratings that differ from Movies and TV Shows."),
      
      br(),
      h4("Duration of the Movies and TV Shows of 10 Countries"),
      plotOutput("netflixtype"),
      h5("- It is visible that there is more Movies in India, rather than a TV Shows compare to the other country."),
      h5("- On the other hand, there is more TV Shows in Japan and Korea, while India is only 3rd of having TV Shows."),
      
      br(),
      h4("Netflix Ratings"),
      plotOutput("netflixratings"),
      h5("- In Netflix Movies, it is visible that TV-14 rating has more ratings then the TV-MA rating and TV-PG rating"),
      h5("- In Netflix TV Showws, TV-14 has also higher rating, followed by TV-MA nad TV-PG"),
    ) #main Panel
  ), #navbar1 tab panel
  tabPanel(
    "About",
    sidebarPanel(
      tags$h3("DATASET: "),
      tags$div(
        "You can download the Netflix Movies and TV Shows ",
        tags$a(href = "https://www.kaggle.com/shivamb/netflix-shows",
               "dataset at kaggle.com"),
      ),
    ),
    mainPanel(
      h3("ABOUT THE DATASET"),
      h5(
        "Netflix is one of the most popular media and video streaming platforms. 
            They have over 8000 movies or tv shows available on their platform, as of mid-2021, they have over 200M Subscribers globally. 
            This tabular dataset consists of listings of all the movies and tv shows available on Netflix, along with details such as - cast, directors, ratings, release year, duration, etc"
      ),
      h5("Interesting Task Ideas:"),
      h5("1. Understanding what content is available in different countries"),
      h5("2. Identifying similar content by matching text-based features"),
      h5("3. Network analysis of Actors / Directors and find interesting insights"),
      h5("4. Does Netflix has more focus on TV Shows than movies in recent years."),
    )
  )#navbar2 tab panel
) #navigation bar 

#SERVER
server <- function(input, output) {
  output$netflixtype <- renderPlot({
    fil.type <- net.filter %>%
      filter(type == input$type)
    
    ggplot(fil.type) +
      geom_bar(mapping = aes(country, fill = country)) +
      labs(title = paste(input$type, "Type Count of 10 Countries"),
           x = "Countries",
           y = "Count")
  }) #netflix type
  output$netflixratings <- renderPlot({
    fil.ratings <- net.filter %>%
      filter(type == input$type)
    
    ggplot(fil.ratings) +
      geom_bar(mapping = aes(rating, fill = rating), na.rm = TRUE) +
      labs(title = paste(input$type, " Ratings"),
           x = "Ratings",
           y = "Count")
  }) #netflix ratings
} #server

#ShinyApp
shinyApp(ui = ui, server = server)
