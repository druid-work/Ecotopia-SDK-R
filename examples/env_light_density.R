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
# Bar chart of ambient light
plot <- ggplot(data, aes(x = ambient_light)) +
  geom_density(fill = "blue", alpha = 0.5) +
  labs(title = "Ambient Light Density Distribution",
       x = "Ambient Light", y = "Density")
ggsave("examples/env_light_density.png", plot)