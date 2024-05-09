# Bar chart of ambient light
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)
now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(10, unit = "days")
data_list <- ecotopia_data_devices_env(
  # The device uuid can be viewed in the list of devices
  # obtained through ecotopia_data_devices.
  device_uuids = c("5d395935879cb58613e59e76"),
  show_progress = "FULL",
  start_time = start_time
)
data <- data_list[["5d395935879cb58613e59e76"]]
data$ambient_light <- as.numeric(data$ambient_light)
data$ambient_light <- data$ambient_light %/% 1000 * 1000

# Bar chart of ambient light
plot <- ggplot(data, aes(x = ambient_light)) +
  geom_bar(fill = "orange", color = "black", position = "dodge") +
  labs(title = "Ambient Light Distribution",
       x = "Ambient Light", y = "Frequency")
ggsave("examples/env_light_bar.png", plot)