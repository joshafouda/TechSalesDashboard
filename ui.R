# ui.R
header <- dashboardHeader(
  title = "Tech Sales",
  tags$li(
    class = "dropdown",
    tags$a(
      href = "https://www.linkedin.com/in/josu%C3%A9-afouda",
      "Author: Josué AFOUDA",
      target = "_blank",
      style = "color: yellow;" 
    )
  )
)

sidebar <- dashboardSidebar(disable = TRUE)

body <- dashboardBody(
  
  # The UI code
  fluidRow(
    column(width = 4,
           checkboxGroupButtons("store_filter", "Store Filters:", 
                                choices = unique(tech_sales_data$Store), 
                                selected = unique(tech_sales_data$Store), 
                                individual = TRUE, justified = TRUE)
           
    ),
    column(width = 8,
           checkboxGroupButtons("category_filter", "Category Filters:", 
                                choices = unique(tech_sales_data$Category), 
                                selected = unique(tech_sales_data$Category), 
                                individual = TRUE, justified = TRUE)
    )
  ),
  
  fluidRow(
    box(plotlyOutput("total_sales_plot", height = "300px"), 
        width = 3, title = "Total Sales", 
        status = "primary", solidHeader = TRUE),
    box(plotlyOutput("sales_by_store_plot", height = "300px"), 
        width = 3, title = "Sales by Store", 
        status = "primary", solidHeader = TRUE),
    box(selectInput("region", "Region", choices = unique(tech_sales_data$Region)), 
        plotlyOutput("breakdown_region_plot", height = "225px"), 
        width = 3, title = "Sales by Store (Region)", 
        status = "primary", solidHeader = TRUE),
    box(plotlyOutput("top_sales_month_plot", height = "300px"), 
        width = 3, title = "Top Sales Month", 
        status = "primary", solidHeader = TRUE)
  ),
  
  fluidRow(
    box(plotlyOutput("sparklines_plot"), 
        width = 6, title = "Sales Trend by Category and Region", 
        status = "primary", solidHeader = TRUE),
    box(plotlyOutput("top_managers_plot"), 
        width = 6, title = "Top 5 Managers by Sales", 
        status = "primary", solidHeader = TRUE)
  ),
  
  fluidRow(
    box(plotlyOutput("sales_by_category_store_plot"), 
        width = 12, title = "Sales by Category and Store", 
        status = "primary", solidHeader = TRUE)
  )
  
)

# UI definition
ui <- dashboardPage(header, sidebar, body)
