% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sdg_uhc.R
\name{sdg_dtp3}
\alias{sdg_dtp3}
\title{Accelerate dtp3 to SDG target}
\usage{
sdg_dtp3(
  df,
  ind_ids = billion_ind_codes("uhc"),
  scenario = "scenario",
  ind = "ind",
  iso3 = "iso3",
  year = "year",
  value = "value",
  start_year = 2018,
  end_year = 2025,
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

\item{iso3}{Column name of column with country ISO3 codes.}

\item{year}{Column name of column with years.}

\item{value}{Column name of column with indicator values.}

\item{start_year}{Base year for contribution calculation, defaults to 2018.}

\item{end_year}{End year(s) for contribution calculation, defaults to 2019 to 2025.}

\item{...}{additional parameters to be passed to scenario function}
}
\value{
data frame with acceleration scenario binded to \code{df}. \code{scenario} is
set to \code{acceleration}
}
\description{
Accelerate dtp3 using a customised version of scenario_fixed_target with the
following peculiarities:
\itemize{
\item baseline_year = 2019;
\item the 2020 value is kept identical to the 2019 (baseline) value;
\item the target_year is 2030; and
\item the scenario is then a straight line to the target_value and target_year
\item the target values for each country are provided by the technical program.
}
}
