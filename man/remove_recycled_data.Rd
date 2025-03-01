% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/remove_recycled_data.R
\name{remove_recycled_data}
\alias{remove_recycled_data}
\title{Remove recycled values from \code{df}}
\usage{
remove_recycled_data(
  df,
  ind = "ind",
  recycled = "recycled",
  scenario = "scenario",
  scenario_reported_estimated = "none",
  scenario_tp = "tp"
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific country, year, and indicator.}

\item{ind}{Column name of column with indicator names.}

\item{recycled}{name of boolean recycle column with whether the data is
recycled or not. Default to "recycle".}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{scenario_reported_estimated}{name of the reported/estimated scenario.}

\item{scenario_tp}{name of the WHO technical programs projections/imputations scenario.}
}
\value{
Data frame in long format without recycled values
}
\description{
Remove recycled values from \code{df}
}
