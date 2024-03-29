% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse_party.R
\name{mob_wrapper}
\alias{mob_wrapper}
\title{mob_wrapper}
\usage{
mob_wrapper(
  response,
  x = NULL,
  z = NULL,
  covariates = NULL,
  tree_builder_parameters = list()
)
}
\arguments{
\item{response}{Response variable to use in mob model.}

\item{x}{Covariates passed to model in mob. mob uses fits the formula
y ~ x1 + ... + xk | z1 + ... + zl where the variables before the | are passed
to the model and the variables after the | are used for partitioning. x
represents the x variables. See mob help page for more information.}

\item{z}{Covariates used to parition the mob model. mob uses fits the formula
y ~ x1 + ... + xk | z1 + ... + zl where the variables before the | are passed
to the model and the variables after the | are used for partitioning. z
represents the z variables. See mob help page for more information.}

\item{covariates}{An alias for z.}

\item{tree_builder_parameters}{A named list of parameters to pass to
\link[party]{mob}.}
}
\value{
An object of class \linkS4class{MOB}
}
\description{
Wrapper function for \link[party]{mob}.
}
\seealso{
\link[party]{mob}
}
