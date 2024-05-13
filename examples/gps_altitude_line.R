# Draw GPS data on the map
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)
theme_set(theme_bw())
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")

now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(10, unit = "days")

gps_list <- ecotopia_data_devices_gps(
  device_uuids = c("5d2fe382879cb586138e356d"),
  show_progress = "FULL",
  start_time = start_time
)
plot <- ggplot(data = gps)
colors <- c("red", "blue", "green", "orange", "purple")
for (i in seq_along(gps_list)) {
  gps <- gps_list[[i]]
  gps <- gps[gps$used_star > 3, ]
  gps$altitude <- as.numeric(gps$altitude)
  gps$geoid_altitude <- as.numeric(gps$geoid_altitude)
  gps$timestamp <- as.POSIXct(gsub("Z", "", gsub("T", " ", gps$timestamp)))
  plot <- plot +
    geom_line(aes(x = timestamp, y = altitude, color = "Altitude")) +
    geom_line(aes(x = timestamp, y = geoid_altitude, color = "Geoid Altitude")) +
    labs(title = "Altitude vs. Geoid Altitude", x = "Timestamp", y = "Altitude") +
    scale_color_manual(values = c("Altitude" = "blue", "Geoid Altitude" = "red"))
}
ggsave("examples/gps_altitude_line.png", plot)