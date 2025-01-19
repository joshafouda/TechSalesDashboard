
# Ajouter les fonctions spécifiques à l'application ici

tech_sales_data <- read_excel("data/Tech Sales Data.xlsx")

# Define the function
plot_total_sales_single_column <- function(data) {
  # Calculate total sales
  total_sales <- data %>%
    summarize(Total_Sales = sum(Sales, na.rm = TRUE)) %>%
    pull(Total_Sales)
  
  # Create the Plotly column chart
  plot <- plot_ly(
    x = "Total Sales",
    y = total_sales,
    type = "bar",
    text = ~paste0("$", format(total_sales, big.mark = " ")),
    marker = list(color = "darkorange")
  ) %>%
    layout(
      title = "Total Sales",
      xaxis = list(title = ""),
      yaxis = list(title = "Total Sales"),
      bargap = 0.2
    )
  
  return(plot)
}

# Example usage
# plot_total_sales_single_column(tech_sales_data)


# Define the function
plot_sales_by_store_donut <- function(data) {
  # Summarize sales by store
  sales_by_store <- data %>%
    group_by(Store) %>%
    summarize(Total_Sales = sum(Sales, na.rm = TRUE)) %>%
    arrange(desc(Total_Sales))
  
  # Create the Plotly donut chart
  plot <- plot_ly(
    sales_by_store,
    labels = ~Store,
    values = ~Total_Sales,
    type = "pie",
    hole = 0.5
  ) %>%
    layout(
      title = "Sales by Store",
      showlegend = TRUE,
      annotations = list(
        list(
          text = "",
          font = list(size = 20),
          showarrow = FALSE,
          x = 0.5,
          y = 0.5
        )
      )
    )
  
  return(plot)
}

# Example usage
# plot_sales_by_store_donut(tech_sales_data)



# Define the function
plot_sales_by_store_region <- function(data, region) {
  # Filter the data for the specified region and aggregate sales by store
  region_data <- data %>%
    filter(Region == region) %>%
    group_by(Store) %>%
    summarise(Total_Sales = sum(Sales, na.rm = TRUE)) %>%
    arrange(desc(Total_Sales))
  
  # Create the stacked column chart
  fig <- plot_ly(
    region_data,
    x = ~"Total Sales",
    y = ~Total_Sales,
    type = 'bar',
    name = ~Store,
    text = ~paste0("$", format(Total_Sales, big.mark = " ")),
    textposition = "inside",
    marker = list(colors = c("rgb(55, 83, 109)", "rgb(255, 127, 14)", "rgb(26, 118, 255)"))
  )
  
  # Customize the layout
  fig <- fig %>% layout(
    #title = paste("Total Sales by Store in", region),
    title = "",
    xaxis = list(title = ""),
    yaxis = list(title = "Total Sales"),
    barmode = 'stack',
    showlegend = FALSE
  )
  
  # Return the chart
  fig
}

# Example usage
# plot_sales_by_store_region(tech_sales_data, "England")



# Define the function
plot_top_sales_month <- function(data) {
  # Aggregate sales by month
  monthly_sales <- data %>%
    mutate(Month = as.Date(format(Month, "%Y-%m-01"))) %>% # Ensure Month is standardized to the first day of each month
    group_by(Month) %>%
    summarise(Total_Sales = sum(Sales, na.rm = TRUE)) %>%
    arrange(desc(Total_Sales))
  
  # Identify the top sales month
  top_month <- monthly_sales %>%
    slice_max(Total_Sales, n = 1)
  
  # Create the column chart
  fig <- plot_ly(
    top_month,
    x = ~format(Month, "%B %Y"), # Format the month for display
    y = ~Total_Sales,
    type = 'bar',
    text = ~paste0("$", format(Total_Sales, big.mark = " ")),
    textposition = "inside",
    marker = list(color = "rgb(55, 83, 109)")
  )
  
  # Customize the layout
  fig <- fig %>% layout(
    title = "Top Sales Month",
    xaxis = list(title = "Month"),
    yaxis = list(title = "Total Sales"),
    showlegend = FALSE
  )
  
  # Return the chart
  fig
}

# Example usage
# plot_top_sales_month(tech_sales_data)



