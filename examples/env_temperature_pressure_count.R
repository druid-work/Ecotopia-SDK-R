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
data$inner_pressure <- as.numeric(data$inner_pressure)
data$inner_temperature <- round(data$inner_temperature, 0)
data$inner_pressure <- data$inner_pressure %/% 3 * 3
# Bar chart of inner temperature

plot <- ggplot(data, aes(x = inner_temperature, y = inner_pressure)) +
  geom_count(col = "tomato3", show.legend = FALSE) +
  labs(title = "Inner Temperature And Pressure",
       x = "Inner Temperature", y = "Inner Pressure") +
  theme_set(theme_bw())
ggsave("examples/env_temperature_pressure_count.png", plot)