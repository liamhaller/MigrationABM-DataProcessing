


# Residence permit data ---------------------------------------------------


#Location of visa data
tk_visa_path <- here("data", "raw", "destat_001_totalpermits_CLEAN.xlsx")

tk_visa_destatis <- read_excel(tk_visa_path, sheet = 1, col_names = TRUE)

#convert year column from character to numeric
tk_visa_destatis$year <- as.numeric(tk_visa_destatis$year)

saveRDS(object = tk_visa_destatis, file =  here("data", "processed", "destatis_visa.rds"))



# -------------------------------------------------------------------------


#Location of entry/exit data
tk_enter_and_exit_path <- here("data", "raw", "destat_002_enterandexits_CLEAN.xlsx")

enterandexit_destatis <- read_excel(tk_enter_and_exit_path, sheet = 1, col_names = TRUE)

#convert year column from character to numeric
enterandexit_destatis$year <- as.numeric(enterandexit_destatis$year)

saveRDS(object = enterandexit_destatis, file =  here("data", "processed", "destatis_enterandexit.rds"))

