if (!require("pacman"))
  install.packages("pacman")
pacman::p_load(tidyverse, openxlsx)

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

findGene(
  name = readline(prompt = "Enter name: "),
  datasets = list(
    "x.Filtered.xlsx", "x.Filtered.xlsx", "x.Filtered.xlsx"
  )
)
