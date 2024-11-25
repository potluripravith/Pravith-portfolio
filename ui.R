shinyUI(navbarPage(
    title = "Project Portfolio",
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    tabPanel(title = "Home",
             includeMarkdown("www/Home.Rmd")
             ),
    tabPanel(title = "Resume",
             includeMarkdown("www/resume.Rmd")
             ),
    navbarMenu(title = "Projects",
               tabPanel(title = "Recommendation",
                        uiOutput("Recommendation_page")),
               tabPanel(title = "Predicting car prices",
                        uiOutput("Predicting_page"))
               )
    )
)
