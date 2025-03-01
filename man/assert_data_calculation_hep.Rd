% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assert_data_calculations.R
\name{assert_data_calculation_hep}
\alias{assert_data_calculation_hep}
\title{Assert presence of minimum HEP data}
\usage{
assert_data_calculation_hep(
  df,
  ind = "ind",
  year = "year",
  iso3 = "iso3",
  value = "value",
  scenario = NULL,
  start_year = 2018,
  end_year = 2025,
  ind_ids = billion_ind_codes("hep")
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{ind}{Column name of column with indicator names.}

\item{year}{Column name of column with year data.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{value}{Column name of column with indicator values.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{start_year}{Base year for contribution calculation, defaults to 2018.}

\item{end_year}{End year(s) for contribution calculation, defaults to 2019 to 2025.}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}
}
\value{
Data frame in long format.
}
\description{
\code{assert_data_calculation_hep} asserts that the minimum data required to run
HEP calculations is present. This means checking that \code{surviving_infants} is
present for all years where routine prevent indicators are present, and that
\code{espar} \code{start_year} is not NA. Otherwise, errors will be returned by
calculation functions.
}
\details{
The function returns warnings
if \code{espar} and \code{detect_respond} \code{start_year} and \code{end_year} are not present
in the data frame. Not having those values will significantly impact the
billion calculations as \code{hep_idx} will not include them at all.

Warnings are also returned if some country (and scenario if provided) have
only NAs.
}
