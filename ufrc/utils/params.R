
# R libraries
#------------

library(readr)
library(tidyverse)
library(stringr)

# import data
#------------

condition_occurrence <- read_tsv(file="/blue/djlemas/share/data/Benchmark/OMOP/data_release//condition_occurrence_v2.1.txt", show_col_types = FALSE)
concept <- read_tsv(file="/blue/djlemas/share/data/Benchmark/OMOP/data_release/concept_v2.0.txt", show_col_types = FALSE)
vocabulary <- read_tsv(file="/blue/djlemas/share/data/Benchmark/OMOP/data_release/vocabulary_v2.0.txt", show_col_types = FALSE)
concept_ancestor <- read_tsv(file="/blue/djlemas/share/data/Benchmark/OMOP/data_release/concept_ancestor_v2.0.txt", show_col_types = FALSE) %>% rename(concept_id=ancestor_concept_id)
concept_synonym <- read_tsv(file="/blue/djlemas/share/data/Benchmark/OMOP/data_release/concept_synonym_v2.0.txt", show_col_types = FALSE)

# notes: https://ohdsi.github.io/CommonDataModel/cdm60.html#VOCABULARY
