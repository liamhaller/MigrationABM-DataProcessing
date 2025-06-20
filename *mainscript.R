




# Setup -------------------------------------------------------------------

#Load Required Packages
source('packagemanager.R')

source('functions.R')

#Load Processed Datasets

demig <- readRDS(here("data", "processed", "demig_data.rds"))

impic <- readRDS(here("data", "processed", "impic_data.rds"))

destatis_all_permits <- readRDS(here("data", "processed", "all_permits_destatis.rds"))

destatis_some_permits <- readRDS(here("data", "processed", "some_permits_destatis.rds"))

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

lits <-readRDS(here("data", "processed", "lits.rds"))

wgi <- readRDS(here("data", "processed", "wgi.rds"))

turkstat_econ_cpi <-readRDS(here("data", "processed", "turkstat_econ_cpi.rds"))

turkstat_econ_unep <-readRDS(here("data", "processed", "turkstat_econ_unemployment.rds"))

turkstat_pop_age_gender <-readRDS(here("data", "processed", "turkstat_pop_age_gender.rds"))

turkstat_pop_edu <-readRDS(here("data", "processed", "turkstat_pop_edu.rds"))


