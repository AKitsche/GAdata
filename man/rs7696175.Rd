\name{rs7696175}
\alias{rs7696175}
\docType{data}
\title{
SNP rs7696175 from a GWA study of breast cancer
}
\description{
SNP rs7696175 that was identified to be significant associated of postmenopausal invasive breast
cancer by Hunter et al. (2007).
}
\usage{data("rs7696175")}
\format{
  A data frame with 2286 observations on the following two variables:
  \describe{
    \item{\code{y}}{a factor with levels \code{Cases} \code{Controls}}
    \item{\code{Genotype}}{a factor with levels \code{AA} \code{Aa} \code{aa}}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
Hunter, D. J., Kraft, P., Jacobs, K. B., Cox, D. G., Yeager, M., Hankinson, S. E., Wacholder,
S., Wang, Z., Welch, R., Hutchinson, A., Wang, J., Yu, K., Chatterjee, N., Orr, N., Willett,
W. C., Colditz, G. a., Ziegler, R. G., Berg, C. D., Buys, S. S., McCarty, C. a., Feigelson, H. S.,
Calle, E. E., Thun, M. J., Hayes, R. B., Tucker, M., Gerhard, D. S., Fraumeni, J. F., Hoover,
R. N., Thomas, G., and Chanock, S. J. (2007). A genome-wide association study identifies alleles
in FGFR2 associated with risk of sporadic postmenopausal breast cancer. Nature Genetics,
39(7):870–874.
}
\examples{
data(rs7696175)

rs7696175$GenNum <- as.numeric(rs7696175$Genotype)
rs7696175$Add <- c(0, 0.5, 1)[rs7696175$GenNum]
rs7696175$Dom <- c(0, 1, 1)[rs7696175$GenNum]
rs7696175$Rec <- c(0, 0, 1)[rs7696175$GenNum]
rs7696175$OverDom <- c(0, 1, 0)[rs7696175$GenNum]

#analysis using mmm
GLMdom <- glm(y ~ Dom ,family=binomial, data=rs7696175)
GLMadd <- glm(y ~ Add ,family=binomial, data=rs7696175)
GLMrec <- glm(y ~ Rec ,family=binomial, data=rs7696175)
GLMover <- glm(y ~ OverDom ,family=binomial, data=rs7696175)

library(multcomp)
MultTest <- glht(mmm(m1=GLMdom, m2=GLMadd, m3=GLMrec, m4=GLMover), mlf(m1="Dom=0", m2="Add=0", m3="Rec=0", m4="OverDom=0"))
ResultMMM <-summary(MultTest)
ResultMMM
ResultMMM$test$pvalues

}
\keyword{datasets}
