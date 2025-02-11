% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scenarios_dip_recover.R
\name{scenario_dip_recover_iso3}
\alias{scenario_dip_recover_iso3}
\title{Scenario dip and recover to specific iso3}
\usage{
scenario_dip_recover_iso3(
  df,
  iso3,
  year = "year",
  ind = "ind",
  iso3_col = "iso3",
  start_year = 2018,
  dip_year = 2020,
  recovery_year = 2021,
  progressive_recovery = FALSE,
  end_year = 2025,
  value = "value",
  scenario = "scenario",
  scenario_name = "dip_recover",
  type_col = "type",
  trim = TRUE,
  small_is_best = FALSE,
  keep_better_values = FALSE,
  upper_limit = 100,
  lower_limit = 0,
  trim_years = TRUE,
  ind_ids = billion_ind_codes("all"),
  default_scenario = "default"
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{year}{Column name of column with years.}

\item{ind}{Column name of column with indicator names.}

\item{iso3_col}{(character) name of column with the ISO3 country codes}

\item{start_year}{Start year for scenario, defaults to 2018.}

\item{dip_year}{(integer) year where the dip appends}

\item{recovery_year}{(integer) year from which the AROC will be applied}

\item{progressive_recovery}{(logical) TRUE if the recovery after dip
should be progressive.}

\item{end_year}{End year for scenario, defaults to 2025}

\item{value}{Column name of column with indicator values. This column will be
used to return the results.}

\item{scenario}{name of scenario column to be created}

\item{scenario_name}{name of scenario}

\item{type_col}{Column name of column to store type.}

\item{trim}{logical to indicate if the data should be trimmed between
\code{upper_limit} and \code{lower_limit}.}

\item{small_is_best}{Logical to identify if a lower value is better than a higher
one (e.g. lower obesity in a positive public health outcome, so obesity rate
should have small_is_best = TRUE).}

\item{keep_better_values}{logical to indicate if "better" values should be
kept from \code{value} if they are present. Follows the direction set in
\code{small_is_best}.  For instance, if small_is_best is TRUE, then \code{value} lower
than \code{col} will be kept.}

\item{upper_limit}{upper limit at which the indicator should be caped.}

\item{lower_limit}{lower_limit limit at which the indicator should be caped.}

\item{trim_years}{logical to indicate if years before \code{start_year} and after
\code{end_year} should be removed}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}

\item{default_scenario}{name of the default scenario.}
}
\value{
a data frame with scenario values in \code{value} with a \code{scenario} column.
}
\description{
Applies \code{scenario_dip_recover()} to a specific iso3.
}
\details{
In details, the AROC  between the \code{start_year}  and \code{dip_year} - 1 is
applied to the last reported value to \code{recovery_year} onward. If there are
missing values between \code{dip_year} and \code{recovery_year}, the last value from
\code{dip_year} is carried forward. This applies only to countries where the
indicator value for \code{dip_year} is \code{reported} or \code{estimated}. Otherwise,
the value is carried with \code{scenario_bau}.

If \code{progressive_recovery} is TRUE, then the recovery is
spread between the years between \code{recovery_year} and \code{end_year}. For
instance, if \code{recovery_year} is 2021 and \code{end_year} 2025, then 2021 will have 0\%
of AROC, 2022 25\%, 2023 50\%, 2024 75\%, and 2025 100\%.
}
