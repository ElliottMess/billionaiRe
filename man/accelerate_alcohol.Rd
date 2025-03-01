% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accelerate_hpop.R
\name{accelerate_alcohol}
\alias{accelerate_alcohol}
\title{Accelerate alcohol}
\usage{
accelerate_alcohol(
  df,
  ind_ids = billion_ind_codes("hpop"),
  end_year = 2025,
  scenario = "scenario",
  ind = "ind",
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

\item{end_year}{End year(s) for contribution calculation, defaults to 2019 to 2025.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{ind}{Column name of column with indicator names.}

\item{...}{additional parameters to be passed to scenario function}
}
\value{
data frame with acceleration scenario binded to \code{df}. \code{scenario} is
set to \code{acceleration}
}
\description{
Accelerate alcohol by picking the best results between business as usual,
halt downwards trend from 2018, and -10 percent from 2010.
}
\details{
Runs:
\itemize{
\item \code{scenario_halt_rise(df, baseline_year = 2018, small_is_best = TRUE,...)},
\item \code{scenario_bau(df, small_is_best = TRUE,...)}, and
\item \code{scenario_percent_baseline(df, percent_change = -10, baseline_year = 2010, small_is_best = TRUE, ...)}
}

Then picks the best result between the three scenarios.
}
