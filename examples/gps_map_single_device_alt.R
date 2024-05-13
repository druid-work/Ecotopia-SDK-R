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
start_time <- now - as.difftime(495, unit = "days")

gps_list <- ecotopia_data_devices_gps(
  device_uuids = c("5d2fe382879cb586138e356d"),
  show_progress = "FULL",
  start_time = start_time
)
# Draw Map
world <- ne_countries(scale = "medium", returnclass = "sf")
map <- ggplot(data = world) +
  geom_sf(fill = "antiquewhite") +
  theme(panel.grid.major = element_line(color = gray(.5),
                                        linetype = "dashed", size = 0.5),
        panel.background = element_rect(fill = "aliceblue")) +
  coord_sf(xlim = c(30, 100), ylim = c(5, 70), expand = FALSE) +
  ggtitle("GPS Tracking")
for (i in seq_along(gps_list)) {
  gps <- gps_list[[i]]
  gps <- gps[gps$used_star > 3, ]
  gps$longitude <- as.numeric(gps$longitude)
  gps$latitude <- as.numeric(gps$latitude)
  gps$altitude <- as.numeric(gps$altitude)
  gps_plot <- geom_point(
    data = gps, aes(x = longitude, y = latitude, color = altitude), size = 2
  )
  map <- map + gps_plot + scale_color_gradient(low = "blue", high = "red")
}
ggsave("examples/gps_map_single_device_alt.png", map)