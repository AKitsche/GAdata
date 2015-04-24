\name{chol}
\alias{chol}
\docType{data}
\title{
total cholesterol
}
\description{
Amount of total cholesterol from the Bogalusa Heart Study dataset that is associated with SNP rs7738656 in the gene C6orf170/GJA1.
}
\usage{data(chol)}
\format{
  A data frame with 525 observations on the following 8 variables.
  \describe{
    \item{\code{ID}}{ID variable}
    \item{\code{sex}}{a numeric vector specifying the persons´s sex}
    \item{\code{age}}{a numeric vector specifying the person´s age}
    \item{\code{tc}}{amount of total cholesterol}
    \item{\code{genotype}}{a factor with levels \code{A A} \code{A G} \code{G G}}
    \item{\code{rec}}{a numeric vector encoding the recessive genetic model}
    \item{\code{add}}{a numeric vector encoding the additive genetic model}
    \item{\code{dom}}{a numeric vector encoding the dominant genetic model}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
Smith, E. N., Chen, W., Kahonen, M., Kettunen, J., Lehtimaki, T., Peltonen, L.,
Raitakari, O. T., Salem, R. M., Schork, N. J., Shaw, M., Srinivasan, S. R., Topol,
E. J., Viikari, J. S., Berenson, G. S., and Murray, S. S. (2010). Longitudinal
genome-wide association of cardiovascular disease risk factors in the Bogalusa
heart study. PLOS genetics, 6(9)
}
\examples{
data(chol)

#graphical display via boxplots
boxplot(tc ~ genotype, data=chol)

#calculating the allele frequencies
table(chol)#A is the minor allele

#Approach using three different genetic models
madd <- lm(tc~ add, data=chol) #lin reg add
mrec <- lm(tc~ rec, data=chol) #lin reg rec
mdom <- lm(tc~ dom, data=chol) #lin reg dom

#simultaneous assessment of multiple marginal models
g <- glht(mmm(m1=madd, m2=mrec, m3=mdom), mlf(m1="add=0", m2="rec=0", m3="dom=0"))
summary(g)
summary(g)$test$pvalues

}
\keyword{datasets}
