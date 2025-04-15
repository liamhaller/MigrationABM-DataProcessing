
# Import data
social_connections_path <- here("data", "raw", "gadm1_nuts2-gadm1_nuts2-fb-social-connectedness-index-october-2021.tsv")
social_connections <- read_tsv(social_connections_path)


# Filter Dataset---------------------------------------------------------

# Filter connections between Turkey and Germany
turkey_germany_connections <- social_connections %>%
  filter(
    (str_detect(user_loc, "^TR") & str_detect(fr_loc, "^DE")) |
      (str_detect(user_loc, "^DE") & str_detect(fr_loc, "^TR"))
  )

# Save the filtered dataset as RDS file for model building
saveRDS(turkey_germany_connections, here("data", "processed", "turkey_germany_connections.rds"))



# Prelim Analysis ---------------------------------------------------------



# Get lists of unique Turkish and German regions
turkish_regions <- turkey_germany_connections %>%
  filter(str_detect(user_loc, "^TR")) %>%
  select(user_loc) %>%
  distinct() %>%
  pull(user_loc)

german_regions <- turkey_germany_connections %>%
  filter(str_detect(user_loc, "^DE")) %>%
  select(user_loc) %>%
  distinct() %>%
  pull(user_loc)

cat("Number of Turkish regions:", length(turkish_regions), "\n")
cat("Number of German regions:", length(german_regions), "\n")

# Create a direction indicator
turkey_germany_connections <- turkey_germany_connections %>%
  mutate(direction = case_when(
    str_detect(user_loc, "^TR") & str_detect(fr_loc, "^DE") ~ "Turkey to Germany",
    str_detect(user_loc, "^DE") & str_detect(fr_loc, "^TR") ~ "Germany to Turkey",
    TRUE ~ "Other"
  ))

# Find top connections
top_connections <- turkey_germany_connections %>%
  arrange(desc(scaled_sci)) %>%
  head(20)

print("Top 20 strongest connections:")
print(top_connections)


