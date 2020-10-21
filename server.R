# 
# server <- function(input, output) {
#   output$distPlot <- renderPlot({
#     hist(rnorm(input$obs), col = 'darkgray', border = 'white')
#   })
# }

shinyServer(function(input, output, session){
  # fileUpload: A function for CSV file upload 
  fileUpload <- function(){
    return(input$file1)
  }
  # readData: A reactive function for reading csv file and returns dataframe
  readData <- reactive({
    file = fileUpload()
    req(file)
    r = read.csv(file$datapath)
    return(r)
  })
  # dataFrameInfo <- reactive({
  # })
  # output$Dataset: Helps to dispaly the dataframe on Webpage.
  output$Dataset <- DT::renderDataTable({
    myData <- DT::datatable({
      readData()
    },
    extensions = 'Scroller',
    options = list(
      scroller = TRUE,
      deferRender = TRUE,
      scrollY = 400,
      pageLength = 10,
      dom = 'tB'
    ),
    fillContainer = T,
    class = "display"
    )
  })
  output$summary <- renderPrint({
    summary(readData())
  })
  
  
})
  
  # dat <- reactive({
  #   switch(input$dataset,
  #          m = mtcars,
  #          p = pressure)
  #   
  # })
  # 
  # output$table <- renderTable({
  #   head(dat(), input$n)
  # })
  # 
  # output$summary <- renderPrint({
  #   summary(reada)
  # })