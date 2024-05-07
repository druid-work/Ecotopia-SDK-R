
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Ecotopia-SDK-R

<!-- badges: start -->
<!-- badges: end -->

The goal of Ecotopia-SDK-R is to provide a set of tools for working with
the Ecotopia dataset.

## Installation

You can install the development version of Ecotopia-SDK-R like so:

``` r
install.packages("devtools")
devtools::install_github("yinear/Ecotopia-SDK-R")
```

## Example

First, create a config file named `ecotppia.yml` in the working
directory. The config file should contain the following information:

``` yml
domain: "domain_name" # e.g. "www.ecotopiago.com"
username: "username"
password: "password"
token: "token" # optional, if you have a token, you can use it instead of username and password
```

You can get token by running the following code:

``` r
library(Ecotopia-SDK-R)
token <- ecotopia_user_token()
```

Device list can be downloaded by running the following code:

``` r
library(Ecotopia-SDK-R)
device_list <- ecotopia_data_devices(max_devices = 2)
```

max_devices is the maximum number of devices to download. Default is
1000.

You can download 4 types of data: `ACC`, `ENV`, `GPS`, and `ODBA`.

You can download the data for a all device by running the following
code:

``` r
library(Ecotopia-SDK-R)
data1 <- ecotopia_data_devices_acc(show_progress = "OFF")
data2 <- ecotopia_data_devices_env(show_progress = "SIMPLE")
data3 <- ecotopia_data_devices_gps(show_progress = "FULL")
data4 <- ecotopia_data_devices_odba(show_progress = "OFF")
```

show_progress can be “OFF”, “SIMPLE”, or “FULL”. Default is “OFF”.

You can also download the data for a specific device by running the
following code:

``` r
library(Ecotopia-SDK-R)
device_ids <- c("device_id1", "device_id2", "device_id3")
data1 <- ecotopia_data_device_acc(device_ids = device_ids, show_progress = "OFF")
data2 <- ecotopia_data_device_env(device_ids = device_ids, show_progress = "SIMPLE")
data3 <- ecotopia_data_device_gps(device_ids = device_ids, show_progress = "FULL")
data4 <- ecotopia_data_device_odba(device_ids = device_ids, show_progress = "OFF")
```

You can get device ids by `ecotopia_data_devices()`.
