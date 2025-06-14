#Turkey-Turkey Connections


# Load and Process Data ---------------------------------------------------



tk_tk_connection <- readRDS(here("data", "processed", "turkey_turkey_connections.rds"))

#Example of a simple lookup table for Turkey NUTS-2 regions
turkey_regions <- tribble(
  ~region_code, ~region_name, ~latitude, ~longitude,
  "TR10", "Istanbul", 41.0082, 28.9784,
  "TR21", "Tekirdağ, Edirne, Kırklareli", 41.2867, 27.5167,
  "TR22", "Balıkesir, Çanakkale", 39.6484, 27.8826,
  "TR31", "İzmir", 38.4237, 27.1428,
  "TR32", "Aydın, Denizli, Muğla", 37.8464, 29.0938,
  "TR33", "Manisa, Afyon, Kütahya, Uşak", 38.6191, 29.0739,
  "TR41", "Bursa, Eskişehir, Bilecik", 40.1885, 29.0610,
  "TR42", "Kocaeli, Sakarya, Düzce, Bolu, Yalova", 40.7654, 30.3780,
  "TR51", "Ankara", 39.9334, 32.8597,
  "TR52", "Konya, Karaman", 37.8746, 32.4932,
  "TR61", "Antalya, Isparta, Burdur", 36.9081, 30.6956,
  "TR62", "Adana, Mersin", 37.0000, 35.3213,
  "TR63", "Hatay, Kahramanmaraş, Osmaniye", 36.2154, 36.1762,
  "TR71", "Kırıkkale, Aksaray, Niğde, Nevşehir, Kırşehir", 39.8468, 33.5153,
  "TR72", "Kayseri, Sivas, Yozgat", 38.7205, 35.4894,
  "TR81", "Zonguldak, Karabük, Bartın", 41.4535, 31.7894,
  "TR82", "Kastamonu, Çankırı, Sinop", 41.3887, 33.7827,
  "TR83", "Samsun, Tokat, Çorum, Amasya", 41.2867, 36.3314,
  "TR90", "Trabzon, Ordu, Giresun, Rize, Artvin, Gümüşhane", 41.0053, 39.7267,
  "TRA1", "Erzurum, Erzincan, Bayburt", 39.9073, 41.2658,
  "TRA2", "Ağrı, Kars, Iğdır, Ardahan", 39.7191, 43.0566,
  "TRB1", "Malatya, Elazığ, Bingöl, Tunceli", 38.3554, 38.3335,
  "TRB2", "Van, Muş, Bitlis, Hakkari", 38.4916, 43.4830,
  "TRC1", "Gaziantep, Adıyaman, Kilis", 37.0662, 37.3833,
  "TRC2", "Şanlıurfa, Diyarbakır", 37.1674, 38.7955,
  "TRC3", "Mardin, Batman, Şırnak, Siirt", 37.3212, 40.7245
)


# Join the region names to your connections data
intra_turkey_connections <- tk_tk_connection %>%
  left_join(
    turkey_regions %>% select(region_code, region_name, latitude, longitude),
    by = c("user_loc" = "region_code")
  ) %>%
  rename(
    origin_name = region_name,
    origin_lat = latitude,
    origin_lon = longitude
  ) %>%
  left_join(
    turkey_regions %>% select(region_code, region_name, latitude, longitude),
    by = c("fr_loc" = "region_code")
  ) %>%
  rename(
    dest_name = region_name,
    dest_lat = latitude,
    dest_lon = longitude
  )



# Scaled Social Connectivity Values ---------------------------------------





# Summary statistics of scaled_sci
sci_summary <- summary(intra_turkey_connections$scaled_sci)
print(sci_summary)

# Calculate maximum SCI value for normalization
sci_max <- max(intra_turkey_connections$scaled_sci, na.rm = TRUE)
print(paste("Maximum SCI value:", sci_max))

# Calculate province-level statistics
province_stats <- intra_turkey_connections %>%
  group_by(user_loc) %>%
  summarize(
    mean_sci = mean(scaled_sci, na.rm = TRUE),
    median_sci = median(scaled_sci, na.rm = TRUE),
    max_sci = max(scaled_sci, na.rm = TRUE),
    sum_sci = sum(scaled_sci, na.rm = TRUE),
    connection_count = n()
  ) %>%
  arrange(desc(mean_sci))

print(province_stats)

# Calculate the beta parameter for each province pair
intra_turkey_connections <- intra_turkey_connections %>%
  mutate(beta = scaled_sci / sci_max)

# Summary of beta values
beta_summary <- summary(intra_turkey_connections$beta)
print(beta_summary)

# Calculate connectivity matrix for visualization
connection_matrix <- intra_turkey_connections %>%
  select(user_loc, fr_loc, beta) %>%
  pivot_wider(names_from = fr_loc, values_from = beta, values_fill = 0)



