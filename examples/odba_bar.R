# ODBA bar plot
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)
now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(100, unit = "days")
# Request data by EcotopiaR
data_list <- ecotopia_data_devices_odba(
  # The device uuid can be viewed in the list of devices
  # obtained through ecotopia_data_devices.
  device_uuids = c("5d395935879cb58613e59e76"),
  show_progress = "FULL",
  start_time = start_time
)
data <- data_list[["5d395935879cb58613e59e76"]]
data$odba <- as.numeric(data$odba)
data$odba <- data$odba %/% 100 * 100
# Bar chart of ODBA
plot <- ggplot(data, aes(x = odba)) +
  geom_bar(fill = "orange", color = "black", position = "dodge") +
  labs(title = "ODBA Distribution",
       x = "ODBA", y = "Frequency")
ggsave("examples/odba_bar.png", plot)