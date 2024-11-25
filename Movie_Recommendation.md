---
title: "Movie Recomendation"
output: 
  html_fragment:
    keep_md: false
---

# Movie Recommendation System using Content-Based Filtering[Click here for page](https://pmovierecommendation-zl45rzsllwz68tdqb6grppr.streamlit.app/)

This project is aimed at building a movie recommendation engine using a dataset of movies and their associated metadata. The core idea behind the recommendation system is content-based filtering, which suggests movies to a user based on the similarities between movies' metadata like genre, cast, crew, keywords, and overview. Below is an explanation of the various steps involved in the development of the movie recommendation engine.


###  Loading and Merging Data
Begin by loading the dataset files tmdb_5000_movies.csv and tmdb_5000_credits.csv which contain details about movies and the corresponding credits (cast and crew). These datasets are merged on the movie title to combine the necessary information into one DataFrame.

### Data Preprocessing

The columns like genres, keywords, cast, and crew contain data in list format, so  need to convert them into a more usable form.

Converting Genres and Keywords
Define a function to extract and convert the genres and keywords columns, which are in string representation of lists, into lists of strings.


``` p
def convert(obj):
    L = []
    for i in ast.literal_eval(obj):
        L.append(i['name'])
    return L
```

Process the cast and crew columns. We limit the number of actors listed to a maximum of 3 for simplicity and extract only the director's name from the crew.

``` p
def convertcast(obj):
    L = []
    count = 0
    for i in ast.literal_eval(obj):
        if count != 3:
            L.append(i['name'])
            count += 1
        else:
            break
    return L
            
def fetchdir(obj):
    L = []
    for i in ast.literal_eval(obj):
        if i['job'] == 'Director':
            L.append(i['name'])
            break
    return L
```
### Feature Engineering
Combine multiple features such as overview, genres, keywords, cast, and crew into a new tags feature. This new feature will be the primary basis for finding similarities between movies.

### Vectorization and Text Processing
Transforming the textual tags into a numerical representation that can be used for finding similarities between movies. I used the CountVectorizer from the sklearn library to convert the text into vectors.

``` p
from sklearn.feature_extraction.text import CountVectorizer

cv = CountVectorizer(max_features=5000, stop_words='english')

# Converting the tags into a vectorized form
vectors = cv.fit_transform(movies['tags']).toarray()

# Checking the number of features in the vectors
len(cv.get_feature_names_out())
```
 
### Dimensionality Reduction and Cosine Similarity
Apply stemming using the PorterStemmer to reduce the words to their base form. This helps in improving the similarity computation by standardizing words to their root forms.

``` p
from nltk.stem.porter import PorterStemmer

ps = PorterStemmer()

# Function to apply stemming
def stem(text):
    y = []
    for i in text.split():
        y.append(ps.stem(i))
    return " ".join(y)

# Applying stemming to the 'tags' column
movies['tags'] = movies['tags'].apply(stem)
```

### Deploying with Streamlit
deploy it as a web application using Streamlit. The app allows users to input a movie name and receive a list of recommended movies along with their posters.
