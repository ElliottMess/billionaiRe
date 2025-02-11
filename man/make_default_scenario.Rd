% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recycle_data.R
\name{make_default_scenario}
\alias{make_default_scenario}
\title{Make a default scenario}
\usage{
make_default_scenario(
  df,
  scenario = "default",
  billion = c("all", "hep", "hpop", "uhc"),
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

\item{scenario}{name of scenario to recycle for. Defaults to "default".}

\item{billion}{name of billion to recycle data for. Can be any of "hep",
"hpop", "uhc", or "all". Defaults to "all".}

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
\code{make_default_scenario} wraps around \code{recycle_data_scenario_single} to create
a default scenario based on the parameters passed to the function.
}
\details{
For more details on the HPOP Billion calculation process and how this function
ties in with the rest, see the vignette:

\href{../doc/hpop.html}{\code{vignette("hpop", package = "billionaiRe")}}
}
