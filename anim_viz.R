# Turkey Migration Stages Animation
# This script creates an animated GIF showing agent migration stages across Turkey over time

# Load required libraries
library(ggplot2)
library(gganimate)
library(dplyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(viridis)
library(scales)
library(patchwork)

# =============================================================================
# LOAD YOUR ACTUAL DATA
# =============================================================================
# Load the actual data files
migration_data <- read.csv("agent_data_full.csv", stringsAsFactors = FALSE)
status_data <- read.csv("model_data_full.csv", stringsAsFactors = FALSE)

# If you have tab-separated files instead of CSV:
# migration_data <- read.table("agent_data_full.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
# status_data <- read.table("model_data_full.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Determine migration stages and colors from actual data
migration_stages <- unique(migration_data$migration_stage)
n_stages <- length(migration_stages)

# Define colors for migration stages (adjust if you have different stages)
if(n_stages <= 5) {
  stage_colors <- c("#440154FF", "#31688EFF", "#35B779FF", "#FDE725FF", "#FF6B6B")[1:n_stages]
} else {
  stage_colors <- rainbow(n_stages)
}
names(stage_colors) <- migration_stages

cat("Detected migration stages:", paste(migration_stages, collapse = ", "), "\n")
cat("Number of time steps:", length(unique(migration_data$time)), "\n")
cat("Number of agents:", length(unique(migration_data$id)), "\n")
cat("Number of provinces:", length(unique(migration_data$province)), "\n")

# Get Turkey map data
turkey <- ne_states(country = "Turkey", returnclass = "sf")

# Create more realistic province coordinates
# Turkey province centroids (approximate coordinates for all 81 provinces)
turkey_provinces <- data.frame(
  province = 1:81,
  province_name = c("Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya",
                    "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur",
                    "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne",
                    "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane",
                    "Hakkari", "Hatay", "Isparta", "Mersin", "Istanbul", "İzmir", "Kars", "Kastamonu",
                    "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya",
                    "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu",
                    "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat",
                    "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray",
                    "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan",
                    "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"),
  # Longitude coordinates for all 81 Turkish provinces
  lon = c(35.3213, 37.7648, 30.5387, 43.0516, 35.8353, 32.8543, 30.7133, 41.8183, 27.8416,
          27.8860, 29.9833, 40.4986, 42.1232, 31.6061, 30.2508, 29.0601, 26.4142, 33.6134,
          34.9414, 29.0875, 40.2306, 26.5557, 39.2264, 39.4904, 41.2769, 30.5206, 37.3825,
          38.3895, 39.4608, 43.7333, 36.2012, 30.5566, 34.6191, 28.9784, 27.1428, 40.6013,
          33.7827, 35.4787, 27.2333, 34.1709, 29.9184, 32.4823, 29.9833, 38.3552, 27.4305,
          36.9471, 40.7245, 28.3665, 41.4983, 34.6857, 34.6857, 37.8764, 40.5234, 30.4358,
          36.3394, 41.9303, 35.1667, 39.7477, 27.8460, 39.8667, 39.7200, 39.1079, 38.7935,
          29.4058, 43.4089, 34.8007, 31.1667, 36.8000, 40.6500, 40.2667, 32.8597, 33.4167,
          42.1167, 44.0167, 29.2667, 32.1833, 36.7167, 36.2485, 31.1667, 37.2085, 40.9333),
  # Latitude coordinates for all 81 Turkish provinces
  lat = c(37.0000, 37.7648, 38.7507, 39.7191, 40.6499, 39.9334, 36.8969, 41.1828, 37.8560,
          39.6484, 40.1500, 38.8821, 38.3938, 40.5760, 37.7170, 40.1828, 40.1553, 40.6013,
          40.5506, 37.7765, 37.9144, 41.6818, 38.6810, 39.7500, 39.9043, 39.7767, 37.0662,
          40.9128, 40.4602, 37.5739, 36.4018, 37.7687, 36.8000, 41.0082, 38.4237, 40.6013,
          41.3887, 38.7312, 41.3354, 39.1425, 40.7654, 37.8667, 39.4242, 38.3552, 38.6191,
          37.5858, 37.3212, 37.2153, 39.1079, 38.6939, 37.9667, 41.0130, 41.0201, 40.7833,
          41.2167, 37.9333, 42.0231, 39.7477, 40.7833, 40.3167, 41.0026, 39.1079, 37.1591,
          38.6823, 38.5012, 39.8181, 41.6406, 38.3552, 40.6167, 40.3167, 40.9167, 33.4167,
          42.1167, 44.0167, 40.7833, 32.1833, 36.7167, 36.2485, 40.8667, 36.2667, 41.0333)
)

# If you have exact province coordinates, replace the above with:
# turkey_provinces <- read.csv("turkey_province_coordinates.csv")

# Merge migration data with coordinates (suppress expected many-to-many warning)
migration_map_data <- migration_data %>%
  left_join(turkey_provinces, by = "province") %>%
  left_join(status_data, by = "time", relationship = "many-to-many")

# Create the main map plot function
create_map_plot <- function(data, time_point) {
  current_data <- data %>% filter(time == time_point)

  # Create the map
  map_plot <- ggplot() +
    geom_sf(data = turkey, fill = "white", color = "gray70", size = 0.3) +
    geom_point(data = current_data,
               aes(x = lon, y = lat, color = migration_stage),
               size = 1.2, alpha = 0.8) +
    scale_color_manual(values = stage_colors, name = "Migration Stage") +
    theme_void() +
    theme(
      legend.position = "bottom",
      legend.title = element_text(size = 11, face = "bold"),
      legend.text = element_text(size = 9),
      plot.title = element_text(size = 13, hjust = 0.5, face = "bold"),
      plot.subtitle = element_text(size = 11, hjust = 0.5),
      legend.key.size = unit(0.8, "cm")
    ) +
    labs(
      title = "Migration Stages Across Turkish Provinces",
      subtitle = paste("Time Step:", time_point)
    ) +
    coord_sf(xlim = c(25, 46), ylim = c(35, 43)) +
    guides(color = guide_legend(override.aes = list(size = 3, alpha = 1)))

  return(map_plot)
}

# Create enhanced status variables plot
create_status_plot <- function(data, current_time) {
  status_subset <- data %>% filter(time <= current_time)

  # Get all status variable columns (excluding the count columns like #15, #17, etc.)
  status_cols <- names(status_data)[!names(status_data) %in% c("time", "current_time_months") &
                                      !grepl("^#", names(status_data))]

  status_long <- status_subset %>%
    select(time, all_of(status_cols)) %>%
    pivot_longer(cols = -time, names_to = "variable", values_to = "value") %>%
    mutate(
      country = case_when(
        grepl("turkey", variable, ignore.case = TRUE) ~ "Turkey",
        grepl("germany", variable, ignore.case = TRUE) ~ "Germany",
        TRUE ~ "Other"
      ),
      variable_clean = case_when(
        grepl("economic", variable) ~ "Economic Conditions",
        grepl("political", variable) ~ "Political Instability",
        grepl("policy", variable) ~ "Policy Complexity",
        TRUE ~ str_to_title(gsub("_", " ", variable))
      )
    )

  status_plot <- ggplot(status_long, aes(x = time, y = value, color = country)) +
    geom_line(size = 1.2, alpha = 0.8) +
    facet_wrap(~variable_clean, scales = "free_y", ncol = 1) +
    scale_color_manual(values = c("Turkey" = "#E31A1C", "Germany" = "#1F78B4", "Other" = "#33A02C")) +
    theme_minimal() +
    theme(
      legend.position = "bottom",
      strip.text = element_text(size = 10, face = "bold"),
      axis.text = element_text(size = 9),
      legend.title = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    labs(x = "Time", y = "Value", title = "Status Variables Over Time") +
    xlim(0, max(status_data$time)) +
    geom_point(data = status_long %>% filter(time == current_time),
               aes(x = time, y = value), size = 2)

  return(status_plot)
}
#current_status <- status_data %>% filter(time == time_point)

# Create the map
map_plot <- ggplot() +
  geom_sf(data = turkey, fill = "white", color = "gray70", size = 0.3) +
  geom_point(data = current_data,
             aes(x = lon, y = lat, color = migration_stage),
             size = 0.8, alpha = 0.7) +
  scale_color_manual(values = stage_colors, name = "Migration Stage") +
  theme_void() +
  theme(
    legend.position = "bottom",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    plot.title = element_text(size = 12, hjust = 0.5)
  ) +
  labs(title = paste("Migration Stages in Turkey - Time:", time_point)) +
  coord_sf(xlim = c(25, 46), ylim = c(35, 43))

return(map_plot)
}

# Create status variables plot function
create_status_plot <- function(data, current_time) {
  status_subset <- data %>% filter(time <= current_time)

  status_long <- status_subset %>%
    select(time, economic_conditions_turkey, economic_conditions_germany,
           political_instability_turkey, policy_complexity_germany) %>%
    pivot_longer(cols = -time, names_to = "variable", values_to = "value") %>%
    mutate(
      country = ifelse(grepl("turkey", variable), "Turkey", "Germany"),
      variable_clean = case_when(
        grepl("economic", variable) ~ "Economic Conditions",
        grepl("political", variable) ~ "Political Instability",
        grepl("policy", variable) ~ "Policy Complexity"
      )
    )

  status_plot <- ggplot(status_long, aes(x = time, y = value, color = country)) +
    geom_line(size = 1) +
    facet_wrap(~variable_clean, scales = "free_y", ncol = 1) +
    scale_color_manual(values = c("Turkey" = "#E31A1C", "Germany" = "#1F78B4")) +
    theme_minimal() +
    theme(
      legend.position = "bottom",
      strip.text = element_text(size = 9),
      axis.text = element_text(size = 8),
      legend.title = element_blank()
    ) +
    labs(x = "Time", y = "Value", title = "Status Variables Over Time") +
    xlim(0, 84) +
    ylim(0, 1)

  return(status_plot)
}

# Create stage distribution plot with agent counts
create_stage_distribution <- function(data, time_point) {
  stage_counts <- data %>%
    filter(time == time_point) %>%
    count(migration_stage) %>%
    mutate(
      percentage = n / sum(n) * 100,
      migration_stage = factor(migration_stage, levels = migration_stages)
    )

  dist_plot <- ggplot(stage_counts, aes(x = migration_stage, y = percentage, fill = migration_stage)) +
    geom_col(alpha = 0.8, color = "white", size = 0.5) +
    geom_text(aes(label = paste0(round(percentage, 1), "%\n(", n, ")")),
              vjust = -0.5, size = 3, fontface = "bold") +
    scale_fill_manual(values = stage_colors) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
      legend.position = "none",
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = element_text(size = 11, face = "bold", hjust = 0.5)
    ) +
    labs(x = "Migration Stage", y = "Percentage (%)",
         title = "Stage Distribution") +
    ylim(0, max(100, max(stage_counts$percentage) * 1.1))

  return(dist_plot)
}

