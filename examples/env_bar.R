# Bar chart of signal strength and battery voltage
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)
library(patchwork)
now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(2, unit = "days")
data_list <- ecotopia_data_devices_env(
  # The device uuid can be viewed in the list of devices
  # obtained through ecotopia_data_devices.
  device_uuids = c("5d395935879cb58613e59e76"),
  show_progress = "FULL",
  start_time = start_time
)
data <- data_list[["5d395935879cb58613e59e76"]]
data$battery_voltage <- as.numeric(data$battery_voltage)
data$battery_voltage <- round(data$battery_voltage, 2)
# Bar chart of signal strength
plot_signal <- ggplot(data, aes(x = signal_strength)) +
  geom_bar(fill = "skyblue", color = "black", position = "dodge") +
  labs(title = "Signal Strength Distribution",
       x = "Signal Strength", y = "Frequency")
# Bar chart of battery voltage
plot_voltage <- ggplot(data, aes(x = battery_voltage)) +
  geom_bar(fill = "orange", color = "black", position = "dodge") +
  labs(title = "Battery Voltage Distribution",
       x = "Battery Voltage", y = "Frequency")
# Draw two charts on one
plot <- plot_signal + plot_voltage + plot_layout(ncol = 1)
ggsave("examples/env_bar.png", plot)