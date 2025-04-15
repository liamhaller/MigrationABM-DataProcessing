
#Emigration and Emigration from Turkey by citizenship

#Location of visa data
turkstat_migration_path <- here("data", "raw", "tkst_01_citizenship_CLEANED.xls")

turkstat_migration <- read_xls(turkstat_migration_path)

saveRDS(turkstat_migration, here('data', 'processed', 'turkstat_migration.rds'))




# -------------------------------------------------------------------------

#Emigration and Immigration by sex and Providences
#Location of visa data
turkstat_migration_by_providence_path <- here("data", "raw", "tkst_02_provinces_CLEANED.xls")

turkstat_migration_by_providence <- read_xls(turkstat_migration_by_providence_path)

saveRDS(turkstat_migration_by_providence, here('data', 'processed', 'turkstat_migration_by_providence.rds'))



# Citizenship and Providence ----------------------------------------------

turkstat_migration_cit_and_prov_path <- here("data", "raw", "tkst_03_citandprov_CLEANED.xls")

turkstat_migration_cit_and_prov <- read_xls(turkstat_migration_cit_and_prov_path)

saveRDS(turkstat_migration_cit_and_prov, here('data', 'processed', 'turkstat_migration_cit_and_prov.rds'))



# Provincial out migration by reason --------------------------------------


turkstat_migration_prov_and_reason_path <- here("data", "raw", "tkst_04_provincialoutreason_CLEAN.xls")

turkstat_migration_prov_and_reason <- read_xls(turkstat_migration_prov_and_reason_path)

saveRDS(turkstat_migration_prov_and_reason, here('data', 'processed', 'turkstat_migration_prov_and_reason.rds'))



# Provivence Population statistics ----------------------------------------


turkstat_pop_age_prov_sex_path <- here("data", "raw", "turkstat_pop_age_prov_sex_CLEANED.xls")

turkstat_pop_age_prov_sex <- read_xls(turkstat_pop_age_prov_sex_path)

saveRDS(turkstat_pop_age_prov_sex, here('data', 'processed', 'turkstat_pop_age_prov_sex.rds'))



