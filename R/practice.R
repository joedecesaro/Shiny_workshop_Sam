# practice code

library(palmerpenguins)
library(tidyverse)
library(DT)

# filter for body mass
body_mass_df <- penguins %>% 
  filter(body_mass_g %in% 3000:4000) # these numbers are what will need to change with our slider


# plot ----
ggplot(data = na.omit(body_mass_df()), aes(x = flipper_length_mm,
                                     y = bill_length_mm,
                                     color = species,
                                     shape = species)) + 
  geom_point() + 
  scale_color_manual(values = c("Adelie" = "#FEA346", 
                                "Chinstrap" = "#B251F1", 
                                "Gentoo" = "#4BA4A4")) +
  scale_shape_manual(values = c("Adelie" = 19, 
                                "Chinstrap" = 17, 
                                "Gentoo" = 15)) +
  labs(x = "Flipper Length (mm)",
       y = "Bill Length (mm)",
       color = "Penguin Species",
       shape = "Penguin Species")

# table ----
DT::datatable(penguins,
                    options = list(pageLength = 5),
                    caption = tags$caption(
                      style = 'caption-side: top; text-align: left;',
                      'Table 1: ', tags$em('Size measurements for adult foraging penguins near Palmer Station, Antarctica')))
