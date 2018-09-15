library(tidyverse)
library(readxl)

arquivos <- list.files(path = "data-raw", pattern = "CO", full.names = TRUE)

df <- map_dfr(arquivos, read_excel)
