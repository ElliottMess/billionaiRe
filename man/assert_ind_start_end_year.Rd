% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_asserts.R
\name{assert_ind_start_end_year}
\alias{assert_ind_start_end_year}
\title{Asserts indicators have values at start and end year}
\usage{
assert_ind_start_end_year(
  df,
  iso3 = "iso3",
  year = "year",
  value = "value",
  start_year = 2018,
  end_year = 2020,
  ind = "ind",
  ind_ids,
  scenario = "scenario"
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{year}{Column name of column with year data.}

\item{value}{Column name of column with indicator values.}

\item{start_year}{Base year for contribution calculation, defaults to 2018.}

\item{end_year}{End year(s) for contribution calculation, defaults to 2019 to 2025.}

\item{ind}{Column name of column with indicator names.}

\item{ind_ids}{named list of indicators to be checked for values. Follows
similar structure as \code{billion_ind_codes} indicator lists.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}
}
\description{
Asserts that there are values at the start and end year for all indicators
provided in ind_ids, by iso3 (and scenarios if provided).
}
