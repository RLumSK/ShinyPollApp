## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Title:   IRAMAT-CRP2A Survey - Logicel
## Author:  Sebastian Kreutzer, IRAMAT-CRP2A, Universite Bordeaux Montaigne (France)
## Contact: sebastian.kreutzer@u-bordeaux-montaigne.fr
## Date:    Sat Jan 14 20:52:42 2017
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

fluidPage(
  # Application title
  titlePanel("Which functionality do you miss in R?"),

  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Select your main scientific field",
                  choices = c(fields[order(unlist(fields))],"Others")),

      br(),
      textInput("text_missing", label = "Missing feature/tool in R ...", value = ""),
      hr(),
      fluidRow(align = "center",
               radioButtons("radio", label = "Do you want to join the network?",
                            choices = list("Sure, my experience is with you" = 1, "Hell, no!" = 2),
                            selected = 1,
                            inline = TRUE
               ),

        textInput("text_mail", label = "Your e-mail address (optional)", value = ""),
        br(),
        actionButton(
          inputId =  "submit",
          label = "Well, let's go!",
          icon = icon("send", lib = "glyphicon")
        ),
        br(),
        br()
      )


    ),

    # Show wordcloud
    mainPanel(
      plotOutput("plot")
    )
  ),
  hr(),
  # Create a new row for the table.
  fluidRow(
    column(10,
     h3("Let's see what the others wrote ..."),
     br(),
     DT::dataTableOutput("table", )
    )
  ),
  hr(),
  p("Usage of this application without any warranty. The application will be offline roughly one week
    after the conference.", align = "center"),
  br(),
  p("(Sebastian Kreutzer & Michael Dietze, 2017 developed for the EGU 2017 in Vienna)", align = "center")
)
