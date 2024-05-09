# ODBA box plot
# Import EcotopiaR
library(EcotopiaR)
library(ggplot2)
# Query data in 2 days
now <- Sys.time()
attr(now, "tzone") <- "UTC"
start_time <- now - as.difftime(2, unit = "days")
# Request data by EcotopiaR
data_list <- ecotopia_data_devices_odba(
  # The device uuid can be viewed in the list of devices
  # obtained through ecotopia_data_devices.
  device_uuids = c("5d395935879cb58613e59e76"),
  show_progress = "FULL",
  start_time = start_time
)
data <- data_list[["5d395935879cb58613e59e76"]]
data <- data[order(data$timestamp), ]
data$timestamp_order <- seq_len(nrow(data))
# Draw
plot <- ggplot(data, aes(x = timestamp_order, y = odba)) +
  geom_boxplot(fill = "skyblue", color = "blue") +
  labs(title = "ODBA Box", x = "Time", y = "ODBA")
ggsave("examples/odba_box.png", plot)