# Define the function
plot_category_trends <- function(data) {
  # Add "All Regions" as a combined region
  all_regions_data <- data %>%
    group_by(Category, Month) %>%
    summarise(Total_Sales = sum(Sales, na.rm = TRUE), .groups = "drop") %>%
    mutate(Region = "All Regions")
  
  # Combine with the original data
  combined_data <- data %>%
    mutate(Month = as.Date(format(Month, "%Y-%m-01"))) %>% # Standardize Month
    bind_rows(all_regions_data)
  
  # Aggregate sales by Region, Category, and Month
  trend_data <- combined_data %>%
    group_by(Region, Category, Month) %>%
    summarise(Total_Sales = sum(Sales, na.rm = TRUE), .groups = "drop")
  
  # Create the ggplot object
  gg <- ggplot(trend_data, aes(x = Month, y = Total_Sales, group = Category)) +
    geom_line(aes(color = Region, linewidth = 0.6)) + # Replace `size` with `linewidth`
    geom_point(size = 1) +
    facet_grid(Category ~ Region, scales = "free_y") +
    scale_color_manual(values = c(
      "All Regions" = "black",
      "England" = "blue",
      "Scotland" = "brown",
      "NI" = "gold",
      "Wales" = "green"
    )) +
    labs(
      title = "Category Sales Trends Across Regions",
      x = "Month",
      y = "Total Sales"
    ) +
    theme_void() +
    theme(legend.position = "none") 
  
  # Convert ggplot object to an interactive plotly object
  ggplotly(gg)
}

# Example usage
# plot_category_trends(tech_sales_data)


# Define the function
plot_top_managers <- function(data) {
  # Aggregate sales by manager
  top_managers <- data %>%
    group_by(Manager) %>%
    summarise(Total_Sales = sum(Sales, na.rm = TRUE), .groups = "drop") %>%
    arrange(desc(Total_Sales)) %>%
    slice_head(n = 5) # Select top 5 managers
  
  # Create the Plotly bar chart
  fig <- plot_ly(
    top_managers,
    x = ~reorder(Manager, Total_Sales), # Reorder managers by sales
    y = ~Total_Sales,
    type = "bar",
    text = ~paste0("$", format(Total_Sales, big.mark = " ")), # Add formatted sales as text
    textposition = "auto",
    marker = list(color = "rgb(55, 83, 109)")
  )
  
  # Customize layout
  fig <- fig %>% layout(
    title = "Top 5 Managers by Sales",
    xaxis = list(title = "Manager", tickangle = -45), # Rotate manager names
    yaxis = list(title = "Total Sales"),
    showlegend = FALSE
  )
  
  return(fig)
}

# Example usage
# plot_top_managers(tech_sales_data)



# Define the function
plot_sales_by_category_store <- function(data) {
  # Aggregate sales by Category and Store
  sales_data <- data %>%
    group_by(Category, Store) %>%
    summarise(Total_Sales = sum(Sales, na.rm = TRUE), .groups = "drop")
  
  # Create the ggplot object
  gg <- ggplot(sales_data, aes(x = Total_Sales, y = reorder(Category, Total_Sales), fill = Store)) +
    geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
    scale_x_continuous(labels = scales::label_number(scale_cut = scales::cut_short_scale(), big.mark = " ")) +
    scale_fill_manual(values = c("blue", "orange")) + # Customize store colors
    labs(
      title = "Sales by Category and Store",
      x = "$",
      y = "Category",
      fill = "Store"
    ) +
    theme_minimal() +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.major.x = element_line(color = "gray80"),
      plot.title = element_text(face = "bold", size = 16, hjust = 0.5, color = "white"),
      plot.background = element_rect(fill = "#333333"),
      panel.background = element_rect(fill = "#333333"),
      axis.title = element_text(color = "white"),
      axis.text = element_text(color = "white"),
      legend.text = element_text(color = "white"),
      legend.title = element_text(color = "white"),
      legend.position = "bottom"
    )
  
  # Convert ggplot object to Plotly
  ggplotly(gg) %>%
    layout(
      title = list(
        text = "SALES BY CATEGORY AND STORE",
        font = list(size = 16, color = "white"),
        x = 0.5
      ),
      plot_bgcolor = "#333333",
      paper_bgcolor = "#333333",
      xaxis = list(title = "Sales ($)", tickformat = ","),
      yaxis = list(title = "")
    )
}

# Example usage
# plot_sales_by_category_store(tech_sales_data)