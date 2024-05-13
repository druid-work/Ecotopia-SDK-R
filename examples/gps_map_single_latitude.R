# Draw GPS data on the map
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)

now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(495, unit = "days")

gps_list <- ecotopia_data_devices_gps(
  device_uuids = c("5d2fe382879cb586138e356d"),
  show_progress = "FULL",
  start_time = start_time
)
# Draw Map
world <- ne_countries(scale = "medium", returnclass = "sf")
gps <- gps_list[["5d2fe382879cb586138e356d"]]
gps <- gps[gps$used_star > 3, ]
gps$latitude <- as.numeric(gps$latitude)
gps$timestamp <- as.Date(paste0(substr(gps$timestamp, 1, 7), "-01"))
plot <- ggplot(gps, aes(x = timestamp, y = latitude)) +
  geom_point(color = "blue") +
  labs(title = "Latitude And Month",
       x = "Month", y = "Latitude")
ggsave("examples/gps_map_single_latitude.png", plot)