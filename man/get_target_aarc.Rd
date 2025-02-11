% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-scenarios.R
\name{get_target_aarc}
\alias{get_target_aarc}
\title{Get AARC for data frame based on a target}
\usage{
get_target_aarc(
  df,
  target_value,
  baseline_year,
  target_year,
  value = "value",
  year = "year",
  iso3 = "iso3",
  ind = "ind"
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{target_value}{value to be reached. Used when \code{aroc_type} is \code{target}.
Should be expressed as a percentage point and not a fraction of 100 (e.g. 6\%
increase = 6, and not 0.06).}

\item{baseline_year}{Year from which the scenario is measured.
Defaults to \code{start_year}}

\item{target_year}{Year by which the scenario should eventually be
achieved. Defaults to \code{end_year}}

\item{value}{Column name of column with indicator values.}

\item{year}{Column name of column with years.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{ind}{Column name of column with indicator names.}
}
\value{
dataframe with AROC (in \code{aroc} column) for every combination of
\code{iso3} and \code{ind}
}
\description{
Gets the annual average rate of change (AARC or AROC) between the
baseline year and the target year to reach the target value for every
combination of \code{iso3} and \code{ind} present in \code{df}.
}
