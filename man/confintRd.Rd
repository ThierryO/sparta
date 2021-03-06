\name{confintRd}
\alias{confintRd}
\title{Calculate confidence intervals for the index from Maes et al based on their bootstrapped distribution under the alternative hypothesis}
\usage{
  confintRd(rd, n, distribution, alpha = 0.05)
}
\arguments{
  \item{rd}{a matrix with relative distributions. The first
  column contains the relative distribution at the first
  timepoint. The column column those of the second
  timepoint. Other columns are ignored.}

  \item{n}{a vector with the number of sampled gridcells in
  each period. Only the first two are used. Ignored when
  distribution is given.}

  \item{distribution}{a list with at least one item Ha
  contains a matrix with as many rows as rd containing
  resampled values of the index under the alternative
  hypothesis. Will be calculated if missing.}

  \item{alpha}{the errorlevel}
}
\value{
  a matrix with observed index, lower confidence limits,
  upper confidence limit and median.
}
\description{
  Calculate confidence intervals for the index from Maes et
  al based on their bootstrapped distribution under the
  alternative hypothesis
}
\author{
  Thierry Onkelinx
}

