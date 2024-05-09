# Bar chart of inner pressure
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
data$inner_pressure <- as.numeric(data$inner_pressure)
# Bar chart of inner pressure
plot <- ggplot(data, aes(x = inner_pressure)) +
  geom_bar(fill = "orange", color = "black", position = "dodge") +
  labs(title = "Inner Pressure Distribution",
       x = "Inner Pressure", y = "Frequency")
ggsave("examples/env_pressure_bar.png", plot)