# Chart of inner temperature and inner pressure
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)
now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(100, unit = "days")
data_list <- ecotopia_data_devices_env(
  # The device uuid can be viewed in the list of devices
  # obtained through ecotopia_data_devices.
  device_uuids = c("5d395935879cb58613e59e76"),
  show_progress = "FULL",
  start_time = start_time
)
data <- data_list[["5d395935879cb58613e59e76"]]
data$inner_temperature <- as.numeric(data$inner_temperature)
data$ambient_light <- as.numeric(data$ambient_light)
data$inner_temperature <- round(data$inner_temperature, 0)
data$ambient_light <- data$ambient_light %/% 2000 * 2000
# Bar chart of inner temperature
plot <- ggplot(data, aes(x = inner_temperature, y = ambient_light)) +
  geom_count(col = "tomato3", show.legend = FALSE) +
  labs(title = "Inner Temperature And Ambient Light",
       x = "Inner Temperature", y = "AmbientLight")
ggsave("examples/env_temperature_light_bar.png", plot)