\name{Psoriasis}
\alias{Psoriasis}
\docType{data}
\title{
Case-control study - psoriasis
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data(Psoriasis)}
\format{
  A data frame with 1152 observations on the following 7 variables.
  \describe{
    \item{\code{locus}}{a factor with levels \code{IL1B 511 locus} \code{TNFA 238 locus}}
    \item{\code{gender}}{a factor with levels \code{female} \code{male}}
    \item{\code{group}}{a factor with levels \code{Control} \code{EarlyOnset} \code{LateOnset}}
    \item{\code{Genotype}}{a factor with levels \code{CC} \code{CT} \code{TT}}
    \item{\code{x0}}{a numeric vector, dummy coding for homozygous C}
    \item{\code{x1}}{a numeric vector, dummy coding for heterozygous}
    \item{\code{x2}}{a numeric vector, dummy coding for homozygous T}
  }
}
\details{
Case-control study to investigate the association between psoriasis and polymorphisms of genes encoding tumour necrosis Factor-alpha and Interleukin-1beta. Two loci, namely  IL1B_511 and TNFA_238, are considered. A control group and two groups of affected people with early and late onset of the disease are under test.
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
L.A Hothorn and T. Hothorn. Order-restricted scores test for the evaluation of populationbased case-control studies when the genetic model is unknown. Biometrical Journal, 51(4):659-669, 2009.
}
\examples{
data(Psoriasis)

with(Psoriasis, table(Genotype, group, locus))

Psoriasis$GenNum <- as.numeric(Psoriasis$Genotype)
Psoriasis$Add <- c(0, 0.5, 1)[Psoriasis$GenNum]
Psoriasis$Dom <- c(0, 1, 1)[Psoriasis$GenNum]
Psoriasis$Rec <- c(0, 0, 1)[Psoriasis$GenNum]

#Approach using three different genetic models
GLMdom <- glm(group ~ Dom * locus ,family=binomial, data=Psoriasis)
GLMadd <- glm(group ~ Add * locus ,family=binomial, data=Psoriasis)
GLMrec <- glm(group ~ Rec * locus ,family=binomial, data=Psoriasis)

#Matrix that defines regression slopes for each locus
K <- matrix(c(0, 1, 0, 0,
              0, 1, 0, 1), nrow=2, byrow=TRUE)
#simultaneous assessment of multiple marginal models
g <- glht(mmm(m1=GLMdom, m2=GLMadd, m3=GLMrec), mlf(K))
summary(g)
}
\keyword{datasets}
