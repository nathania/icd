% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class.R
\name{combine}
\alias{c.icd10}
\alias{c.icd9}
\alias{combine}
\title{combine ICD codes}
\usage{
\method{c}{icd9}(..., warn = FALSE)

\method{c}{icd10}(..., warn = FALSE)
}
\arguments{
\item{...}{elements to combine}

\item{warn}{single logical value, if TRUE, will give warnings when
incompatible types are combined using \code{c}}
}
\description{
These function implement combination of lists or vectors of codes, while
preserving ICD classes. Base R \code{c} just drops all user defined classes
and casts down to lowest common denominator, e.g. if mixing numbers and
characters. No attempt here to catch all possible combinations of feeding in
mixed ICD types and other types. Let R do what it normally does, but just try
to keep classes of the first item in the list.
}
\examples{
\dontrun{
# throw an error? or assign type according to first argument?
c(as.icd9("E998"), as.icd10("A10"))

# benchmark subsetting to justify using .subset2 (5\% faster)
library(microbenchmark)
j <- list(as.icd9cm("E990"), as.icd9cm("10010"))
k <- list(rep(as.icd9cm("E990"), times = 500))
microbenchmark(j[[1]], .subset2(j, 1),
               k[[1]], .subset2(k, 1),
               times = 1e6)

# logical list to vector
a <- list(T,T)
microbenchmark(as.logical(a), c(a, recursive = TRUE), times = 1e6)

# c(..., recursive = TRUE) vs unlist
l = list(c("100", "440", "999"), c("123", "234"))
microbenchmark::microbenchmark(c(l, recursive = TRUE),
                               c(unlist(l)),
                               times = 1e6)
stopifnot(identical(c(l, recursive = TRUE), c(unlist(l))))

}
}

