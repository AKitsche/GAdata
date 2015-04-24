\name{Depression}
\alias{Depression}
\docType{data}
\title{
Association study on depressive symptoms at follow-up.
}
\description{
Genome-wide association studies have reported an association between the SNP rs1006737 within the CACNA1C gene and schizophrenia.
}
\usage{data(Depression)}
\format{
  A data frame with 3678 observations on the following 5 variables.
  \describe{
    \item{\code{ID}}{a numeric vector}
    \item{\code{NumGeno}}{a numeric vector, numeric representation of genotypes}
    \item{\code{Score}}{a numeric vector, Depressive symptoms at follow-up}
    \item{\code{Genotype}}{a factor with levels \code{AA} \code{AG} \code{GG}}
    \item{\code{Gender}}{a factor with levels \code{females} \code{males}}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
Strohmaier, J, Amelang, M, Hothorn, LA, Witt, SH, Nieratschker, V, Gerhard, D, Meier, S, Wuest, S, Frank, J, Loerbroks, A, Rietschel, M, Stuermer, T, Schulze, TG. The psychiatric vulnerability gene CACNA1C and its sex-specific relationship with personality traits, resilience factors and depressive symptoms in the general population. Molecular psychiatry, 18(5):607-613, 2013.
}
\examples{
data(Depression)
str(Depression)
#gender specific analysis according to Stroymaier et al. 
library(nparcomp)
#subset of females
Females <- subset(Depression, Gender=="females")
TestFemales <- nparcomp(Score ~ Genotype, data=Females, type = "Marcus")
summary(TestFemales)
#subset of males
Males <- subset(Depression, Gender=="males")
TestMales <- nparcomp(Score ~ Genotype, data=Males, type = "Marcus")
summary(TestMales)
}
\keyword{datasets}
