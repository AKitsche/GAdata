\name{tcMulti}
\alias{tcMulti}
\docType{data}
\title{
Quantitative trait analyis for 9 markers
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data(tcMulti)}
\format{
  A data frame with 4712 observations on the following 7 variables.
  \describe{
    \item{\code{id}}{a numeric vector}
    \item{\code{tc}}{a numeric vector}
    \item{\code{marker}}{a factor with levels \code{rs10498337} \code{rs11822822} \code{rs6829649} \code{rs709595} \code{rs726914} \code{rs7704530} \code{rs7738656} \code{rs853773}}
    \item{\code{genotype}}{a factor with levels \code{het} \code{hom1} \code{hom2}}
    \item{\code{add}}{a numeric vector}
    \item{\code{rec}}{a numeric vector}
    \item{\code{dom}}{a numeric vector}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(tcMulti)
str(tcMulti)
tcMulti$genotype <- factor(tcMulti$genotype, levels=c("hom1","het","hom2"))
#Approach using three different genetic models
LMdom <- lm(tc ~ dom * marker, data=tcMulti)
LMadd <- lm(tc ~ add * marker, data=tcMulti)
LMrec <- lm(tc ~ rec * marker, data=tcMulti)

#Matrix that defines regression slopes for each locus
K <- matrix(c(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
              0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
              0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
              0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
              0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,
              0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,
              0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1), nrow=8, byrow=TRUE)

library(multcomp)
g <- glht(mmm(m1=LMdom, m2=LMadd, m3=LMrec), mlf(K))
summary(g)
}
\keyword{datasets}
