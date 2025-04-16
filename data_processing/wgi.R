

wgi_path <- here("data", "raw", "wgidataset_with_sourcedata.xlsx")

wgi <- read_xlsx(wgi_path)

wgi <- wgi %>%
  filter(countryname == "Türkiye") %>%
  filter(year > 2010)

saveRDS(wgi, here('data', 'processed', 'wgi.rds'))




