% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-scenarios.R
\name{get_aarr}
\alias{get_aarr}
\title{Get Average Annual Rate of Reduction}
\usage{
get_aarr(year, value)
}
\arguments{
\item{year}{vector of years}

\item{value}{vector of values on which the AARR will be calculated. Must be
the same length as \code{year}}
}
\value{
a numeric being the beta value representing the AARR
}
\description{
Gets the \href{https://data.unicef.org/resources/technical-note-calculate-average-annual-rate-reduction-aarr-underweight-prevalence/}{Average Annual Rate of Reduction (AARC)}
by fitting the log of value by year with a linear regression.
}
