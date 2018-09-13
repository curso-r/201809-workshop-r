library(tidyverse)
library(readxl)

arquivos <- list.files(path = "data-raw", full.names = TRUE)
arquivos <- arquivos[stringr::str_detect(arquivos, "CO")]

df <- map_dfr(arquivos, read_excel)
