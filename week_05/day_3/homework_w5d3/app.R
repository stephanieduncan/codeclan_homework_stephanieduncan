library(shiny)
library(tidyverse)
library(dplyr)



olympics_overall_medals <- CodeClanData::olympics_overall_medals



ui <- fluidPage(
    titlePanel(tags$h2("Five Country Medal Comparison")),
    
    tabsetPanel(
        tabPanel("Choose Season",
                 radioButtons(inputId = "season",
                              tags$h4("Summer or Winter Olympics?"),
                              choices = c("Winter", "Summer")
                 )
        )
        , tabPanel("Choose Medal", 
                   radioButtons(
                       inputId = "medal",
                       tags$h4("Choose Medal"),
                       choices = c("Gold", "Silver", "Bronze"))
        ), tabPanel("Plot",
                    plotOutput(outputId = "medal_plot")
        )
    )
)

server <- function(input, output) {
    
    output$medal_plot <- renderPlot({
        colour <- case_when(input$medal == "Gold" ~ "#ffeda0",
                            input$medal == "Silver" ~ "#636363",
                            input$medal == "Bronze" ~ "#d95f0e")
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%  
            ggplot() +
            aes(x = team, y = count) +
            geom_col(fill = colour) +
            theme_light() +
            theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
            labs(
                x = "Team",
                y = "Number of Medals"
            )
    })
}

shinyApp(ui = ui, server = server)