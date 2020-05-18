tab2 <- function() {
  
  
  
  
  # Begin: quick load of file
  tabPanel(
    h4("Import file"), 
    sidebarPanel(
     
      
      # 1. Select file
      fileInput("load_file", "Choose File",
                multiple = FALSE,
                accept = c(
                  "text/xlx",
                  "text/comma-separated-values,text/plain",
                  ".xlsx", 
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv"
                )
      ),
      actionButton(inputId = "choose_file", label = "Select  file"),
      br(),
      # 2. Select what sheet, rows, column and specify if the table has header
      conditionalPanel(
        condition = "input.choose_file>=1",
        uiOutput("sheet_name"),
#        textOutput("check_data"),
        checkboxInput(inputId="header", label="Header", value = T, width = NULL),
        numericInput(inputId = "startRow",label="Start Row",value=1, step=1, min=1),
        actionButton(inputId = "review_file", label = "Show file (100 rows)"),
      ),
      conditionalPanel(
        condition = "input.review_file>=1",
        uiOutput("columns"),
        fileInput(inputId = "Procedurescript", label = "Procedure script"),
        fileInput(inputId = "InsertInput", label = "Insert values script"),
        actionButton(inputId = "commit", label = "Submit")
      )
    ),
    mainPanel(DT::dataTableOutput("excel_file"))
  )
  # End: quick load of file
}