% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_hpop_populations.R
\name{add_hpop_populations}
\alias{add_hpop_populations}
\title{Add Population Figures for HPOP Billion}
\usage{
add_hpop_populations(
  df,
  iso3 = "iso3",
  ind = "ind",
  population = "population",
  pop_year = 2025,
  ind_ids = billion_ind_codes("hpop")
)
}
\arguments{
\item{df}{Data frame in long format, where 1 row corresponds to a specific
country, year, and indicator.}

\item{iso3}{Column name of column with country ISO3 codes.}

\item{ind}{Column name of column with indicator names.}

\item{population}{Column name of column to create with population figures.}

\item{pop_year}{Year used to pull in HPOP populations, defaults to 2025.}

\item{ind_ids}{Named vector of indicator codes for input indicators to the Billion.
Although separate indicator codes can be used than the standard, they must
be supplied as a named vector where the names correspond to the output of
\code{billion_ind_codes()}.}
}
\value{
Data frame in long format.
}
\description{
\code{add_hpop_populations()} adds relevant populations to each HPOP Billion indicator
and country, so these can be used to calculate indicator-level contributions
to the HPOP Billion. The column specified by \code{population} will be generated and
filled with relevant populations for that country and indicator. If the column
already exists, only missing values will be replaced by the function.
}
\details{
For more details on the HPOP Billion calculation process and how this function
ties in with the rest, see the vignette:

\href{../doc/hpop.html}{\code{vignette("hpop", package = "billionaiRe")}}
}
