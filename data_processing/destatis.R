


# Residence permit data ---------------------------------------------------


#All Permits (Only until 2019)
tk_visa_path <- here("data", "raw", "destatis_all_permits_CLEAN.xlsx")

all_permits_destatis <- read_excel(tk_visa_path, sheet = 1, col_names = TRUE)

saveRDS(object = all_permits_destatis, file =  here("data", "processed", "all_permits_destatis.rds"))





# Selected Permits --------------------------------------------------------
#All Permits (Only until 2019)
some_visas_path <- here("data", "raw", "destatis_some_permits_clean.xlsx")

some_visas_destatis <- read_excel(some_visas_path, sheet = 1, col_names = TRUE)

saveRDS(object = some_visas_destatis, file =  here("data", "processed", "some_permits_destatis.rds"))



# -------------------------------------------------------------------------


#Location of entry/exit data
tk_enter_and_exit_path <- here("data", "raw", "destat_002_enterandexits_CLEAN.xlsx")

enterandexit_destatis <- read_excel(tk_enter_and_exit_path, sheet = 1, col_names = TRUE)

#convert year column from character to numeric
enterandexit_destatis$year <- as.numeric(enterandexit_destatis$year)

saveRDS(object = enterandexit_destatis, file =  here("data", "processed", "destatis_enterandexit.rds"))

