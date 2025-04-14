
#Emigration and Emigration from Turkey by citizenship

#Location of visa data
turkstat_migration_path <- here("data", "raw", "tkst_01_citizenship_CLEANED.xls")

turkstat_migration <- read_xls(turkstat_migration_path)

saveRDS(turkstat_migration, here('data', 'processed', 'turkstat_migration.rds'))
