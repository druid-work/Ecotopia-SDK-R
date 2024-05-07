test_that("ecotopia_data_devices() Get User's Devices Table", {
  expect_no_error(ecotopia_data_devices(max_devices = 2))
})