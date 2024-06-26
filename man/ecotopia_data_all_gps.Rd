% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ecotopia_data_all_gps.R
\name{ecotopia_data_all_gps}
\alias{ecotopia_data_all_gps}
\title{Get all GPS data from Ecotopia API}
\usage{
ecotopia_data_all_gps(show_progress = "OFF", start_time = NULL)
}
\arguments{
\item{show_progress}{Show download progress log
show_progress can be "OFF", "SIMPLE" or "FULL"}

\item{start_time}{Start time of the data to be downloaded
show_progress can be "OFF", "SIMPLE" or "FULL"}
}
\value{
List of all devices contain list of vectors with their GPS data.
}
\description{
Get all GPS data from Ecotopia API
}
\examples{
ecotopia_data_all_gps(show_progress = "SIMPLE")
}
