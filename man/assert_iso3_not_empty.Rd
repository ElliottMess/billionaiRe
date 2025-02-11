% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_asserts.R
\name{assert_iso3_not_empty}
\alias{assert_iso3_not_empty}
\title{Asserts that iso3 (and scenario if provided) is not only NAs}
\usage{
assert_iso3_not_empty(df, iso3 = "iso3", scenario = NULL, value = "value")
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{value}{Column name of column with indicator values.}
}
\description{
Asserts that iso3 (and scenario if provided) is not only NAs
}
