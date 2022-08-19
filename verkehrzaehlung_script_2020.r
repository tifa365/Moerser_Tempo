# Add necessary packages
library(ggplot2)
library(scales)
library(grid)
library(RColorBrewer)
library(stringr)
library(dplyr)
require(purrr)  # for map(), reduce()

# Collect all street_data files inside folder to import dataframes
raw_files_list <- list.files('data/verkehrszaehlung_2020')

# Add the full path of files to list
pastedata <- function(.x) {
  return(paste0("./data/verkehrszaehlung_2020/", .x))
}

# Add full path to list for following mass import
raw_file_paths <- map(raw_files_list, pastedata)

# Ascribe street names to the returned dataframes
prepare_street_data_for_viz <- function(dataset_path) {
  df_name <- strsplit(strsplit(dataset_path,"_")[[1]][1], "/")[[1]][3]
  # read in dataframe
  df <-  read_delim(dataset_path, col_names = FALSE, delim = ";", col_types = cols(.default = "i", X1 = "c", X5 = 'c'))
  colnames(df) = c("date","place","tempo","length","direction")
  df$tempoclass <- cut(df$tempo, breaks = c(0,30,36,Inf), labels=c("<30 km/h", "30–36 km/h", ">36 km/h"))
  df$vehicleclass <-cut(df$length, breaks = c(0,8,12, Inf), labels=c("PKW", "LKW", "Lastzug"))
  df$datetime <- as.POSIXct(df$date,format="%d.%m.%y %H:%M:%S")
  return(as.data.frame(df))
}

# Create a list of returned dataframe
lst_of_street_dataframes <- map(raw_file_paths, prepare_street_data_for_viz)

# Get name of df
receive_title_of_dataframe <- function(.x) {
  name <- strsplit(strsplit(.x, "_")[[1]][1], "/")[[1]][3]
  return(name)
}

# Create list of dataframe names
raw_name_list <- map(raw_file_paths, receive_title_of_dataframe)

# Name all dataframes from the extracted file list
names(lst_of_street_dataframes) = raw_name_list

# Plot individual street
plot_street <- function(dataframe_street) { 
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
    scale_x_datetime(labels = date_format("%d.%m %H:%M"))
}

# Create a list of all plots to save
all_plots <- map(lst_of_street_dataframes, ~ plot_street(.x))

# Function to add different titles to plot
add_titles_to_plot <-function(plot, title_as_string) {
  plot +
    labs(title=paste("Geschwindigkeitsmessung im/in der", title_as_string), x="Zeit", y="Geschwindigkeit", size="Fahrzeugart")
}

# Manually add titles to plots (not ideal)
ackerstrasse <- add_titles_to_plot(all_plots[[1]], "Ackerstrasse")
aubruchsweg <- add_titles_to_plot(all_plots[[2]], "Aubruchsweg")
boschheideweg <- add_titles_to_plot(all_plots[[3]], "Boschheideweg")
endstrasse <- add_titles_to_plot(all_plots[[4]], "Endstrasse")
eupener_strasse <- add_titles_to_plot(all_plots[[5]], "Eupener Strasse")
friedensstrasse <- add_titles_to_plot(all_plots[[6]], "Friedensstrasse")
kirchweg <- add_titles_to_plot(all_plots[[7]], "Kirchweg")
kirschenallee <- add_titles_to_plot(all_plots[[8]], "Kirschenallee")
landwehrstrasse <- add_titles_to_plot(all_plots[[9]], "Landwehrstrasse")
pattbergstrasse <- add_titles_to_plot(all_plots[[10]], "pattbergstrasse")
roemerstrasse <- add_titles_to_plot(all_plots[[11]], "Römerstrasse")
ruhrstrasse <- add_titles_to_plot(all_plots[[12]], "Ruhrstrasse")
taubenstrasse <- add_titles_to_plot(all_plots[[13]], "Taubenstrasse")
vinner_strasse <- add_titles_to_plot(all_plots[[14]], "Vinner Strasse")


# Create named list of plots to save plots all at once
plot_list <- list(Ackerstrasse = ackerstrasse, Aubruchsweg = aubruchsweg, Endstrasse = endstrasse, Eupenerstrassee = eupener_strasse,
                  Friedensstrasse = friedensstrasse, Kirchweg = kirchweg, Kirschenallee =kirschenallee, Landwehrstrasse = landwehrstrasse,
                  Roemerstrasse = roemerstrasse, Ruhrstrasse= ruhrstrasse, Taubenstrasse = taubenstrasse, Vinner_strasse = vinner_strasse)

# Save each plot in the list by name
iwalk(plot_list, ~ ggsave(glue::glue("{.y}.png"), .x, device = "png",  width=8, height=4, dpi=300, path = "./images/2020"))

##############################Other_Approach###############################

# # All single dataframes are combined into one, easier to save and create facet
# combined_street_dataframe <- dplyr::bind_rows(lst_of_street_dataframes, .id = "keys") |> 
#   # Capitalize street names
#   mutate(keys = str_to_title(keys, locale = "de")) |> 
#   # Change second part of lost street name
#   mutate(keys = replace(keys, keys == 'Eupener', 'Eupener Strasse'))# ("Eupepener", "Eupener Strasse", keys))
# 
# # Make streets uppercase
# combined_street_dataframe <- combined_street_dataframe |> 
#   mutate(keys, funs=toupper)
