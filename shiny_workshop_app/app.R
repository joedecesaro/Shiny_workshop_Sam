# Load packages ----
# save as "app.R" for R to look for a shiny app and make it one
librarian::shelf(shiny,
                 palmerpenguins,
                 palmerpenguins,
                 DT,
                 rsconnect)

# User Interface ----
ui <- fluidPage(
  # app title ----
  tags$h1("Joe's App"), # alternatively, you can use the h1() wrapper function

  # app subtitle ----
  p(strong("Exploring Antarctic Penguins and Temperatures")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass",
              label = "Select a range of body masses (g):",
              min = 2700, # min of slider
              max = 6300, # max of slider
              value = c(3000, 4000)), # where the slider will start
  # body mass output ----
  plotOutput(outputId = "bodyMass_scatterPlot"),
  
  # penguin data table output ----
  DT::dataTableOutput(outputId = "penguin_data")
)






# Server Instructions ----
server<- function(input, output) {
  
  # filter body masses ----
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% input$body_mass[1]:input$body_mass[2])
    
  })
  # render scatterplot----
  output$bodyMass_scatterPlot <- renderPlot({
    
    # code to generate scatterplot will go here, curly braces let us use as many lines of code as we can
    ggplot(data = na.omit(body_mass_df()), aes(x = flipper_length_mm,
                                  y = bill_length_mm,
                                  color = species,
                                  shape = species)) + 
      geom_point() + 
      scale_color_manual(values = c("Adelie" = "#FEA346", 
                                    "Chinstrap" = "#B251F1", 
                                    "Gentoo" = "#4BA4A4")) +
      scale_shape_manual(values = c("Adelie" = 19, 
                                    "Chinstrap" = 17, 
                                    "Gentoo" = 15)) +
      labs(x = "Flipper Length (mm)",
           y = "Bill Length (mm)",
           color = "Penguin Species",
           shape = "Penguin Species")
  }) 
  
  # render table ----
  output$penguin_data <- DT::renderDataTable({
    DT::datatable(penguins,
                  options = list(pageLength = 5),
                  caption = tags$caption(
                    style = 'caption-side: top; text-align: left;',
                    'Table 1: ', tags$em('Size measurements for adult foraging penguins near Palmer Station, Antarctica')))
  })
  
}

# combine ui and server into an app ----
shinyApp(ui = ui, server = server)


