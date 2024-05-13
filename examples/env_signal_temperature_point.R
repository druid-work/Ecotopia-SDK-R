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
data$signal_strength <- as.numeric(data$signal_strength)
data$inner_temperature <- as.numeric(data$inner_temperature)
# Bar chart of inner temperature
plot <- ggplot(data, aes(x = signal_strength, y = inner_temperature)) +
  geom_point(color = "green") +
  geom_smooth(method = "loess", se = FALSE) +
  labs(title = "Signal Strength And Inner Temperature",
       x = "Signal Strength", y = "Inner Temperature")
ggsave("examples/env_signal_temperature_point.png", plot)