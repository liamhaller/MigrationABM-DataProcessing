

#Location of visa data
emigration_oecd_path <- here("data", "raw", "oecd_tk_emigration.xlsx")

emigration_oecd <- read_excel(emigration_oecd_path, sheet = 1, col_names = TRUE)


saveRDS(object = emigration_oecd, file =  here("data", "processed", "oecd_emigration.rds"))
