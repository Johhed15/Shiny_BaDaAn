
library(shiny)
#devtools::install_github('wountoto/Lab5_AdvR',subdir = 'BaDaAn')
library(BaDaAn)


ui <- fluidPage(
  
  tabsetPanel(
    tabPanel("Visualization",
             titlePanel("Analyse with visualization"),
            selectInput('mun', 'Plot cost variables for a municipality',
                        c('Stockholm' = 'Stockholm',
                        'Uppsala' = 'Uppsala',
                         'Göteborg' = 'Göteborg',
                         'Malmö' = 'Malmö')),
            
            actionButton("ab_1" ,"Show the plot"),
            
            plotOutput('muniplot'),
            
            checkboxGroupInput('mun2', 
                               'Choose municipalities you want to compare',
                               c('Stockholm' = 'stockholm',
                                 'Uppsala' = 'uppsala',
                                 'Göteborg' = 'göteborg',
                                 'Malmö' = 'malmö')),
            
            uiOutput("sliders"),
            
            actionButton("ab_2" ,"Show the plot"),
            
            plotOutput('compplot')
           
            
            ),
    
    # comparison
    
    
    tabPanel("Correlation",
             titlePanel("Analyse the correlations"),
             actionButton("ab_3" ,"Show the correlations"),
             
             plotOutput('corrplot'),
             tableOutput('cortab')
             ),
 
    tabPanel("Linear regression",
             titlePanel("Now it's time to create a model!!"),
             
             selectInput('mun3', 
                                'Choose what dependent variable you want to use',
                                c('Amount of residents' = 'residents',
                                  'Net migration' = 'net_migration')),
             
             checkboxGroupInput('mun4', 
                                'Choose what expenditure independent variable(s) you want to use',
                                c('Political' = 'political_spend',
                                  'Infrastructure' = 'infrastructure_spend',
                                  'Leisure' = 'leisure_spend',
                                  'Culture' = 'culture_spend',
                                  'Education' = 'education_spend',
                                  'Elder & disabled' = 'elder_disabled_spend',
                                  'Care' = 'care_spend',
                                  'Refugee' = 'refugee_spend',
                                  'Labor' = 'labor_spend')),
             actionButton("ab_4" ,"Create model"),
             
             verbatimTextOutput('summarytab'),
             
             plotOutput('distplot'),
             
             textOutput('questtab'),
             textOutput('questtab2'),
             textOutput('questtab3')
    )
  )
  
)


server <- function(input, output, session){
  # downloading the data 
  df <- data_dl()
  
  # Action button 1
  muni_plot_reactive <- eventReactive(input$ab_1, {
    muniLines(input$mun, df)
  })
  # Plotting the muniLines function
  output$muniplot <- renderPlot({
    muni_plot_reactive()
  })
  # Rendering a selectizeInput 
  output$sliders <- renderUI({
    sliders <- selectizeInput("kpi_slider", "Select KPI",choices = c(unique(df$kpi)))
    
  })
  # Action button 2
  comp_plot_reactive <- eventReactive(input$ab_2, {
    muniCompare(input$mun2, df,input$kpi_slider)
   
  })
  # Plotting the muniCompare function
  output$compplot <- renderPlot({
    comp_plot_reactive()
  })
  # Action button 3
  cor_plot_reactive <- eventReactive(input$ab_3, {
    muniCorr(df)

  })
  # Plotting the muniCorr function
  output$corrplot <- renderPlot({
    cor_plot_reactive()
  })
  # Printing a table from the muniCorr function
  output$cortab <- renderTable({
    cor_plot_reactive()
  })
  
  # Action button 4
  model_plot_reactive <- eventReactive(input$ab_4, {
     muniModel(input$mun3, input$mun4, df)
  })
  
  # Plotting distribution plot
  output$distplot <- renderPlot({
    model_plot_reactive()
    
  })
  
  # Showing summary table
  output$summarytab <- renderPrint({
    model_plot_reactive()
  })
  
  model_print1 <- eventReactive(input$ab_4, {
  # Showing summary table
    print("Is the model assumptions fulfilled?")
      })
    
    
    model_print2 <- eventReactive(input$ab_4, {
      # Showing summary table
    print('Or is there more things you should analyse?')
    })
    model_print3 <- eventReactive(input$ab_4, {
      # Showing summary table
    print('Maybe check the autocorrelations')
    })
    
  output$questtab <- renderText({
    model_print1()
  })
  output$questtab2 <- renderText({
    model_print2()
  })
  
  output$questtab3 <- renderText({
    model_print3()
  })
  

}

shinyApp(ui,server)


