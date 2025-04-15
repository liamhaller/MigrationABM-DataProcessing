

# Load necessary libraries
library(readr)
library(dplyr)
library(sf)
library(ggplot2)
library(rworldmap)

# Load your connections data
connections <- readRDS(here("data", "processed", "turkey_germany_connections.rds"))

# Create or load region code lookup tables
# You can manually create these or use existing datasets

# Example of a simple lookup table for Turkey NUTS-2 regions
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

# Example for German NUTS-2 regions
german_regions <- tribble(
  ~region_code, ~region_name, ~latitude, ~longitude,
  "DE11", "Stuttgart", 48.7758, 9.1829,
  "DE12", "Karlsruhe", 49.0069, 8.4037,
  "DE13", "Freiburg", 47.9990, 7.8421,
  "DE14", "Tübingen", 48.5216, 9.0576,
  "DE21", "Oberbayern", 48.1351, 11.5820,
  "DE22", "Niederbayern", 48.5665, 12.1571,
  "DE23", "Oberpfalz", 49.0158, 12.0974,
  "DE24", "Oberfranken", 50.0051, 11.5164,
  "DE25", "Mittelfranken", 49.4539, 10.9856,
  "DE26", "Unterfranken", 49.7913, 9.9534,
  "DE27", "Schwaben", 48.3705, 10.8978,
  "DE30", "Berlin", 52.5200, 13.4050,
  "DE40", "Brandenburg", 52.4125, 12.5316,
  "DE50", "Bremen", 53.0793, 8.8017,
  "DE60", "Hamburg", 53.5511, 9.9937,
  "DE71", "Darmstadt", 49.8728, 8.6512,
  "DE72", "Gießen", 50.5841, 8.6784,
  "DE73", "Kassel", 51.3127, 9.4797,
  "DE80", "Mecklenburg-Vorpommern", 53.6127, 12.4296,
  "DE91", "Braunschweig", 52.2689, 10.5267,
  "DE92", "Hannover", 52.3759, 9.7320,
  "DE93", "Lüneburg", 53.2464, 10.4115,
  "DE94", "Weser-Ems", 53.1435, 8.2146,
  "DEA1", "Düsseldorf", 51.2277, 6.7735,
  "DEA2", "Köln", 50.9375, 6.9603,
  "DEA3", "Münster", 51.9607, 7.6261,
  "DEA4", "Detmold", 51.9433, 8.8821,
  "DEA5", "Arnsberg", 51.3994, 8.0724,
  "DEB1", "Koblenz", 50.3569, 7.5890,
  "DEB2", "Trier", 49.7557, 6.6394,
  "DEB3", "Rheinhessen-Pfalz", 49.9922, 8.2472,
  "DEC0", "Saarland", 49.3964, 7.0230,
  "DED2", "Dresden", 51.0509, 13.7383,
  "DED4", "Chemnitz", 50.8278, 12.9213,
  "DED5", "Leipzig", 51.3397, 12.3731,
  "DEE0", "Sachsen-Anhalt", 51.9503, 11.6923,
  "DEF0", "Schleswig-Holstein", 54.2194, 9.6962,
  "DEG0", "Thüringen", 50.9809, 11.0298
)

# Join the region names to your connections data
connections_with_names <- connections %>%
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

# If the join didn't work for some regions, try with the German regions data
connections_with_names <- connections_with_names %>%
  left_join(
    german_regions %>% select(region_code, region_name, latitude, longitude),
    by = c("user_loc" = "region_code")
  ) %>%
  mutate(
    origin_name = ifelse(is.na(origin_name), region_name, origin_name),
    origin_lat = ifelse(is.na(origin_lat), latitude, origin_lat),
    origin_lon = ifelse(is.na(origin_lon), longitude, origin_lon)
  ) %>%
  select(-region_name, -latitude, -longitude) %>%
  left_join(
    german_regions %>% select(region_code, region_name, latitude, longitude),
    by = c("fr_loc" = "region_code")
  ) %>%
  mutate(
    dest_name = ifelse(is.na(dest_name), region_name, dest_name),
    dest_lat = ifelse(is.na(dest_lat), latitude, dest_lat),
    dest_lon = ifelse(is.na(dest_lon), longitude, dest_lon)
  ) %>%
  select(-region_name, -latitude, -longitude)

# Check your top connection (DEA3 to TR81)
top_connection <- connections_with_names %>%
  filter(user_loc == "DEA3" & fr_loc == "TR81" | user_loc == "TR81" & fr_loc == "DEA3")

print(top_connection)



# -------------------------------------------------------------------------


