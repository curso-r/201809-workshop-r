library(tidyverse)
library(readxl)

arquivos_CO <- list.files(path = "data-raw", pattern = "CO", full.names = TRUE)
arquivos_NO <- list.files(path = "data-raw", pattern = "NO", full.names = TRUE)


df_CO <- map_dfr(arquivos_CO, read_excel)
df_NO <- map_dfr(arquivos_NO, read_excel)

df_CO <- df_CO %>%
  rename(mass_co = mass_conc) %>%
  select(-parameter)

df_NO <- df_NO %>%
  rename(mass_no = mass_conc) %>%
  select(mass_no, time)

df <- inner_join(df_CO, df_NO, by = "time")

ggplot(df) +
  geom_point(aes(x = mass_co, y = mass_no))

df %>% 
  gather(poluente, conc, mass_no, mass_co) %>% 
ggplot() +
  geom_line(aes(x = time, y = conc)) +
  facet_wrap(~poluente, scales = "free_y")

df %>% 
  gather(poluente, conc, mass_no, mass_co) %>% 
  group_by(poluente, hour) %>% 
  summarise(conc = mean(conc, na.rm = TRUE)) %>%
  ggplot() +
  geom_line(aes(x = hour, y = conc)) +
  facet_wrap(~poluente, scales = "free_y") +
  scale_x_continuous(breaks = seq(0, 24, 4))
  