# Create provincial migration intensity plot
create_province_intensity <- function(data, time_point) {
  province_summary <- data %>%
    filter(time == time_point) %>%
    group_by(province, province_name) %>%
    summarise(
      total_agents = n(),
      considering_migration = sum(!migration_stage %in% "never_consider"),
      migration_rate = considering_migration / total_agents * 100,
      .groups = "drop"
    ) %>%
    arrange(desc(migration_rate)) %>%
    slice_head(n = 10)

  intensity_plot <- ggplot(province_summary,
                           aes(x = reorder(province_name, migration_rate),
                               y = migration_rate)) +
    geom_col(fill = "#2E8B57", alpha = 0.8, color = "white") +
    geom_text(aes(label = paste0(round(migration_rate, 1), "%")),
              hjust = -0.1, size = 3, fontface = "bold") +
    coord_flip() +
    theme_minimal() +
    theme(
      axis.text = element_text(size = 9),
      plot.title = element_text(size = 11, face = "bold", hjust = 0.5),
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    labs(x = "Province", y = "Migration Consideration Rate (%)",
         title = "Top 10 Provinces by Migration Rate") +
    xlim(0, max(100, max(province_summary$migration_rate) * 1.1))

  return(intensity_plot)
}

# Create combined plot for each time step
create_combined_plot <- function(time_point) {
  map_p <- create_map_plot(migration_map_data, time_point)
  status_p <- create_status_plot(status_data, time_point)
  dist_p <- create_stage_distribution(migration_map_data, time_point)
  intensity_p <- create_province_intensity(migration_map_data, time_point)

  # Combine plots using patchwork
  right_panel <- (status_p / dist_p / intensity_p) +
    plot_layout(heights = c(3, 1, 1))

  combined <- map_p + right_panel +
    plot_layout(widths = c(2, 1))

  return(combined)
}

# =============================================================================
# CREATE THE MAIN ANIMATION
# =============================================================================

# Create animation data
animation_data <- migration_map_data %>%
  mutate(time_label = paste("Time:", time))

# Create the main animated plot focusing on the map
main_animated_plot <- ggplot() +
  geom_sf(data = turkey, fill = "white", color = "gray70", size = 0.3) +
  geom_point(data = animation_data,
             aes(x = lon, y = lat, color = migration_stage),
             size = 1.5, alpha = 0.8) +
  scale_color_manual(values = stage_colors, name = "Migration Stage") +
  theme_void() +
  theme(
    legend.position = "bottom",
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 12),
    plot.title = element_text(size = 16, hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    legend.key.size = unit(1, "cm")
  ) +
  labs(
    title = "Migration Stages Across Turkey Over Time",
    subtitle = "Time Step: {closest_state}",
    caption = "Each point represents an agent colored by their migration stage"
  ) +
  coord_sf(xlim = c(25, 46), ylim = c(35, 43)) +
  guides(color = guide_legend(override.aes = list(size = 4, alpha = 1), nrow = 1)) +
  transition_states(time, transition_length = 1, state_length = 2) +
  ease_aes('linear')

# Create the animation
cat("Creating main animation...\n")
main_anim <- animate(main_animated_plot,
                     width = 1400, height = 900,
                     fps = 10, duration = 15,
                     renderer = gifski_renderer("turkey_migration_main.gif"))

# Create status variables animation
status_anim_data <- status_data %>%
  select(time, economic_conditions_turkey, economic_conditions_germany,
         political_instability_turkey, policy_complexity_germany) %>%
  pivot_longer(cols = -time, names_to = "variable", values_to = "value") %>%
  mutate(
    country = ifelse(grepl("turkey", variable), "Turkey", "Germany"),
    variable_clean = case_when(
      grepl("economic", variable) ~ "Economic Conditions",
      grepl("political", variable) ~ "Political Instability",
      grepl("policy", variable) ~ "Policy Complexity"
    )
  )

status_animated_plot <- ggplot(status_anim_data, aes(x = time, y = value, color = country)) +
  geom_line(size = 1.5, alpha = 0.8) +
  geom_point(size = 2) +
  facet_wrap(~variable_clean, scales = "free_y", ncol = 1) +
  scale_color_manual(values = c("Turkey" = "#E31A1C", "Germany" = "#1F78B4")) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    strip.text = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.title = element_blank(),
    legend.text = element_text(size = 12),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5)
  ) +
  labs(x = "Time", y = "Value",
       title = "Status Variables Over Time",
       subtitle = "Time: {frame_time}") +
  transition_time(time) +
  ease_aes('linear')

