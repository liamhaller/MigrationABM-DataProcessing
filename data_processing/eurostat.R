#Location of visa data
eurostat_path <- here("data", "raw", "eurostat_permits.xlsx")

eurostat <- read_xlsx(eurostat_path)

saveRDS(object = eurostat, file =  here("data", "processed", "eurostat.rds"))
