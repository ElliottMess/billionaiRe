% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_asserts.R
\name{assert_arg_exists}
\alias{assert_arg_exists}
\title{Assert that argument exists}
\usage{
assert_arg_exists(
  x,
  error_template = "The \%s argument is required and cannot be NA or NULL"
)
}
\arguments{
\item{x}{argument to check}

\item{error_template}{A template for generating the error message. Used as the
input to an \code{sprintf()} call. Must include \%s, which corresponds to the input x.}
}
\description{
Check that a given argument exists and is not NA or NULL. Useful for functions
where an argument is required for the rest of the code to work.
}
