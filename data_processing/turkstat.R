
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


# CPI Data ----------------------------------------------------------------


turkstat_econ_cpi_path <- here("data", "raw", "tk_cpi_CLEANED.xls")

turkstat_econ_cpi<- read_xls(turkstat_econ_cpi_path)



# Sequence of dates from Jan 2005 to Mar 2025
date_seq <- seq(from = as.Date("2005-01-01"),
                to = as.Date("2025-03-01"),
                by = "month")

# Convert dates to character in the format "YYYY-MM-DD"
date_strings <- format(date_seq, "%Y-%m-%d")

# Get the original column names
original_cols <- names(turkstat_econ_cpi)

# Create new column names (keep the first column as "category" and replace others with dates)
new_colnames <- c("category", date_strings[1:(length(original_cols)-1)])

# Assign new column names
names(turkstat_econ_cpi) <- new_colnames

# 2. Transpose the data so categories are columns and dates are rows
# First, pivot the data to long format
cpi_long <- turkstat_econ_cpi %>%
  pivot_longer(
    cols = -category,
    names_to = "date",
    values_to = "value"
  )

# Then pivot it back to wide format with categories as columns
cpi_transposed <- cpi_long %>%
  pivot_wider(
    names_from = category,
    values_from = value
  )

# Convert the date column to proper Date type and make it the first column
cpi_transposed <- cpi_transposed %>%
  mutate(date = as.Date(date)) %>%
  arrange(date)

# View the result
head(cpi_transposed)


saveRDS(cpi_transposed, here('data', 'processed', 'turkstat_econ_cpi.rds'))


# unemployment ------------------------------------------------------------






#Downloaded from Turkstat databsae
turkstat_econ_unep_path <- here("data", "raw", "pivot.xls")

turkstat_econ_unep <- read_xls(turkstat_econ_unep_path)


# Clean column names - assuming the first row contains the actual data
# This is necessary because the table structure has multiple header rows
names(turkstat_econ_unep) <- c("gender", "age_group", "year",
                               # Add all region names here
                               "adana_mersin", "ankara", "antalya_isparta_burdur",
                               "aydin_denizli_mugla", "agri_kars_igdir_ardahan",
                               "balikesir_canakkale", "bursa_eskisehir_bilecik",
                               "erzurum_erzincan_bayburt", "gaziantep_adiyaman_kilis",
                               "hatay_kahramanmaras_osmaniye", "kastamonu_cankiri_sinop",
                               "kayseri_sivas_yozgat", "kocaeli_sakarya_duzce_bolu_yalova",
                               "konya_karaman", "kirikkale_aksaray_nigde_nevsehir_kirsehir",
                               "malatya_elazig_bingol_tunceli", "manisa_afyon_kutahya_usak",
                               "mardin_batman_sirnak_siirt", "samsun_tokat_corum_amasya",
                               "tekirdag_edirne_kirklareli", "trabzon_ordu_giresun_rize_artvin_gumushane",
                               "van_mus_bitlis_hakkari", "zonguldak_karabuk_bartin",
                               "istanbul", "izmir", "sanliurfa_diyarbakir")

# Convert to long format
unemployment_long <- turkstat_econ_unep %>%
  # First make sure year is numeric
  mutate(year = as.numeric(year)) %>%
  # Then pivot to long format
  pivot_longer(
    cols = -c(gender, age_group, year),
    names_to = "region",
    values_to = "unemployment_rate"
  ) %>%
  # Clean up unemployment rate (removing potential % symbols and converting to numeric)
  mutate(unemployment_rate = as.numeric(unemployment_rate))

# Preview the resulting data
head(unemployment_long)

# Save the transformed data
saveRDS(unemployment_long, here("data", "processed", "turkstat_econ_unemployment.rds"))
