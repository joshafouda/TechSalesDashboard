# server.R
server <- function(input, output, session) {
  
  filtered_tech_sales_data <- reactive({
    
    tech_sales_data %>% 
      filter(
        Store %in% input$store_filter,
        Category %in% input$category_filter
      )
  })
  
  
  output$total_sales_plot <- renderPlotly({
    
    plot_total_sales_single_column(filtered_tech_sales_data())
    
  })
  
  output$sales_by_store_plot <- renderPlotly({
    
    plot_sales_by_store_donut(filtered_tech_sales_data())
    
  })
  
  output$breakdown_region_plot <- renderPlotly({
    
    plot_sales_by_store_region(filtered_tech_sales_data(), input$region)
    
  })
  
  output$top_sales_month_plot <- renderPlotly({
    
    plot_top_sales_month(filtered_tech_sales_data())
    
  })
  
  
  output$sparklines_plot <- renderPlotly({
    
    plot_category_trends(filtered_tech_sales_data())
    
  })
  
  
  output$top_managers_plot <- renderPlotly({
    
    plot_top_managers(filtered_tech_sales_data())
    
  })
  
  
  output$sales_by_category_store_plot <- renderPlotly({
    
    plot_sales_by_category_store(filtered_tech_sales_data())
    
  })
  
}
