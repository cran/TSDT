% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utility_functions.R
\name{unpack_args}
\alias{unpack_args}
\title{unpack_args}
\usage{
unpack_args(args)
}
\arguments{
\item{args}{List of entities to be assigned.}
}
\description{
Assign the elements of a named list in current environment.
}
\details{
This function takes a list of named entities and assigns each element
of the list to its name in the calling environment.
}
\examples{
## Create a list of named elements
arglist <- list( one = 1, two = 2, color = "blue" )

## The variables one, two, and color do not exist in the current environment
ls()

## Unpack the elements in arglist
unpack_args( arglist )

## Now the variables one, two, and color do exist in the current environment
ls()
one
}
\seealso{
\link{assign}, \link{parent.frame}
}
