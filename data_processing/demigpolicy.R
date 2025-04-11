# Script to load and combine DEMIG Policy Databases for Germany and Turkey

# Set the relative file paths using the here package
 turkey_path <- here("data", "raw", "demig-policy-database_turkey_version-1-3.xlsx")
 germany_path <- here("data", "raw", "demig-policy-database_germany_version-1-3.xlsx")



# Load Germany Data -------------------------------------------------------

 germany_demig <- read_excel(germany_path, sheet = 1, col_names = TRUE, skip = 1)

 # Remove rows where all values are NA
 germany_demig <- germany_data %>% filter_all(any_vars(!is.na(.)))

 # Add country identifier
 germany_demig$country <- "Germany"



# Load Turkey Data --------------------------------------------------------


turkey_demig <- read_excel(turkey_path, sheet = 1, col_names = TRUE, skip = 1)

 # Remove rows where all values are NA
 turkey_demig <- turkey_demig %>% filter_all(any_vars(!is.na(.)))

 # Add country identifier
 turkey_demig$country <- "Turkey"


# Merge and save Turkey and Germany DEMIG data -------------------------------------

# Combine the datasets
data_demig <- bind_rows(germany_demig, turkey_demig)

# Save as R object for easier future access
saveRDS(data_demig, here("data", "processed", "demig_data.rds"))

