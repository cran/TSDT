% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TSDT_CutpointDistribution.ClassDefinition.R
\docType{methods}
\name{get_cutpoints}
\alias{get_cutpoints}
\alias{get_cutpoints,TSDT_CutpointDistribution-method}
\alias{get_cutpoints,ANY-method}
\alias{get_cutpoints,TSDT-method}
\title{get_cutpoints}
\usage{
get_cutpoints(.Object, subgroup, subsub = NULL)

\S4method{get_cutpoints}{TSDT_CutpointDistribution}(.Object, subgroup = character, subsub = NULL)

\S4method{get_cutpoints}{TSDT}(.Object, subgroup = character, subsub = NULL)
}
\arguments{
\item{.Object}{A TSDT object.}

\item{subgroup}{The anonymized subgroup.}

\item{subsub}{A particular component of the subgroup to retrieve.}
}
\description{
Accessor method for cutpoints slot in TSDT objects.
}
\details{
The summary results from TSDT provide a set of 'anonymized' subgroups
in a form similar to 'X1<xxxxx'. The variable X1 may have been selected as a
splitting variable in several bootstrapped samples. The exact numerical
cutpoint for X1 could vary from one sample to the next. The get_cutpoints
method returns all the numerical cutpoints associated with this subgroup. If
the subgroup is a compound subgroup defined on more than one spliting variable
the user can specify the 'subsub' parameter to get the cutpoints associated
with a particular component of the subgroup.
}
\examples{
\dontrun{
example( TSDT )
## You can access the cutpoints slot of a TSDT object directly
ex2@cutpoints

## You can also use the accessor method
get_cutpoints( ex2@cutpoints, subgroup = 'X1<xxxxx' )

## Retrieving a compound subgroup defined on multiple splits
get_cutpoints( ex2, subgroup = 'X1<xxxxx & X1>=xxxxx' )

## Retrieving a single component from the compound subgroup
get_cutpoints( ex2, subgroup = 'X1<xxxxx & X1>=xxxxx', subsub = 'X1>=xxxxx' )
}
}
