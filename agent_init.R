# List of Turkey's NUTS2 regions
turkey_nuts2 <- data.frame(
  region_code = c(
    "TR10", "TR21", "TR22", "TR31", "TR32", "TR33", "TR41", "TR42",
    "TR51", "TR52", "TR61", "TR62", "TR63", "TR71", "TR72", "TR81",
    "TR82", "TR83", "TR90", "TRA1", "TRA2", "TRB1", "TRB2", "TRC1",
    "TRC2", "TRC3"
  ),
  region_name = c(
    "Istanbul", "Tekirdağ, Edirne, Kırklareli", "Balıkesir, Çanakkale",
    "İzmir", "Aydın, Denizli, Muğla", "Manisa, Afyon, Kütahya, Uşak",
    "Bursa, Eskişehir, Bilecik", "Kocaeli, Sakarya, Düzce, Bolu, Yalova",
    "Ankara", "Konya, Karaman", "Antalya, Isparta, Burdur",
    "Adana, Mersin", "Hatay, Kahramanmaraş, Osmaniye",
    "Kırıkkale, Aksaray, Niğde, Nevşehir, Kırşehir", "Kayseri, Sivas, Yozgat",
    "Zonguldak, Karabük, Bartın", "Kastamonu, Çankırı, Sinop",
    "Samsun, Tokat, Çorum, Amasya", "Trabzon, Ordu, Giresun, Rize, Artvin, Gümüşhane",
    "Erzurum, Erzincan, Bayburt", "Ağrı, Kars, Iğdır, Ardahan",
    "Malatya, Elazığ, Bingöl, Tunceli", "Van, Muş, Bitlis, Hakkari",
    "Gaziantep, Adıyaman, Kilis", "Şanlıurfa, Diyarbakır",
    "Mardin, Batman, Şırnak, Siirt"
  ),
  stringsAsFactors = FALSE
)

# Region parameters structure for agent generation
region_params <- data.frame(
  region_code = turkey_nuts2$region_code,
  region_name = turkey_nuts2$region_name,
  population_weight = numeric(26),  # To be filled with actual weights
  stringsAsFactors = FALSE
)

# Base structure for demographic distributions
demographic_distributions <- data.frame(
  region_code = turkey_nuts2$region_code,

  # Gender distribution
  gender_male_prob = numeric(26),

  # Age distribution
  age_distribution = rep("normal", 26),
  age_mean = numeric(26),
  age_sd = numeric(26),
  age_min = rep(18, 26),
  age_max = rep(65, 26),

  # Income distribution
  income_distribution = rep("lognormal", 26),
  income_meanlog = numeric(26),
  income_sdlog = numeric(26),

  stringsAsFactors = FALSE
)

# Base structure for education distribution (as separate dataframe due to discrete nature)
education_distributions <- list()
for(region in turkey_nuts2$region_code) {
  education_distributions[[region]] <- data.frame(
    education_level = c(0, 5, 8, 12, 16),  # Example education levels
    probability = numeric(5),              # To be filled with actual probabilities
    stringsAsFactors = FALSE
  )
}

# Base structure for TPB component distributions
tpb_distributions <- data.frame(
  region_code = turkey_nuts2$region_code,

  # Attitude distribution
  attitude_distribution = rep("beta", 26),
  attitude_alpha = numeric(26),
  attitude_beta = numeric(26),

  # Subjective norm distribution
  norm_distribution = rep("beta", 26),
  norm_alpha = numeric(26),
  norm_beta = numeric(26),

  # Perceived behavioral control distribution
  pbc_distribution = rep("beta", 26),
  pbc_alpha = numeric(26),
  pbc_beta = numeric(26),

  stringsAsFactors = FALSE
)

# Base structure for network parameters
network_params <- data.frame(
  region_code = turkey_nuts2$region_code,
  prob_contact_abroad = numeric(26),
  mean_contacts_abroad = numeric(26),
  prob_family_abroad = numeric(26),
  stringsAsFactors = FALSE
)

# Base structure for environmental sensitivity parameters
environmental_sensitivity <- data.frame(
  region_code = turkey_nuts2$region_code,
  policy_sensitivity = numeric(26),
  economic_sensitivity = numeric(26),
  political_sensitivity = numeric(26),
  stringsAsFactors = FALSE
)

