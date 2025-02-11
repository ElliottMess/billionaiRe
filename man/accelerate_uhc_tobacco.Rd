% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accelerate_uhc.R
\name{accelerate_uhc_tobacco}
\alias{accelerate_uhc_tobacco}
\title{Accelerate uhc_tobacco}
\usage{
accelerate_uhc_tobacco(
  df,
  ind_ids = billion_ind_codes("uhc"),
  scenario = "scenario",
  ind = "ind",
  value = "value",
  year = "year",
  iso3 = "iso3",
  type_col = "type",
  end_year = 2025,
  start_year = 2018,
  ...
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{ind}{Column name of column with indicator names.}

\item{value}{Column name of column with indicator values.}

\item{year}{Column name of column with years.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{type_col}{Column name of column to store type.}

\item{end_year}{End year(s) for contribution calculation, defaults to 2019 to 2025.}

\item{start_year}{Base year for contribution calculation, defaults to 2018.}

\item{...}{additional parameters to be passed to scenario function}
}
\value{
data frame with acceleration scenario binded to \code{df}. \code{scenario} is
set to \code{acceleration}
}
\description{
Accelerate uhc_tobacco by first dividing countries into two groups:
\itemize{
\item For countries without any routine (i.e., estimated) data, business as usual
is returned
\item For countries with routine (i.e., estimated) data, the best of business as
usual and a \strong{percent decrease of 30\% between 2010 and 2025} is returned. Both
scenarios are run on the \strong{crude tobacco usage} values, which are then converted
to their age-standardised equivalents using an approximation.
}
}