# Create a unique identifier for each region pair (regardless of direction)
connections_unique <- connections_with_names %>%
  # Create a unique pair ID by sorting the region codes alphabetically
  mutate(
    region_pair = ifelse(user_loc < fr_loc,
                         paste(user_loc, fr_loc, sep="_"),
                         paste(fr_loc, user_loc, sep="_"))
  ) %>%
  # Group by the region pair and keep only one row per pair
  group_by(region_pair) %>%
  slice(1) %>%
  ungroup()


sorted_connections <- connections_unique %>%
  group_by(fr_loc) %>%
  dplyr::arrange(desc(scaled_sci)) %>%
  filter(scaled_sci < 10000)



# Load world map data
world_map <- map_data("world")

# Create a plot with connections
ggplot() +
  # Add world map
  geom_polygon(data = world_map, aes(x = long, y = lat, group = group),
               fill = "lightgray", color = "white", size = 0.1) +
  # Add connection lines (for top 20 connections)
  geom_segment(
    data = head(sorted_connections, 2), #sort high to low
    aes(x = origin_lon, y = origin_lat, xend = dest_lon, yend = dest_lat,
        alpha = scaled_sci, size = scaled_sci),
    color = "purple", lineend = "round"
  ) +
  # Add points for regions
  geom_point(
    data = sorted_connections,
    aes(x = origin_lon, y = origin_lat),
    color = "red", size = 2
  ) +
  geom_point(
    data = sorted_connections,
    aes(x = dest_lon, y = dest_lat),
    color = "blue", size = 2
  ) +
  # Zoom to Europe/Turkey area
  coord_cartesian(xlim = c(0, 45), ylim = c(35, 60)) +
  # Add labels
  labs(
    title = "Social Connections Between Turkey and Germany",
    subtitle = "Line thickness indicates connection strength",
    x = "Longitude", y = "Latitude"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")



# -------------------------------------------------------------------------


# Create a unique identifier for each region pair (regardless of direction)
connections_unique <- connections_with_names %>%
  # Create a unique pair ID by sorting the region codes alphabetically
  mutate(
    region_pair = ifelse(user_loc < fr_loc,
                         paste(user_loc, fr_loc, sep="_"),
                         paste(fr_loc, user_loc, sep="_"))
  ) %>%
  # Group by the region pair and keep only one row per pair
  group_by(region_pair) %>%
  slice(1) %>%
  ungroup()

sorted_connections <- connections_unique %>%
  group_by(user_loc, fr_loc) %>%
  dplyr::arrange(desc(scaled_sci)) %>%
  filter(scaled_sci < 10000)

# Add a column for the Turkish region in each connection
sorted_connections <- sorted_connections %>%
  mutate(
    turkish_region = case_when(
      str_detect(user_loc, "^TR") ~ user_loc,
      str_detect(fr_loc, "^TR") ~ fr_loc,
      TRUE ~ NA_character_
    )
  )

# Create a mapping of region codes to names for the legend
region_names <- sorted_connections %>%
  mutate(
    region_code = turkish_region,
    region_name = case_when(
      str_detect(user_loc, "^TR") ~ origin_name,
      str_detect(fr_loc, "^TR") ~ dest_name,
      TRUE ~ NA_character_
    )
  ) %>%
  select(region_code, region_name) %>%
  distinct() %>%
  filter(!is.na(region_code))

# Create a named vector for the labels
region_labels <- setNames(
  region_names$region_name,
  region_names$region_code
)

# Load world map data
world_map <- map_data("world")

# Create a plot with connections
ggplot() +
  # Add world map
  geom_polygon(data = world_map, aes(x = long, y = lat, group = group),
               fill = "lightgray", color = "white", size = 0.1) +
  # Add connection lines (for top 20 connections) with colors by Turkish region
  geom_segment(
    data = head(sorted_connections, 5), #sort high to low
    aes(x = origin_lon, y = origin_lat, xend = dest_lon, yend = dest_lat,
        alpha = scaled_sci, size = scaled_sci, color = turkish_region),
    lineend = "round"
  ) +
  # Use a custom color scale with region names
  scale_color_discrete(
    name = "Turkish Region",
    labels = function(x) region_labels[x]
  ) +
  # Add points for regions
  geom_point(
    data = connections_with_names,
    aes(x = origin_lon, y = origin_lat),
    color = "red", size = 2
  ) +
  geom_point(
    data = connections_with_names,
    aes(x = dest_lon, y = dest_lat),
    color = "blue", size = 2
  ) +
  # Zoom to Europe/Turkey area
  coord_cartesian(xlim = c(0, 45), ylim = c(35, 60)) +
  # Add labels
  labs(
    title = "Social Connections Between Turkey and Germany",
    subtitle = "Line color indicates Turkish region, thickness shows connection strength",
    x = "Longitude", y = "Latitude"
  ) +
  theme_minimal() +
  theme(legend.position = "right")

