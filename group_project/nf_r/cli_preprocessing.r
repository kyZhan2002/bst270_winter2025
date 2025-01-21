#!/usr/bin/env Rscript

library(dplyr)
library(tidyverse)
library(DT)

# Load necessary libraries
suppressPackageStartupMessages(library(tidyverse))

# Function to parse command-line arguments
parse_args <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  
  if (length(args) != 3) {
    stop("Usage: Rscript process_files.R <input_file1> <input_file2> <output_file>")
  }
  
  list(input_file1 = args[1], input_file2 = args[2], output_file = args[3])
}


  # Parse arguments
  args <- parse_args()
  
  load(args$input_file1)
  load(args$input_file2)
  
  # Inner join of the two tables
  merged_data = inner_join(da04652.0001, da29282.0001, by = c("M2ID", "M2FAMNUM"),suffix = c('','.2'))
  # save the intermediate table with the merged data
  #write.csv(merged_data, args$intermediate_table, row.names = FALSE)
  
  source("../filter_optimism.R")
  data_after_optimism_filtering <- Filter_optimism(merged_data)
  
  source("../filter_lipids.R")
  data_after_lipid_filtering <- Filter_lipids(merged_data)
  
  # filter pathway varibales
  source("../filter_pathway.R")
  data_after_pathway_filtering <- filter_pathway(merged_data)
  print(dim(data_after_pathway_filtering))
  
  # filter confounders
  source("../filter_confounders.R")
  data_after_confounder_filtering = Filter_confounders(merged_data)
  print(dim(data_after_confounder_filtering))
  
  full_data <- inner_join(data_after_optimism_filtering,
                          data_after_lipid_filtering, by = "M2ID") %>%
    inner_join(data_after_confounder_filtering, by = "M2ID") %>%
    inner_join(data_after_pathway_filtering, by = 'M2ID')
  
  print(dim(full_data))

  write.csv(full_data, args$output_file, row.names = FALSE)
  message("Processing complete. Results saved to: ", args$output_file)