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
  device_uuids = list("5d395935879cb58613e59e76",
                      "60e6fc81e75c8ef261867471",
                      "5d2fe382879cb586138e356d",
                      "5b6e8ff940b2d20cbc5b2619",
                      "59c61cd550bd08c3ef52e004"),
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
  coord_sf(xlim = c(0, 75), ylim = c(5, 70), expand = FALSE) +
  ggtitle("GPS Tracking")
colors <- c("red", "blue", "green", "orange", "purple")
for (i in seq_along(gps_list)) {
  gps <- gps_list[[i]]
  gps <- gps[gps$used_star > 3, ]
  gps$longitude <- as.numeric(gps$longitude)
  gps$latitude <- as.numeric(gps$latitude)
  gps_plot <- geom_point(data = gps, aes(x = longitude, y = latitude),
                         color = colors[i], size = 2)
  map <- map + gps_plot
}
ggsave("examples/gps_map.png", map)