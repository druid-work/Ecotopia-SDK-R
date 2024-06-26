% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ecotopia_data_all_acc.R
\name{ecotopia_data_all_acc}
\alias{ecotopia_data_all_acc}
\title{Get all ACC data from Ecotopia API}
\usage{
ecotopia_data_all_acc(show_progress = "OFF", start_time = NULL)
}
\arguments{
\item{show_progress}{Show download progress log
show_progress can be "OFF", "SIMPLE" or "FULL"}

\item{start_time}{Start time of the data to be downloaded}
}
\value{
List of all devices contains a list of vectors with their ACC data.
}
\description{
Get all ACC data from Ecotopia API
}
\examples{
ecotopia_data_all_acc()
}
