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
start_time <- now - as.difftime(365, unit = "days")

gps_list <- ecotopia_data_devices_gps(
  device_uuids = c("59c61cd550bd08c3ef52e004"),
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
  coord_sf(xlim = c(18.8, 19.6), ylim = c(49.9, 50.2), expand = FALSE) +
  ggtitle("GPS Tracking")
colors <- c("red", "blue", "green", "orange", "purple")
for (i in seq_along(gps_list)) {
  gps <- gps_list[[i]]
  gps <- gps[gps$used_star > 3, ]
  gps$longitude <- round(as.numeric(gps$longitude), 2)
  gps$latitude <- round(as.numeric(gps$latitude), 2)
  map <- map + geom_count(data = gps, aes(x = longitude, y = latitude),
                          color = colors[i])
    # geom_path(data = gps, aes(x = longitude, y = latitude))
}
ggsave("examples/gps_map_single_home.png", map)