tab1 <- function() {
  
  
  
  
  # Begin: quick load of file
  tabPanel(
    h4("Instructions"), 
    sidebarPanel(

    ),
    mainPanel(p("This applications imports excel files into the database."),
              p("In order to use this app, you have to save an R file (credentials.R)
                in the folder src with a script connecting to the file")
              
              )
  )
  # End: quick load of file
}