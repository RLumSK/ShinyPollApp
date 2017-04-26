## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Title:   IRAMAT-CRP2A Survey - Logicel
## Author:  Sebastian Kreutzer, IRAMAT-CRP2A, Universite Bordeaux Montaigne (France)
## Contact: sebastian.kreutzer@u-bordeaux-montaigne.fr
## Date:    Sat Jan 14 20:52:25 2017
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function(input, output, session) {

  # Database ------------------------------------------------------------------------------------
  ##load database information from external file

    ##we do not upload the database information to GitHub, so check wheter
    ##the file exits
    stopifnot(file.exists("db_access.yml"))

    ##load database information
    db_access <- yaml.load_file("db_access.yml")

  ##open data base connection
  #establish data base connection for to record and read the data
  con <<- try(mongo(
    collection = db_access$collection,
    db = db_access$database,
    url = db_access$url
  ))

  if (!inherits(con, "try-error")) {

    ##make sure the connection is dropped after the user dropped the connection
    session$onSessionEnded(
      function(){
        if(exists("con")) rm(con)

      })

    # Database - INPUT -----------------------------------------------------------------------------
    ##submit data to database if submit button is pressed
    observeEvent(input$submit, {
      ##insert data
      ##insert data
      con$insert(
        data = data.frame(
          SCIENTIFIC_FIELD = input$selection,
          MISSING_FEATURE = input$text_missing,
          MAIL = input$text_mail,
          CONTRIBUTE = input$radio
        )
      )

      ##upate table if something has been submittd
      output$table <- DT::renderDataTable(DT::datatable({
        data <- con$find()[, c("SCIENTIFIC_FIELD", "MISSING_FEATURE")][!duplicated(con$find()[, c("MISSING_FEATURE")], fromLast = TRUE),]
        data
      }))


      ##udpate wordcloud if necessary
      output$plot <- renderPlot({
        make_wordcloud()
      })

    })


    # Database - READ -----------------------------------------------------------------------------

    ##WORDCLOUD
    # Make the wordcloud drawing predictable during a session
    output$plot <- renderPlot({
      make_wordcloud()
    })


    ##TABLE below ... initial
    output$table <- DT::renderDataTable(DT::datatable({
      data <- con$find()[, c("SCIENTIFIC_FIELD", "MISSING_FEATURE")][!duplicated(con$find()[, c("MISSING_FEATURE")], fromLast = TRUE),]
      data
    }))

  }


}
