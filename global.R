library(wordcloud)
library(tm)
library(shiny)
library(ggplot2)
library(mongolite)
library(yaml)

# Set scientific field list -------------------------------------------------------------------

# The list of scientific fields
fields <<- list(
    "Climate Research",
    "Ecology",
    "Hydrology",
    "Geomorphology",
    "Geochronology",
    "Solid Earth",
    "Sedimentology",
    "Marine Research",
    "Natural Hazards",
    "GIS",
    "Geostatistics"
    )



# Helper functions ------------------------------------------------------------------------------

##make wordcloud
make_wordcloud <<- function() {

  ##load strings
  words <- con$find()[["MISSING_FEATURE"]][!duplicated(con$find()[, c("MISSING_FEATURE")], fromLast = TRUE)]

  ##remove particular strings
  #words <- words[!grepl(pattern = "Je n'utilise pas de logiciel", words)]
  #words <- words[!grepl(pattern = "... (autre)", words)]

  ##remove stopwords
  words <- removeWords(words, c(stopwords("english"), "a", "longtemps", "fichiers", "irrécupérables", "sinon"))

  wordcloud(
  words = words,
  colors=brewer.pal(6,"Dark2"),
  min.freq = 1)

}
