



# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  options(shiny.maxRequestSize=900*1024^2)
  
  
     # Show possible excel sheets
    output$sheet_name <- renderUI({
      infile <<- input$load_file
      if(!is.null(infile$name)){
      if(str_sub(infile$name,-4,-1)=='xlsx'){      selectInput("file_type", "Select sheet:",
                  choices = getSheetNames(infile$datapath))
      }}else{
        p("")
      }
          })
    


  # #############################################3
  # BeginQuick load of file
  # Begin: Test load excel
  observeEvent(input$review_file, {

    if (!is.null(infile)) {
      file_input <<- input$file_type
      header<-input$header
      startRow<-input$startRow      
      if(str_sub(infile$name,-4,-1)=='xlsx'){
      data.input <- read.xlsx(infile$datapath,
                              sheet = input$file_type,
                              detectDates = T, colNames=header,startRow=startRow-1)
      
      }else{
        data.input <-read.csv(infile$datapath,sep=",", 
                              header=header,
                              skip=startRow-1,
                              encoding='UTF-8')
      }
      data.input<<-data.input %>%
        mutate_all(as.character)
    }
    
    output$columns<-renderUI({
      if(is.null(input$columns)){
        selected<-names(data.input)
      }else{
          selected<-input$columns
        }
        
      selectInput(inputId ="columns", label='Select columns (Default all)',
                  choices = selected,
                  selected=selected,
                  multiple=T )
     
    })

    output$excel_file <- renderDataTable({
      data.input%>%head(100)
    })
    
    
    
    observeEvent(input$commit, {
      load_procedure1 <- input$Procedurescript
      load_procedure2 <- input$InsertInput
      
      
      
      
      if(!is.null(load_procedure1)){
        sql_procedure1 <- read_file(load_procedure1$datapath)
        dbSendQuery(
          dbc_dmp,
          sql_procedure1
        )
      }
      
      if(!is.null(load_procedure2)){
        sql_procedure2 <- read_file(load_procedure2$datapath)
        
        dbSendQuery(
          dbc_dmp,
          sql_procedure2,
          data.frame(data.input)
        )
      } 
      
      
      
      
      dbCommit(dbc_dmp)
      
      
      
      
    })
  })
  
})