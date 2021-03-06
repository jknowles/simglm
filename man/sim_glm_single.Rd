% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sim_glm_func.r
\name{sim_glm_single}
\alias{sim_glm_single}
\title{Simulation single level logistic regression model}
\usage{
sim_glm_single(fixed, fixed_param, cov_param, n, data_str, cor_vars = NULL,
  fact_vars = list(NULL), contrasts = NULL, ...)
}
\arguments{
\item{fixed}{One sided formula for fixed effects in the simulation.
To suppress intercept add -1 to formula.}

\item{fixed_param}{Fixed effect parameter values (i.e. beta weights).
Must be same length as fixed.}

\item{cov_param}{List of arguments to pass to the continuous generating 
 function. Required arguments include:
 \itemize{
   \item dist_fun: This is a quoted R distribution function.
   \item var_type: This is the level of variable to generate. Must be 
     either 'lvl1', 'lvl2', or 'lvl3'. Must be same order as fixed formula 
     above.
 }
 Optional arguments to the distribution functions are in a nested list,
  see the examples for example code for this.
Does not include intercept, time, factors, or interactions.}

\item{n}{Cluster sample size.}

\item{data_str}{Type of data. Must be "cross", "long", or "single".}

\item{cor_vars}{A vector of correlations between variables.}

\item{fact_vars}{A nested list of factor, categorical, or ordinal variable 
   specification, each list must include:
\itemize{
     \item numlevels = Number of levels for ordinal or factor variables.
     \item var_type = Must be 'single', 'lvl1', 'lvl2', or 'lvl3'.
 }
 Optional arguments include:
 \itemize{
     \item replace
     \item prob
     \item value.labels
 }
  See also \code{\link{sample}} for use of these optional arguments.}

\item{contrasts}{An optional list that specifies the contrasts to be used 
for factor variables (i.e. those variables with .f or .c). 
See \code{\link{contrasts}} for more detail.}

\item{...}{Not currently used.}
}
\description{
Takes simulation parameters as inputs and returns simulated data.
}
\details{
Simulates data for the simple logistic regression models.  Returns 
a data frame with ID variables, fixed effects, and many other variables
to help when running simulation studies.
}
\examples{
# generating parameters for single level regression
set.seed(2)
fixed <- ~1 + act + diff + numCourse + act:numCourse
fixed_param <- c(2, 4, 1, 3.5, 2)
cov_param <- list(dist_fun = c('rnorm', 'rnorm', 'rnorm'),
   var_type = c("single", "single", "single"),
   opts = list(list(mean = 0, sd = 4),
   list(mean = 0, sd = 3),
   list(mean = 0, sd = 3)))
n <- 150
temp_single <- sim_glm(fixed = fixed, fixed_param = fixed_param, 
  cov_param = cov_param, n = n, data_str = "single")
  
}

