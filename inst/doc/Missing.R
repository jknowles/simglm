## ----setup, include=FALSE------------------------------------------------
library(knitr)
library(simglm)
knit_print.data.frame = function(x, ...) {
  res = paste(c('', '', kable(x, output = FALSE)), collapse = '\n')
  asis_output(res)
}

## ----dropout-------------------------------------------------------------
# Simulate longitudinal data
fixed <- ~1 + time + diff + act + time:act
random <- ~1 + time + diff
fixed_param <- c(4, 2, 6, 2.3, 7)
random_param <- list(random_var = c(7, 4, 2), rand_gen = "rnorm")
cov_param <- list(mean = c(0, 0), sd = c(1.5, 4), var_type = c("lvl1", "lvl2"))
n <- 150
p <- 30
error_var <- 4
with_err_gen <- 'rnorm'
data_str <- "long"
temp_long <- sim_reg(fixed, random, random3 = NULL, fixed_param, random_param, random_param3 = NULL,
 cov_param, k = NULL, n, p, error_var, with_err_gen, data_str = data_str)

# simulate missing data
temp_long_miss <- missing_data(temp_long, miss_prop = .25, type = 'dropout', 
                               clust_var = 'clustID', within_id = 'withinID')
head(temp_long_miss)

## ----propmissing---------------------------------------------------------
prop.table(table(temp_long_miss$missing))
prop.table(table(is.na(temp_long_miss$sim_data2)))

## ----marexamp------------------------------------------------------------
# simulate data
fixed <- ~1 + age + income
fixed_param <- c(2, 0.3, 1.3)
cov_param <- list(mean = c(0, 0), sd = c(4, 3), 
                  var_type = c("single", "single"))
n <- 150
error_var <- 3
with_err_gen <- 'rnorm'
temp_single <- sim_reg(fixed = fixed, fixed_param = fixed_param,
                       cov_param = cov_param,
                       n = n, error_var = error_var, with_err_gen = with_err_gen,
                       data_str = "single")

# generate missing data
miss_prop <- c(0.5, 0.45, 0.4, 0.35, 0.3, 0.25, 0.2, 0.15, 0.1, 0.05)
miss_prop <- rep(miss_prop, each = 15)
tmp_single_miss <- missing_data(temp_single, miss_prop = miss_prop, 
                                type = 'mar', miss_cov = 'income')
head(tmp_single_miss)

## ----marmisscheck--------------------------------------------------------
table(tmp_single_miss$miss_prop,is.na(tmp_single_miss$sim_data2))

## ----mcarmisssingle------------------------------------------------------
tmp_single_miss <- missing_data(temp_single, miss_prop = .25, 
                                type = 'random', clust_var = NULL)
head(tmp_single_miss)

## ----mcarmissverify------------------------------------------------------
prop.table(table(is.na(tmp_single_miss$sim_data2)))

## ----clustmcar, eval = FALSE, echo = FALSE-------------------------------
#  tmp.long.miss <- missing_data(temp.long, miss_prop = .25, type = 'random', clust_var = 'clustID')
#  head(tmp.long.miss)

