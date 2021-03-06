% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utility_functions.R
\name{reset_factor_levels}
\alias{reset_factor_levels}
\title{reset_factor_levels}
\usage{
reset_factor_levels(data)
}
\arguments{
\item{data}{A data.frame containing factor variables.}
}
\value{
A data.frame with factor variable that now have reset levels.
}
\description{
Reset the list of levels associated with a factor variable.
}
\details{
After subsetting a factor variable some factor levels that were
previously present may be lost. This is particularly true for relatively rare
factor levels. This function resets the list of factor levels to include only
the levels currently present.
}
\examples{
ex1 = as.factor( c( rep('A', 3), rep('B',3), rep('C',3) ) )

## The levels associated with the factor variable include the letters A, B, C
ex1  # Levels are A, B, C

## If the last three observations are dropped the value C no longer occurs
## in the data, but the list of associated factor levels still contains C.
## This mismatch between the data and the list of factor levels may cause
## problems, particularly for algorithms that iterate over the factor levels.

ex1 <- ex1[1:6]
ex1 # Levels are still A, B, C, but the data contains only A and B

## If the factor levels are reset the data and list of levels will once again
## be consistent
ex1 <- reset_factor_levels( ex1 )
ex1 # Levels now contain only A and B, which is consistent with data
}
