library(shiny)
library(tidyverse)

# Convenience function for taking a file path for an Rmd and converting the page into 
# HTML that can be displayed on the Shiny app
rmd2UI <- function(file_path) {
  
  knit_file <- knitr::knit(input = file_path, quiet = TRUE)
  rendered_rmd <- HTML(markdown::markdownToHTML(knit_file, fragment.only = TRUE))

  return(rendered_rmd)
}

