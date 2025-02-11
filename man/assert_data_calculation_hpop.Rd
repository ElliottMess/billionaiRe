% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assert_data_calculations.R
\name{assert_data_calculation_hpop}
\alias{assert_data_calculation_hpop}
\title{Assert presence of minimum HPOP data}
\usage{
assert_data_calculation_hpop(
  df,
  iso3 = "iso3",
  value = "value",
  scenario = NULL
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{value}{Column name of column with indicator values.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}
}
\value{
Data frame in long format.
}
\description{
Assert that the minimum data required to run HPOP calculations is
present.
}
\details{
The function returns warnings
if \code{start_year} and \code{end_year} are not present in \code{year} column
in the data frame. Not having those values will significantly impact the
billion calculations as \code{hpop_healthier} will return 0.

Warnings are also returned if some country (and scenario if provided) have
only NAs.
}
