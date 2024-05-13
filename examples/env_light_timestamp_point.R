# Bar chart of ambient light
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
data$ambient_light <- as.numeric(data$ambient_light)
data$timestamp <- as.numeric(
  format(
    as.POSIXct(gsub("Z", "", gsub("T", " ", data$timestamp))), "%H%M%S"
  )
)
# Bar chart of ambient light
plot <- ggplot(data, aes(x = timestamp, y = ambient_light)) +
  geom_point(color = "green") +
  labs(title = "Ambient Light Intensity by Time",
       x = "Time", y = "Ambient Light Intensity")
ggsave("examples/env_light_timestamp_point.png", plot)