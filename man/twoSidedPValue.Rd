\name{twoSidedPValue}
\alias{twoSidedPValue}
\title{Calculate two sided p-values for the index from Maes et al based on their bootstrapped distribution under the null hypothesis}
\usage{
  twoSidedPValue(rd, n, distribution)
}
\arguments{
  \item{rd}{a matrix with relative distributions. The first
  column contains the relative distribution at the first
  timepoint. The column column those of the second
  timepoint. Other columns are ignored.}

  \item{n}{a vector with the number of sampled gridcells in
  each period. Only the first two are used. Ignored when
  distribution is given.}

  \item{distribution}{a list with at least one item H0
  contains a matrix with as many rows as rd containing
  resampled values of the index under the null hypothesis.
  Will be calculated if missing.}
}
\value{
  a vector with two sided p-values for each row of rd
}
\description{
  Calculate two sided p-values for the index from Maes et
  al based on their bootstrapped distribution under the
  null hypothesis
}
\author{
  Thierry Onkelinx
}

