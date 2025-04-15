




# Setup -------------------------------------------------------------------

#Load Required Packages
source('packagemanager.R')

source('functions.R')

#Load Processed Datasets

demig <- readRDS(here("data", "processed", "demig_data.rds"))

impic <- readRDS(here("data", "processed", "impic_data.rds"))

destatis_visa <- readRDS(here("data", "processed", "destatis_visa.rds"))

destatis_entryandexit <- readRDS(here("data", "processed", "destatis_enterandexit.rds"))

oecd_emigration <- readRDS(here("data", "processed", "oecd_emigration.rds"))

eumagine <- readRDS(here("data", "processed", "eumagine.rds"))

eurostat <- readRDS(here("data", "processed", "eurostat.rds"))

turkstat_migration <- readRDS(here("data", "processed", "turkstat_migration.rds"))

turkstat_migration_prov <- readRDS(here("data", "processed", "turkstat_migration_by_providence.rds"))

turkstat_migration_cit_and_prov <- readRDS(here("data", "processed", "turkstat_migration_cit_and_prov.rds"))

turkstat_migration_prov_and_reason <- readRDS(here("data", "processed", "turkstat_migration_prov_and_reason.rds"))

turkstat_pop_age_prov_sex <- readRDS(here("data", "processed", "turkstat_pop_age_prov_sex.rds"))

transmit <- readRDS(here("data", "processed", "Tur_complete.RDS"))

meta <- readRDS(here("data", "processed", "turkey_germany_connections.rds"))


