#Loading the neccessary apps

library(tidyverse)
library(shiny)
library(ggplot2)
library(shinythemes)

#Reading in the data
games_sales <- CodeClanData::game_sales

#Creating user interface
ui <- fluidPage(
    theme = shinytheme("cerulean"),
    titlePanel("Games"),
#using fluidRow to make drop down menus fit aesthetically on the page    
    fluidRow(
#creating a drop down menu to allow user to show data based on selected genre
    column(2,
           selectInput("genre",
                       "Select Genre",
                       choices = unique(games_sales$genre))
    ),
#creating a drop down menu to allow user to show data based on selected platform
    column(2,
           selectInput("platform",
                       "Select Platform",
                       choices = unique(games_sales$platform))
    ),
br(),
#adding an action button to update the table only once the button has been pressed
    fluidRow(
        column(2,
           actionButton("update", "Show Games") 
)
)
),
    
#showing a table of the data to be able to search for specific game titles.
        column(6, 
#using DT::dataTableOutput to add a search feature to allow user to search the data by typing into a search box
               DT::dataTableOutput("games_table")
        ),
column(12,
       plotOutput("games_col")
)
)
server <- function(input, output) {
    
    games_data_filtered <- eventReactive(input$update, {
        games_sales %>% 
            filter(genre == input$genre) %>% 
            filter(platform == input$platform) %>% 
#removing data irrelevant to user from table output
            select(- sales, -developer, -publisher, -rating)
    })
                                
#using DT::dataTableOutput to add a search feature to allow user to search the data by typing into a search box
    output$games_table <- DT::renderDataTable({
        games_data_filtered()
})
    
    output$games_col <- renderPlot({
#Creating a graph to show the user the game ratings for each game title by user rating        
     ggplot(games_data_filtered()) +
            geom_col(aes (x = name, y = user_score, fill = name)) +
        theme_light() +
            theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
            labs(
                title = "User Rating of Games",
                x = "Game Title",
                y = "User Score"
            ) +
            scale_y_continuous(limits = c(0, 10)) +
            theme(legend.position = "none") +
            theme(title = element_text(size = 25)) +
            theme(text = element_text(size = 12)) +
            theme(axis.text = element_text(size = 11))
            
        
    })
}

shinyApp(ui = ui, server = server)    