cat("Creating status variables animation...\n")
status_anim <- animate(status_animated_plot,
                       width = 800, height = 600,
                       fps = 10, duration = 15,
                       renderer = gifski_renderer("turkey_status_variables.gif"))

# =============================================================================
# CREATE STATIC PLOTS FOR KEY TIME POINTS
# =============================================================================

cat("Creating static plots for key time points...\n")
key_times <- c(0, 20, 40, 60, max(migration_data$time))
for(t in key_times) {
  plot <- create_combined_plot(t)
  ggsave(paste0("turkey_migration_time_", sprintf("%02d", t), ".png"), plot,
         width = 20, height = 12, dpi = 300)
  cat("Created plot for time", t, "\n")
}

# =============================================================================
# SUMMARY STATISTICS AND ANALYSIS
# =============================================================================

cat("\n=== MIGRATION ANALYSIS SUMMARY ===\n")
cat("Animation created successfully!\n")
cat("Files generated:\n")
cat("- turkey_migration_main.gif (main map animation)\n")
cat("- turkey_status_variables.gif (status variables animation)\n")
cat("- turkey_migration_time_XX.png (static plots for key time points)\n\n")

cat("Dataset Summary:\n")
cat("- Total time steps:", max(migration_data$time), "\n")
cat("- Number of agents:", length(unique(migration_data$id)), "\n")
cat("- Number of provinces:", length(unique(migration_data$province)), "\n")
cat("- Migration stages:", paste(migration_stages, collapse = ", "), "\n\n")

# Migration progression analysis
progression_summary <- migration_data %>%
  group_by(time, migration_stage) %>%
  summarise(count = n(), .groups = "drop") %>%
  group_by(time) %>%
  mutate(percentage = count / sum(count) * 100) %>%
  ungroup()

cat("Migration Stage Evolution:\n")
initial_dist <- progression_summary %>%
  filter(time == 0) %>%
  select(migration_stage, percentage)
final_dist <- progression_summary %>%
  filter(time == max(time)) %>%
  select(migration_stage, percentage)

comparison <- merge(initial_dist, final_dist, by = "migration_stage", suffixes = c("_initial", "_final"))
print(comparison)

# Display the main animation
main_anim
