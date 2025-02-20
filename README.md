# Portfolio Project: R Shiny App

This dynamic portfolio is built using **R** and **Shiny** to showcase various data science projects. The app presents a detailed view of my skills in **R programming**, along with interactive features and project insights.

## Features

### Home
An introductory page featuring details about myself and my contact information.

### Resume
A markdown-based presentation of my professional resume, highlighting education, skills, and achievements.

### Projects
1. **Movie Recommendation**  
   A machine learning-powered movie recommendation system that suggests movies based on user preferences.

2. **Predicting Car Prices**  
   A car price prediction model using the **imports-85 dataset**. The model leverages machine learning techniques like k-Nearest Neighbors (k-NN) regression, Random Forest, etc.To predict car prices based on various car attributes.

## Technology Stack

- **R Shiny**: For creating the interactive web app.
- **HTML & CSS**: For styling the web pages.
- **knitr & markdown**: For converting R Markdown files into HTML for integration within the Shiny app.

### How to Run the Application
Clone this repository to your local machine.
Install the required R libraries:
- shiny
= tidyverse
- caret
- glmnet
- rpart
- randomForest
- knitr
- markdown
You can install them using the following command:
install.packages(c("shiny", "tidyverse", "caret", "glmnet", "rpart", "randomForest", "knitr", "markdown"))
Open the app.R file and run it in your R environment.
shiny::runApp("path_to_app_directory")

### File Structure
- `app.R`                 # The main R script that runs the Shiny app
- `/www/`                  # Directory containing additional markdown files for different sections
  - `/Home.Rmd`            # The markdown file for the home page
  - `/resume.Rmd`          # The markdown file for the resume page
  - `/Movie_Recommendation.Rmd`  # The markdown file for the Movie Recommendation project
  - `/Predicting_Car_Prices.Rmd` # The markdown file for the Car Price Prediction project
- `/styles.css`            # The CSS file used to style the app