# Base structure for migration stage parameters
migration_stages <- data.frame(
  region_code = turkey_nuts2$region_code,

  # Initial stage distribution
  pct_no_intention = numeric(26),
  pct_intention = numeric(26),
  pct_planning = numeric(26),
  pct_preparation = numeric(26),
  pct_migration = numeric(26),

  # Stage transition thresholds
  threshold_to_intention = numeric(26),
  threshold_to_planning = numeric(26),
  threshold_to_preparation = numeric(26),
  threshold_to_migration = numeric(26),

  # Mean waiting times
  mean_time_intention = numeric(26),
  mean_time_planning = numeric(26),
  mean_time_preparation = numeric(26),

  stringsAsFactors = FALSE
)

# Base structure for region-to-region connections
# Create all possible Turkey-to-Germany NUTS2 region pairs
germany_nuts2 <- c(
  "DE11", "DE12", "DE13", "DE14", "DE21", "DE22", "DE23", "DE24", "DE25",
  "DE26", "DE27", "DE30", "DE40", "DE50", "DE60", "DE71", "DE72", "DE73",
  "DE80", "DE91", "DE92", "DE93", "DE94", "DEA1", "DEA2", "DEA3", "DEA4",
  "DEA5", "DEB1", "DEB2", "DEB3", "DEC0", "DED2", "DED4", "DED5", "DEE0",
  "DEF0", "DEG0"
)

# Create all pairs for connections
region_pairs <- expand.grid(
  source_region = turkey_nuts2$region_code,
  target_region = germany_nuts2,
  stringsAsFactors = FALSE
)

region_connections <- data.frame(
  source_region = region_pairs$source_region,
  target_region = region_pairs$target_region,
  connection_strength = numeric(nrow(region_pairs)),
  migration_probability = numeric(nrow(region_pairs)),
  stringsAsFactors = FALSE
)

# Base structure for environmental time series
# Create a monthly timeline for 2010-2020
dates <- seq(as.Date("2010-01-01"), as.Date("2020-12-01"), by = "month")
years <- as.numeric(format(dates, "%Y"))
months <- as.numeric(format(dates, "%m"))

environmental_ts <- data.frame(
  date = dates,
  year = years,
  month = months,

  # Policy variables
  policy_restrictiveness = numeric(length(dates)),

  # Economic variables
  unemployment_turkey = numeric(length(dates)),
  unemployment_germany = numeric(length(dates)),

  # Political variables
  political_stability_turkey = numeric(length(dates)),

  stringsAsFactors = FALSE
)

# Base structure for region-specific time series
regional_ts <- data.frame(
  date = rep(dates, each = length(turkey_nuts2$region_code)),
  region_code = rep(turkey_nuts2$region_code, times = length(dates)),

  # Regional metrics
  unemployment_rate = numeric(length(dates) * length(turkey_nuts2$region_code)),
  relative_gdp = numeric(length(dates) * length(turkey_nuts2$region_code)),
  outmigration_rate = numeric(length(dates) * length(turkey_nuts2$region_code)),

  stringsAsFactors = FALSE
)

# Base structure for policy events
policy_events <- data.frame(
  date = as.Date(character(0)),
  event_name = character(0),
  policy_area = character(0),
  effect_size = numeric(0),
  target_group = character(0),
  description = character(0),
  stringsAsFactors = FALSE
)

# Base structure for calibration targets
calibration_targets <- data.frame(
  year = 2010:2020,

  # Migration flows
  total_flow = numeric(11),

  # Demographic breakdown
  male_ratio = numeric(11),
  high_education_ratio = numeric(11),

  # Age distribution
  age_under25 = numeric(11),
  age_25to34 = numeric(11),
  age_35to44 = numeric(11),
  age_over44 = numeric(11),

  stringsAsFactors = FALSE
)

# Base structure for regional calibration targets
regional_targets <- data.frame(
  year = rep(c(2010, 2015, 2020), each = length(turkey_nuts2$region_code)),
  region_code = rep(turkey_nuts2$region_code, times = 3),

  # Migration metrics
  migration_rate = numeric(length(turkey_nuts2$region_code) * 3),
  male_rate = numeric(length(turkey_nuts2$region_code) * 3),
  female_rate = numeric(length(turkey_nuts2$region_code) * 3),

  stringsAsFactors = FALSE
)
