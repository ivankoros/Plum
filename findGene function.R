# Loading packages using pacman

if (!require("pacman"))
  install.packages("pacman")
pacman::p_load(tidyverse, openxlsx)

# The findGene function takes in a gene name as a string
# and X number of filtered expression data sets from the DESeq2 -> filter pipeline I created
# It returns the given gene's location and it's expression in the given data sets

findGene <- function(name, datasets) {
  for (x in datasets) {
    mdfeime <- read.xlsx(x)
    set <-
      mdfeime[str_detect(mdfeime$Symbol, fixed(name, ignore_case = TRUE)),]
    if (nrow(set) > 0) {
      print(paste0(
        mdfeime$Symbol[as.integer(row.names(set))],
        " is ",
        mdfeime$SaR[as.integer(row.names(set))] ,
        " (",
        round(mdfeime$Log2f[as.integer(row.names(set))], digits = 3),
        ")",
        " in ",
        gsub(" Filtered.xlsx", "", x)
      ))
    }
  }
}

# Running the findGene function

findGene(
  name = readline(prompt = "Enter name: "),
  datasets = list(
    "x.Filtered.xlsx", "x.Filtered.xlsx", "x.Filtered.xlsx"
  )
)
