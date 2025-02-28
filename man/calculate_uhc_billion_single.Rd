% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_uhc_billion.R
\name{calculate_uhc_billion_single}
\alias{calculate_uhc_billion_single}
\title{Calculate UHC Billion for one set of columns}
\usage{
calculate_uhc_billion_single(
  df,
  year,
  iso3,
  ind,
  transform_value,
  value,
  scenario,
  source_col,
  source,
  type_col,
  projected_year,
  ind_ids
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{year}{Column name of column with years.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{ind}{Column name of column with indicator names.}

\item{transform_value}{Column name of column(s) with transformed indicator values,
used to calculate contributions.}

\item{value}{Column name of column with indicator values.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{source_col}{Column name of column to store source information.}

\item{source}{Source to provide for calculated average service coverage and
single measure.}

\item{type_col}{Column name of column to store type.}

\item{projected_year}{Year that calculated data will be regarded as projected.
Years prior reported as estimated.}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}
}
\description{
Calculate UHC Billion for one set of columns
}
