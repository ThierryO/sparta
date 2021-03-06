\name{cvg_codes}
\alias{cvg_codes}
\title{Convergence codes for linear models}
\usage{
  cvg_codes(x = NULL)
}
\arguments{
  \item{x}{A number indicating a cvg code, can be a
  vector.}
}
\value{
  The description of the code (x) as found in the source
  code of lme4.  If x is not given all code descriptions
  are returned as a table.
}
\description{
  This function is an aid to interpreting cvg (convergence)
  codes.
}
\examples{
\dontrun{
library(sparta)

y<-cvg_code(4)

y
}
}

