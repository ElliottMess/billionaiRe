% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accelerate_hep.R
\name{accelerate_measles_routine}
\alias{accelerate_measles_routine}
\title{Accelerate measles_routine}
\usage{
accelerate_measles_routine(
  df,
  ind = "ind",
  ind_ids = billion_ind_codes("hep"),
  scenario = "scenario",
  ...
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{ind}{Column name of column with indicator names.}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{...}{additional parameters to be passed to scenario function}
}
\value{
data frame with acceleration scenario binded to \code{df}. \code{scenario} is
set to \code{acceleration}
}
\description{
Accelerate measles_routine by aiming at a +20\% percent change between 2013 and 2025 using
AROC.
}
\details{
Runs:
\itemize{
\item \code{scenario_aroc(df, aroc_type = "percent_change", percent_change = 20, baseline_year = 2013, target_year = 2025, small_is_best = FALSE)}
}
}
