% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accelerate_hpop.R
\name{accelerate_hpop_tobacco}
\alias{accelerate_hpop_tobacco}
\title{Accelerate hpop_tobacco}
\usage{
accelerate_hpop_tobacco(
  df,
  ind_ids = billion_ind_codes("hpop"),
  ind = "ind",
  scenario = "scenario",
  iso3 = "iso3",
  value = "value",
  year = "year",
  start_year = 2018,
  end_year = 2025,
  type_col = "type",
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

\item{ind}{Column name of column with indicator names.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{value}{Column name of column with indicator values.}

\item{year}{Column name of column with years.}

\item{start_year}{Base year for contribution calculation, defaults to 2018.}

\item{end_year}{End year(s) for contribution calculation, defaults to 2019 to 2025.}

\item{type_col}{Column name of column with type data.}

\item{...}{additional parameters to be passed to scenario function}
}
\value{
data frame with acceleration scenario binded to \code{df}. \code{scenario} is
set to \code{acceleration}
}
\description{
Accelerate hpop_tobacco by picking the best value between business as usual,
halt the rise in 2018, or a custom version of scenario_percent_baseline. The
custom \code{scenario_percent_baseline} is taking similar parameters to
\code{scenario_percent_baseline}'s \code{percent_change} = -30, \code{baseline_year} = 2010,
but values are added to the \code{start_year} value, rather than the \code{baseline_year}
values.
}
\details{
Runs:
\itemize{
\item custom scenario_percent_baseline (see above).
\item \code{scenario_bau(df, small_is_best = TRUE,...)}
\item \code{scenario_halt_rise(df, baseline_year= 2018, small_is_best = TRUE,...)}
}

Then picks the best result between the three scenarios.
}
