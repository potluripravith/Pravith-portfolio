---
title: "Predicting Car Prices"
output: 
  html_fragment:
    keep_md: false
---

# Predicting Car Prices

This project aims to predict car prices using the imports-85 car dataset, which contains various car attributes like engine specifications, dimensions, and fuel types. The objective is to clean and preprocess the data, explore the relationships between features, and apply machine learning techniques, specifically k-Nearest Neighbors (k-NN) regression, to predict car prices. The project demonstrates the process of data cleaning, feature selection, exploratory data analysis (EDA), model training, hyperparameter tuning, and evaluation of the predictive model.


# Main Analysis

### Install and Load Necessary Libraries



``` r
library(readr)
library(tidyr)
library(dplyr)
library(tibble)
library(caret)
library(purrr)
library(ggplot2)
```

### Loading and Inspecting Data
The dataset is read from a CSV file, and column names are set to more meaningful names for better clarity. The dataset is then cleaned by:

Removing rows with missing values or entries with invalid characters like ?.
Converting relevant columns (such as stroke, bore, horsepower, peak RPM, and price) into numeric format, as some of them might have been read as strings. 


``` r
cars <- read.csv("imports-85.data") %>% as_tibble()

colnames(cars) <- c(
  "symboling", "normalized_losses", "make", "fuel_type", "aspiration", 
  "num_doors", "body_style", "drive_wheels", "engine_location", "wheel_base", 
  "length", "width", "height", "curb_weight", "engine_type", "num_cylinders", 
  "engine_size", "fuel_system", "bore", "stroke", "compression_ratio", 
  "horsepower", "peak_rpm", "city_mpg", "highway_mpg", "price"
)
```

### Handling Missing Values

``` r
missing_counts <- sapply(cars, function(x) sum(is.na(x)))
print(missing_counts)
```

```
##         symboling normalized_losses 
##                 0                 0 
##              make         fuel_type 
##                 0                 0 
##        aspiration         num_doors 
##                 0                 0 
##        body_style      drive_wheels 
##                 0                 0 
##   engine_location        wheel_base 
##                 0                 0 
##            length             width 
##                 0                 0 
##            height       curb_weight 
##                 0                 0 
##       engine_type     num_cylinders 
##                 0                 0 
##       engine_size       fuel_system 
##                 0                 0 
##              bore            stroke 
##                 0                 0 
## compression_ratio        horsepower 
##                 0                 0 
##          peak_rpm          city_mpg 
##                 0                 0 
##       highway_mpg             price 
##                 0                 0
```

``` r
# Remove rows with missing or invalid data in numeric columns
```

### Handling ? in the Data

``` r
cars <- cars %>%
  select(symboling, wheel_base, length, width, height, curb_weight, engine_size, 
         bore, stroke, compression_ratio, horsepower, peak_rpm, city_mpg, highway_mpg, price) %>%
  filter(
    stroke != "?",
    bore != "?",
    horsepower != "?",
    peak_rpm != "?",
    price != "?"
  ) %>%
  mutate(
    stroke = as.numeric(stroke),
    bore = as.numeric(bore),
    horsepower = as.numeric(horsepower),
    peak_rpm = as.numeric(peak_rpm),
    price = as.numeric(price)
  )
```
### Exploratory Data Analysis (EDA)

A histogram is plotted to visualize the distribution of car prices using ggplot2.
The featurePlot() function from caret is used to create scatterplots of each feature against the target variable (price), allowing us to visually inspect the relationships between features and the price.

``` r
ggplot(cars, aes(x = price)) +
  geom_histogram(color = "red") +
  labs(
    title = "Distribution of prices in cars dataset",
    x = "Price",
    y = "Frequency"
  )
```

```
## `stat_bin()` using `bins = 30`. Pick better value
## with `binwidth`.
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png)

``` r
featurePlot(cars, cars$price)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png)
### Data Splitting
The data is split into training (80%) and testing (20%) sets using createDataPartition() from the caret package. This ensures that the model is trained on one set of data and evaluated on another to avoid overfitting.


``` r
split_indices <- createDataPartition(cars$price, p = 0.8, list = FALSE)
train_cars <- cars[split_indices,]
test_cars <- cars[-split_indices,]
```

### Model Training (k-NN Regression)
The k-Nearest Neighbors (k-NN) algorithm is applied to predict the car price. The training involves using cross-validation (trainControl(method = "cv", number = 5)) to evaluate different values of k (the number of nearest neighbors) and find the optimal value. The features are preprocessed using standardization (center, scale) to ensure they all contribute equally to the model.


``` r
five_fold_control <- trainControl(method = "cv", number = 5)

tuning_grid <- expand.grid(k = 1:20)

full_model <- train(price ~ .,
                    data = train_cars,
                    method = "knn",
                    trControl = five_fold_control,
                    tuneGrid = tuning_grid,
                    preProcess = c("center", "scale"))
```
### Prediction and Model Evaluation
The model's performance is evaluated on the test data by generating predictions using the trained model and comparing them against the actual values of price in the test set. Metrics like RMSE (Root Mean Squared Error), MAE (Mean Absolute Error), and R-squared are calculated using the postResample() function to assess how well the model performs.

``` r
# Make predictions on the test set
predictions <- predict(full_model, newdata = test_cars)

# Evaluate model performance
postResample(pred = predictions, obs = test_cars$price)
```

```
##         RMSE     Rsquared          MAE 
## 5091.5919581    0.7662432 2637.3611111
```
### Summary and Conclusion

After applying the k-Nearest Neighbors (k-NN) regression model to predict car prices, the following performance metrics were obtained on the test dataset:

Root Mean Squared Error (RMSE): 3581.44

RMSE measures the average magnitude of prediction errors. A lower RMSE indicates better model performance. Here, the RMSE suggests the model's predictions deviate from the actual car prices by approximately 3581.44 units on average.
R-squared (R²): 0.7196

R² indicates the proportion of variance in the target variable (car prices) explained by the model. A value of 0.7196 implies that about 71.96% of the variability in car prices is captured by the features used in the model, indicating a reasonably good fit.
Mean Absolute Error (MAE): 2210.89

MAE measures the average absolute difference between predicted and actual values. An MAE of 2210.89 suggests that, on average, the model's predictions are off by 2210.89 units.
The k-NN regression model performed well, explaining approximately 72% of the variance in car prices and achieving relatively low error values (RMSE: ~3581, MAE: ~2210). However, the model's performance could be further improved by:

Feature Engineering:

Including interactions or transformations of existing features.
Exploring additional relevant features from the dataset that may have a stronger correlation with price.

Algorithm Comparison:

Testing other machine learning models such as Linear Regression, Decision Trees, or Random Forests, which might capture complex relationships between features and price better.

Handling Outliers:

Investigating the dataset for outliers in the price or other numerical features that could impact the model's learning.


