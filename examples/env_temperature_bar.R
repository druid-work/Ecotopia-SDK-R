# Bar chart of inner temperature
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
data$inner_temperature <- as.numeric(data$inner_temperature)
data$inner_temperature <- round(data$inner_temperature, 0)
# Bar chart of inner temperature
plot <- ggplot(data, aes(x = inner_temperature)) +
  geom_bar(fill = "orange", color = "black", position = "dodge") +
  labs(title = "Inner Temperature Distribution",
       x = "Inner Temperature", y = "Frequency")
ggsave("examples/env_temperature_bar.png", plot)