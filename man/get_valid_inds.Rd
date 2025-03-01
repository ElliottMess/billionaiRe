% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_whdh.R
\name{get_valid_inds}
\alias{get_valid_inds}
\title{Get correct set of indicators for WHDH operations}
\usage{
get_valid_inds(data_type, billion)
}
\arguments{
\item{data_type}{(string) The type of data to load.
\itemize{
\item \code{wrangled_data} (default): raw data that has been wrangled into a suitable
form for analysis.
\item \code{projected_data}:  data that has been fully projected to the target year but
has not yet been transformed or calculated upon.
\item \code{final_data}: the complete set of billions data with transformed values, contributions,
and all calculations available.
\item \code{ingestion_data}: raw data in its original form as received from the technical
program, GHO, or other sources. These files have not been wrangled or modified
in any way.
}}

\item{billion}{(string) One of "hep", "hpop", and "uhc".}
}
\value{
(character vector) a list of the indicators belonging to the given billion,
as used by the WHDH functions.
}
\description{
Get correct set of indicators for WHDH operations
}
