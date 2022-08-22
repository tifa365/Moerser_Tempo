# Add necessary packages
library(ckanr)
library(ggplot2)
library(scales)
library(grid)
library(RColorBrewer)
library(stringr)
library(dplyr)
library(tidyverse)
require(purrr)

# Collect all street_data files inside folder to import dataframes
raw_files_list <- list.files('data/verkehrszaehlung_2021')

# Add the full path of files to list
pastedata <- function(.x) {
  return(paste0("./data/verkehrszaehlung_2021/", .x))
}

# Add full path to list for following mass import
raw_file_paths <- map(raw_files_list, pastedata)



# Ascribe street names to the returned dataframes
prepare_street_data_for_viz <- function(dataset_path) {
  # read in dataframe
  df <-  read_delim(dataset_path, col_names = FALSE, delim = ";", col_types = cols(.default = "i", X1 = "c", X5 = 'c'))
  colnames(df) <- c("date", "place", "tempo", "length", "direction")
  df$tempoclass <- cut(df$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
  df$vehicleclass <-cut(df$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
  df$datetime <- as.POSIXct(df$date,format="%d.%m.%y %H:%M:%S")
  return(as.data.frame(df))
}

# Create a list of returned dataframe
lst_of_places_dataframes <- map(raw_file_paths, prepare_street_data_for_viz)

# Get street name of df
receive_title_of_dataframe <- function(.x) {
  name <-strsplit(strsplit(.x, "/")[[1]][4], "-")[[1]][1]
  return(name)
}

# Create list of dataframe street names
raw_name_list <- map(raw_file_paths, receive_title_of_dataframe)

# Create new list for merged df
lst_of_street_dataframes <- list()
i <- 0

# Add or merge data
for (place in raw_name_list) {
  i <- i+1

  if(raw_name_list[[i]] %in% names(lst_of_street_dataframes)) {
    lst_of_street_dataframes[[raw_name_list[[i]]]] <- vctrs::vec_c(lst_of_street_dataframes[[raw_name_list[[i]]]], lst_of_places_dataframes[[i]])
  } else {
    lst_of_street_dataframes[[raw_name_list[[i]]]] <- lst_of_places_dataframes[[i]]
  }
}

# Create better readable street name
readable_street <- function (name) {
  removed_dashes <- gsub("[_]", " ", name)
  upper_first_name <- paste0(toupper(substr(removed_dashes, 1, 1)), substr(removed_dashes, 2, nchar(removed_dashes)))
  ss_to_sz <- gsub("trasse", "traße", upper_first_name)
  street_upper <- gsub(" straße", " Straße", ss_to_sz)
  return(
    paste("Geschwindigkeitsmessung im/in der", street_upper)
  )
}

# Plot individual street
plot_street <- function(dataframe_street, label) {
  ggplot(dataframe_street, aes(x=datetime, y=tempo, colour = tempoclass)) +
    #Punkte sind semitransparent, Größe abhängig von der Fahrzeugklasse
    geom_point(alpha=0.2, aes(size=vehicleclass)) +
    # Farbenblindenfreundliche Palette, siehe http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/#a-colorblind-friendly-palette
    scale_color_manual(values= c("#009E73", "#E69F00", "#D55E00"), name="Geschwindigkeit") +
    # Hilfslinie bei 30 km/h
    geom_hline(yintercept=30, size=0.4, color="#efefef") +
    # Hilfslinie auf dem Nullpunkt der Y-Achse
    geom_hline(yintercept=0, size=0.1, color="black") +
    # Trendlinie mit Generalized Additive Model, siehe http://minimaxir.com/2015/02/ggplot-tutorial/
    geom_smooth(alpha=0.25, color="black", fill="black") +
    guides(colour = guide_legend(override.aes = list(size=5 ,alpha=1))) +
    scale_x_datetime(labels = date_format("%d.%m %H:%M")) +
    labs(title=readable_street(label), x="Zeit", y="Geschwindigkeit", size="Fahrzeugart")
}

# Create a list of all plots to save
plot_list <- imap(lst_of_street_dataframes, ~ plot_street(.x, .y))

# Save each plot in the list by name
iwalk(plot_list, ~ ggsave(glue::glue("{.y}.png"), .x, device = "png",  width=8, height=4, dpi=300, path = "./images/2021"))