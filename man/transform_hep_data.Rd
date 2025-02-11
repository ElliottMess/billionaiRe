% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transform_hep.R
\name{transform_hep_data}
\alias{transform_hep_data}
\title{Transform Raw Indicator Values for HEP Billion}
\usage{
transform_hep_data(
  df,
  iso3 = "iso3",
  year = "year",
  ind = "ind",
  scenario = NULL,
  value = "value",
  transform_glue = "transform_{value}",
  type_col = "type",
  source_col = "source",
  source = "WUENIC/IVB/WHO Technical Programme",
  ind_ids = billion_ind_codes("hep", include_calculated = TRUE),
  extrapolate_to = 2025,
  recycle = FALSE,
  ...
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{year}{Column name of column with year data.}

\item{ind}{Column name of column with indicator names.}

\item{scenario}{Column name of column with scenario identifiers. Useful for
calculating contributions on data in long format rather than wide format.}

\item{value}{Column name of column with indicator values.}

\item{transform_glue}{Glue expression to be passed to \code{\link[glue:glue]{glue::glue()}}. Defaults to
\code{'transform_{value}'} which will create new column names by prefixing \code{transform_}
to the original name.}

\item{type_col}{Column name of column with type data.}

\item{source_col}{Column name of column to store source information.}

\item{source}{Source to use for prevent data that is flat extrapolated
that has more than one unique value.}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}

\item{extrapolate_to}{Year to extrapolate Prevent data to, defaults to 2025}

\item{recycle}{Boolean to indicate if data should be recycled}

\item{...}{additional parameters to to pass to \code{recycle_data}}
}
\value{
Data frame in long format.
}
\description{
\code{transform_hep_data()} applies transformations on HEP Billion indicators so
that transformed indicator values can be used within Billions calculations.
Details on the specific transformations applied can be found within the
Billions methods report.
}
\details{
Currently, this function only changes Prevent campaign data by calculating
the total sum of campaigns for each year for use in Prevent calculations.
For more details on the HEP Billion calculation process and how this function
ties in with the rest, see the vignette:

\href{../doc/hpop.html}{\code{vignette("hep", package = "billionaiRe")}}
}
