
library(tidyverse)  #Load library tidyverse
library(sf) ##load library sf
library(plotly) ## load library plotly

states <- read_sf("/data") %>%  ## create variable states and assign data to it
  st_zm() %>%
  mutate(sales= (per_state / (1000*1000)) %>% round(2))

  g <- ggplot(states) +   ## plot the regional sales parameters
  geom_sf(aes(fill=sales_per_zone)) +
  scale_fill_distiller("sales amount", palette="Spectral") +
  ggtitle("Sales by state")
ggplotly(g)


