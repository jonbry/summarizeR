library(shiny)

ui <- fluidPage(
  titlePanel("Data Viewer"),
  fluidRow(
    column(
      4,
      fileInput(
        inputId = "uploadFile",
        label = "Upload File",
        buttonLabel = "Upload",
        width = 300
      )
    ),
    column(
      6,
      numericInput(
        inputId = "quantile",
        label = "Quantile",
        value = 25,
        width = 100
      )
    )
  ),
  actionButton(
    inputId = "Submit",
    label = "Submit"
  )
)
server <- function(input, output) {
  observeEvent(input$submit, {
    
  })
}

shinyApp(ui = ui, server = server)
