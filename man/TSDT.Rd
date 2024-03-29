% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TSDT.R
\name{TSDT}
\alias{TSDT}
\title{Treatment-Specific Subgroup Detection Tool}
\usage{
TSDT(
  response = NULL,
  response_type = NULL,
  survival_model = "kaplan-meier",
  percentile = 0.5,
  tree_builder = "rpart",
  tree_builder_parameters = list(),
  covariates,
  trt = NULL,
  trt_control = 0,
  permute_method = NULL,
  permute_arm = NULL,
  n_samples = 1,
  desirable_response = NULL,
  sampling_method = "bootstrap",
  inbag_proportion = 0.5,
  scoring_function = NULL,
  scoring_function_parameters = list(),
  inbag_score_margin = 0,
  oob_score_margin = 0,
  eps = 1e-05,
  min_subgroup_n_control = NULL,
  min_subgroup_n_trt = NULL,
  min_subgroup_n_oob_control = NULL,
  min_subgroup_n_oob_trt = NULL,
  maxdepth = .Machine$integer.max,
  rootcompete = 0,
  competedepth = 1,
  strength_cutpoints = c(0.1, 0.2, 0.3),
  n_permutations = 0,
  n_cpu = 1,
  trace = FALSE
)
}
\arguments{
\item{response}{Response variable.}

\item{response_type}{Data type of response. Must be one of binary, continuous,
survival. If none provided it will be inferred from the data type of response.
(optional)}

\item{survival_model}{The model to use for a survival response. Defaults to
kaplan-meier. Other possible values are: coxph, fleming-harrington, fh2,
weibull, exponential, gaussian, logistic, lognormal, and loglogistic.
(optional)}

\item{percentile}{For a two-arm study this parameter specifies a test for
the difference in response percentile across the two treatment arms. For a
continuous response the default value for percentile is NULL. Instead, the
difference in mean response is computed by default for a continuous response.
If the user provides a values of percentile = 0.50 then the difference in
median response would be computed. For a survival outcome, the default value
for percentile is 0.50, which computes the difference in median survival.}

\item{tree_builder}{The algorithm to use for building the trees. Defaults to
rpart. Other possible values include ctree and mob (both from the party
package). (optional)}

\item{tree_builder_parameters}{A named list of parameters to pass to the
tree-builder. The default tree-builder is rpart. In this case, the parameters
passed here would be rpart parameters. Examples might include parameters such
as control, cost, weights, na.action, etc. Consult the rpart documentation (or
the documentation of your selected tree-builder) for a complete list. (optional)}

\item{covariates}{A data.frame containing the covariates.}

\item{trt}{Treatment variable. Only needed if there are two treatment arms.
(optional)}

\item{trt_control}{Value for treatment control arm. This parameter is relevant
only for two-arm data. (defaults to 0)}

\item{permute_method}{Indicates whether only the response variable should be
permuted in the computation of the p-value, or the response and treatment
variable should be permuted together (preserving the treatment-response
correlation, but eliminating the correlation with the covariates), or the
response variable should be permuted within one treatment arm only. The
parameter values for these permutation schemes are (respectively) simple,
permute_response_and_treatment, and permute_response_one_arm. See permute_arm
to specify which treatment arm is to be permuted. The default permutation
scheme is response_one_arm. As noted in the documentation for the permute_arm
parameter is to permute the non-control arm. Taken together, this implies the
default permutation method for p-value computation is to permute the response
in the non-control arm only. For one-arm data only the response is permuted.
(optional)}

\item{permute_arm}{Which treatment arm should be permuted? Defaults to the
experimental treatment arm -- i.e. the treatment arm not matching the value
provided in trt_control. For one-arm data only the response is permuted.
(optional)}

\item{n_samples}{Number of TSDT_Samples to draw.}

\item{desirable_response}{Direction of desirable response. Valid values are
'increasing' or 'decreasing'. The default value is 'increasing'. It is
important to note that although the parameter is called desirable_response, it
actually refers to the desirable direction of scoring function values. In most
cases there is a positive correlation bewteen the response and scoring
function values -- i.e. as the response increases the scoring function also
increases. One instance for which this relationship between response and
scoring function may not hold is when mean_deviance_residuals or
diff_mean_deviance_residuals is used as the scoring function. See the help for
these scorings function for further details.}

\item{sampling_method}{Sampling method used to populate samples for TSDT
in-bag and out-of-bag data. Must be either bootstrap or subsample. Default
is bootstrap.}

\item{inbag_proportion}{The proportion of the data to use as the in-bag
subset when sampling_method is subsample.}

\item{scoring_function}{Scoring function to compute treatment effect. Links to
several possible scoring functions are provided in the See Also section below.}

\item{scoring_function_parameters}{Parameters passed to the scoring function.
As an example, the scoring function quantile_response takes a parameter
"percentile" which indicates the desired percentile of the response distribution.
Thus, if the median response is desired, this parameter could be set as follows:
scoring_function_parameters = list( percentile = 0.50 ). Most of the built-in
scoring functions have sensible defaults for the scoring function parameters
so it is not necessary to specify them explicitly in the call to TSDT. But this
parameter could be very useful for user-defined custom scoring functions.
(optional)}

\item{inbag_score_margin}{Required margin above overall mean for a subgroup to
be considered superior. If a subgroup mean must be 10\% larger than the overall
subgroup mean to be superior then inbag_score_margin = 0.10. If
desirable_response = "decreasing" then inbag_score_margin should be negative
or zero.}

\item{oob_score_margin}{Similar to inbag_score_margin but for classifying
out-of-bag subgroups as superior.}

\item{eps}{Tolerance value for floating-point precision. The default is 1E-5. (optional)}

\item{min_subgroup_n_control}{Minimum number of Control arm observations in an
in-bag subgroup. A value greater than or equal to one will be interpreted as
the required minimum number of observations. A value between zero and one
will be interpreted as a proportion of the in-bag Control observations. For a
bootstrapped in-bag sample the default for this parameter is 10% of the number
of Control observations in the overall sample. For an in-bag sample obtained
via subsampling the default value is the inbag_proportion times 10% of the
number of Control observations in the overall sample.}

\item{min_subgroup_n_trt}{Minimum number of Experimental arm observations in
an in-bag subgroup. A value greater than or equal to one will be interpreted
as the required minimum number of observations. A value between zero and one
will be interpreted as a proportion of the in-bag Experimental observations.
For a bootstrapped in-bag sample the default for this parameter is 10% of the
number of Experimental observations in the overall sample. For an in-bag
sample obtained via subsampling the default value is the inbag_proportion
times 10\% of the number of Experimental observations in the overall sample.}

\item{min_subgroup_n_oob_control}{Minimum number of Control arm observations
in an out-of-bag subgroup. A value greater than or equal to one will be
interpreted as the required minimum number of observations. A value between
zero and one will be interpreted as a proportion of the out-of-bag Control
observations. For a bootstrapped out-of-bag sample the default for this
parameter is exp(-1)*10\% of the number of Control observations in the overall
sample. For an out-of-bag sample obtained via subsampling the default value
is the inbag_proportion times (1-inbag_proportion)*10% of the number of
Control observations in the overall sample.}

\item{min_subgroup_n_oob_trt}{Minimum number of Experimental arm observations
in an out-of-bag subgroup. A value greater than or equal to one will be
interpreted as the required minimum number of observations. A value between
zero and one will be interpreted as a proportion of the out-of-bag
Experimental observations. For a bootstrapped out-of-bag sample the default
for this parameter is exp(-1)*10\% of the number of Experimental observations
in the overall sample. For an out-of-bag sample obtained via subsampling the
default value is the inbag_proportion times (1-inbag_proportion)*10\% of the
number of Experimental  observations in the overall sample.}

\item{maxdepth}{Maximum depth of trees.}

\item{rootcompete}{Number of competitor splits to retain for root node split.}

\item{competedepth}{Depth of competitor split trees (defaults to 1)}

\item{strength_cutpoints}{Cutpoints for permuted p-values to classify a
subgroup as Strong, Moderate, Weak, or Not Confirmed. The default cutpoints are
0.10, 0.20, and 0.30 for Strong, Moderate, and Weak subgroups, respectively. (optional)}

\item{n_permutations}{Number of permutations to compute for adjusted p-value.
Defaults to zero (no p-value computation). If p-values are desired, it is
recommended to use at least 500 permutations.}

\item{n_cpu}{Number of CPUs to use. Defaults to 1.}

\item{trace}{Report number of permutations computed as algorithm proceeds.}
}
\value{
An object of class \linkS4class{TSDT}
}
\description{
Implements a method for identifying subgroups with superior response relative
to the overall sample.
}
\details{
The Treatment-Specific Subgroup Detection Tool (TSDT) creates several
bootstrapped samples from the input data. For each of these bootstrapped
samples the in-bag and out-of-bag data are retained. A tree is grown on the
in-bag data of each bootstrapped sample using the response variable and
supplied covariates. Each split in the tree defines a subgroup. The overall
mean response for the in-bag data is computed as well as the mean response
within each subgroup. Additionally, a scoring function is provided. Example
scoring functions might be mean response, difference in mean response between
treatment arms (i.e. treatment effect), or a quantile of the response (e.g.
median), or a difference in quantiles across treatment arms. Sensible
defaults are provided given the data type of the response and treatment
variables. The user can also specify a custom scoring function. The value of
the scoring function is computed for the overall in-bag data and each
subgroup. Subgroups with mean response larger than the overall in-bag mean
response and a mean scoring function value larger than the overall in-bag
scoring function value are identified as superior subgroups. This definition
of a superior subgroup assumes a larger value of the response variable is
desirable. If a smaller value of the response is desirable then subgroups
with mean response and mean scoring function smaller than the overall in-bag
mean are superior. The same computation of overall and subgroup mean
response and mean scoring function are done for the out-of-bag data. This is
repeated for all bootstrapped samples.  Measures of internal and external
consistency are then computed. Internal consistency is computed for each
subgroup that is identified as superior in one of the in-bag samples.
Internal consistency for each of these subgroups is the fraction of
bootstrapped samples where that subgroup is identified as superior in the
in-bag data. External consistency is also defined only for subgroups that
are identified as superior in at least one of the in-bag samples. For each
of these subgroups, external consistency is the number of bootstrapped
samples where the subgroup is defined as superior in the in-bag and
out-of-bag data divided by the number of bootstrapped samples where the
subgroup is identified as superior in the in-bag data. The internal and
external consistency results are returned for each subgroup that identified
as superior in the in-bag data of at least one bootstrapped sample. A score
for the overall strength of each subgroup is computed as the product of the
internal and external consistency. Optionally, a permutation-adjusted
p-value for the strength of each subgroup can be computed. Based on this
p-value subgroups are classified as strong, moderate, weak, or not
confirmed. A suggested cutoff for each subgroup is also provided. This is
helpful because two subgroups defined on the same continuous splitting
variable but with different cutpoints are considered equivalent. That is,
one subgroup X1<0.6 and another X1<0.7 would be considered equivalent and
listed in the results as X1<xxxxx. (Note that X1<0.6 and X1>=0.7 would be
considered distinct subgroups and listed in the output as X1<xxxxx and
X1>=xxxxx, respectively.) So if a subgroup listed in the output as X1<xxxxx
could actually represent many different numeric values for xxxxx it is
helpful to provide a final suggestion for the cutpoint. The algorithm
retains all the numeric values and uses the median as the suggested cutoff.
The user can also request the vector of numeric cutpoints and use any
function of their choosing to compute a suggested cutoff.
}
\examples{
## Create example data for constructing TSDT object
N <- 200
continuous_response = runif( min = 0, max = 20, n = N )
trt <- sample( c('Control','Experimental'), size = N, prob = c(0.4,0.6), replace = TRUE )
X1 <- runif( N, min = 0, max = 1 )
X2 <- runif( N, min = 0, max = 1 )
X3 <- sample( c(0,1), size = N, prob = c(0.2,0.8), replace = TRUE )
X4 <- sample( c('A','B','C'), size = N, prob = c(0.6,0.3,0.1), replace = TRUE )
covariates <- data.frame( X1 )
covariates$X2 <- X2
covariates$X3 <- factor( X3 )
covariates$X4 <- factor( X4 )


## In the following examples n_samples and n_permutations are set to small
## values so the examples complete quickly. The intent here is to provide
## a small functional example to demonstrate the structure of the output. In
## a real-world use of TSDT these values should be at least 100 and 500,
## respectively.

## Single-arm TSDT
ex1 <- TSDT( response = continuous_response,
            covariates = covariates[,1:4],
            inbag_score_margin = 0,
            desirable_response = "increasing",
            n_samples = 5,       ## use value >= 100 in real world application
            n_permutations = 5,  ## use value >= 500 in real world application
            rootcompete = 1,
            maxdepth = 2 )

## Two-arm TSDT
ex2 <- TSDT( response = continuous_response,
            trt = trt, trt_control = 'Control',
            covariates = covariates[,1:4],
            inbag_score_margin = 0,
            desirable_response = "increasing",
            oob_score_margin = 0,
            min_subgroup_n_control = 10,
            min_subgroup_n_trt = 20,
            maxdepth = 2,
            rootcompete = 1,
            n_samples = 5,      ## use value >= 100 in real world application
            n_permutations = 5 ) ## use value >= 500 in real world application
}
\references{
Battioui, C., Shen, L., Ruberg, S., (2014). A Resampling-based Ensemble Tree Method to Identify Patient Subgroups with Enhanced Treatment Effect. JSM proceedings, 2014

Shen, L., Battioui, C., Ding, Y., (2013). Chapter "A Framework of Statistical methods for Identification of Subgroups with Differential Treatment Effects in Randomized Trials" in the book "Applied Statistics in Biomedicine and Clinical Trials Design"
}
\seealso{
\link{mean_response}, \link{quantile_response},
\link{diff_quantile_response}, \link{treatment_effect},
\link{survival_time_quantile}, \link{diff_survival_time_quantile},
\link{mean_deviance_residuals}, \link{diff_mean_deviance_residuals},
\link{diff_restricted_mean_survival_time}, \linkS4class{TSDT},
\link[rpart]{rpart}, \link[party]{ctree}, \link[party]{mob}
}
\author{
Brian Denton \email{denton_brian_david@lilly.com},
Chakib Battioui \email{battioui_chakib@lilly.com},
Lei Shen \email{shen_lei@lilly.com}
}
