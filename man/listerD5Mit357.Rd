\name{listerD5Mit357}
\alias{listerD5Mit357}
\docType{data}
\title{
Data on Listeria monocytogenes susceptibility (marker D5Mit357)
}
\description{
Data from an experiment on susceptibility to Listeria monocytogenes infection in mouse.
The susceptibility of mice to Listeria monocytogenes infection was defined as the number of hours elapsed between injection and death of the animal. 
}
\usage{data(listerD5Mit357)}
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
data(listerD5Mit357)
#Kaplan-Meier plot
kapmei <- survfit(Surv(pheno, cens) ~ geno, data = listerD5Mit357)
plot(kapmei, lty = c(3,4,1))
legend("topright", legend = c("aa", "Aa", "AA"), lty = c(3,4,1))

table(listerD5Mit357$geno)#A is the minor allele

listerD5Mit357$numgeno <- as.numeric(listerD5Mit357$geno)
#Approach using three different genetic models
listerD5Mit357$add <- c(0, 0.5, 1)[listerD5Mit357$numgeno]
listerD5Mit357$rec <- c(0, 0, 1)[listerD5Mit357$numgeno]
listerD5Mit357$dom <- c(0, 1, 1)[listerD5Mit357$numgeno]

mdom2 <- coxph(Surv(pheno, cens) ~ dom, data=listerD5Mit357) #lin reg dom
madd2 <- coxph(Surv(pheno, cens) ~ add, data=listerD5Mit357) #lin reg add
mrec2 <- coxph(Surv(pheno, cens) ~ rec, data=listerD5Mit357) #lin reg rec

#simultaneous assessment of multiple marginal models
g <- glht(mmm(m1=mdom2, m2=madd2, m3=mrec2), mlf(m1="dom = 1", m2="add = 1", m3="rec = 1"))
summary(g)
}
\keyword{datasets}
