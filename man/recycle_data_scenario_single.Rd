% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recycle_data.R
\name{recycle_data_scenario_single}
\alias{recycle_data_scenario_single}
\title{Recycle data between scenarios for a single scenario}
\usage{
recycle_data_scenario_single(
  df,
  scenario,
  billion = c("hep", "hpop", "uhc"),
  iso3 = "iso3",
  ind = "ind",
  value = "value",
  year = "year",
  type = "type",
  start_year = 2018,
  end_year = 2025,
  scenario_col = "scenario",
  default_scenario = "default",
  scenario_reported_estimated = "none",
  scenario_tp = "tp",
  include_projection = TRUE,
  recycle_campaigns = TRUE,
  ind_ids = NULL,
  trim_years = FALSE
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{scenario}{name of scenario to recycle for.}

\item{billion}{name of billion to recycle data for.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{ind}{Column name of column with indicator names.}

\item{value}{Column name of column with indicator values.}

\item{year}{Column name of column with years.}

\item{type}{Column name of column with types}

\item{start_year}{Base year for contribution calculation, defaults to 2018.}

\item{end_year}{End year(s) for contribution calculation, defaults to 2019 to 2025.}

\item{scenario_col}{Column name of column with scenario identifiers.}

\item{default_scenario}{name of the default scenario.}

\item{scenario_reported_estimated}{name of the reported/estimated scenario.}

\item{scenario_tp}{name of the WHO technical programs projections/imputations scenario.}

\item{include_projection}{Boolean to include or not projections in recycling}

\item{recycle_campaigns}{Boolean to include or not campaigns in recycling}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}

\item{trim_years}{logical to indicate if years before \code{start_year} and after
\code{end_year} should be removed}
}
\value{
Data frame in long format.
}
\description{
\code{recycle_data_scenario_single } reuses values present in the specified
scenarios in \code{default_scenario}, \code{scenario_reported_estimated}, and
\code{scenario_tp} for the specified scenarios.
}
\details{
To do so, it looks at:
\enumerate{
\item values in \code{default_scenario} but not in the scenario specified
\item values in \code{scenario_reported_estimated} but not in the scenario specified
or \code{scenario_tp}
\item values in \code{scenario_tp} but not in the scenario specified,
\code{scenario_reported_estimated} or \code{scenario_tp}
}

For more information see:

\code{vignette("scenarios", package = "billionaiRe")}
}
