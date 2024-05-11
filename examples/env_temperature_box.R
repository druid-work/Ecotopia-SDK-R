# Bar chart of inner temperature
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
data$inner_temperature <- round(data$inner_temperature, 0)
# Bar chart of inner temperature
plot <- ggplot(data, aes(x = inner_temperature)) +
  geom_boxplot(color = "s") +
  labs(title = "Inner Temperature Box Plot",
       x = "Inner Temperature")
ggsave("examples/env_temperature_box.png", plot)