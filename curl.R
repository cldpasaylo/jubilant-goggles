library(dplyr)

netflix <- read.csv(file.choose())

net.select <- select(
  netflix,
  type,
  title,
  country,
  release_year,
  duration,
  rating,
  listed_in
)

net.filter <- filter(
  net.select,
  country%in%c("China", 
               "Philippines", 
               "Indonesia", 
               "Japan", 
               "South Korea", 
               "Thailand", 
               "Vietnam", 
               "India", 
               "Malaysia", 
               "Singapore")
)
