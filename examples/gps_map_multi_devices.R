# Draw GPS data on the map
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)
theme_set(theme_bw())
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
library("dplyr")

now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(365, unit = "days")

gps_list <- ecotopia_data_devices_gps(
  device_uuids = c("5d395935879cb58613e59e76",
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


gps_df <- lapply(gps_list, function(df) {
  if (nrow(df) == 0) {
    return(NULL)
  }
  df <- select(df, device_id, used_star, longitude, latitude)
  return(df)
})
gps <- do.call(rbind, gps_df)

gps <- gps[gps$used_star > 3, ]
gps$longitude <- as.numeric(gps$longitude)
gps$latitude <- as.numeric(gps$latitude)
gps$Device_Id <- sapply(gps$device_id, function(x) {
  substr(x, nchar(x) - 3, nchar(x))
})
map <- map + geom_point(data = gps, aes(x = longitude, y = latitude,
                                        color = Device_Id), size = 2)
ggsave("examples/gps_map_multi_devices.png", map)