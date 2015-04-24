\name{listerD13Mit147}
\alias{listerD13Mit147}
\docType{data}
\title{
Data on Listeria monocytogenes susceptibility (marker D13Mit147)
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data(listerD13Mit147)}
\format{
  A data frame with 116 observations on the following 6 variables.
  \describe{
    \item{\code{pheno}}{a numeric vector representing the survival time}
    \item{\code{geno}}{a factor with levels \code{AA} \code{Aa} \code{aa}}
    \item{\code{cens}}{a logical vector}
    \item{\code{x0}}{a numeric vector, dummy coding for homozygous A}
    \item{\code{x1}}{a numeric vector, dummy coding for heterozygous}
    \item{\code{x2}}{a numeric vector, dummy coding for homozygous a}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
Victor Boyartchuk and William Dietrich (Department of Genetics, Harvard Medical School and Howard Hughes Medical Institute) \url{http://genetics.med.harvard.edu/~bdlab}
}
\references{
Boyartchuk, V. L., Broman, K. W., Mosher, R. E., D'Orazio S. E. F., Starnbach, M. N. and Dietrich, W. F. (2001) Multigenic control of Listeria monocytogenes susceptibility in mice. Nature Genetics 27, 259-260.
}
\examples{
data(listerD13Mit147)
#Kaplan-Meier plot
kapmei <- survfit(Surv(pheno, cens) ~ geno, data = listerD13Mit147)
plot(kapmei, lty = c(3,4,1))
legend("topright", legend = c("aa", "Aa", "AA"), lty = c(3,4,1))

table(listerD13Mit147$geno)#a is the minor allele

listerD13Mit147$numgeno <- as.numeric(listerD13Mit147$geno)
#Approach using three different genetic models
listerD13Mit147$add <- c(0, 0.5, 1)[listerD13Mit147$numgeno]
listerD13Mit147$rec <- c(0, 0, 1)[listerD13Mit147$numgeno]
listerD13Mit147$dom <- c(0, 1, 1)[listerD13Mit147$numgeno]

#Approach using three different genetic models
madd <- coxph(Surv(pheno, cens) ~ add, data=listerD13Mit147) #lin reg add
mrec <- coxph(Surv(pheno, cens) ~ rec, data=listerD13Mit147) #lin reg rec
mdom <- coxph(Surv(pheno, cens) ~ dom, data=listerD13Mit147) #lin reg dom

#simultaneous assessment of multiple marginal models
g <- glht(mmm(m1=madd, m2=mrec, m3=mdom), mlf(m1="add=0", m2="rec=0", m3="dom=0"))
summary(g)
summary(g)$test$pvalues
}
\keyword{datasets}
