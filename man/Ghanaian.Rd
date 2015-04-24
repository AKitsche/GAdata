\name{Ghanaian}
\alias{Ghanaian}
\docType{data}
\title{
Case-control study - Ghanaian group
}
\description{
Case-control study of severe falciparum malaria for association with the SNP rs10900589 of the ATPase, Capp transporting, plasma membrane 4 (ATP2B4) gene. The data set contains the data from the Ghanaian group.
}
\usage{data(Ghanaian)}
\format{
  A data frame with 2147 observations on the following 5 variables.
  \describe{
    \item{\code{y}}{a factor with levels \code{Cases} \code{Control}}
    \item{\code{x0}}{a numeric vector, dummy coding for homozygous T}
    \item{\code{x1}}{a numeric vector, dummy coding for heterozygous}
    \item{\code{x2}}{a numeric vector, dummy coding for homozygous G}
    \item{\code{Genotype}}{a factor with levels \code{GG} \code{GT} \code{TT}}
  }
}
\details{
}
\source{
Timmann C, Thye T, Vens M et al: Genome-wide association study indicates two novel resistance loci for severe malaria. Nature 2012; 489: 443-446.
}
\references{
C. Loley, I.R Koenig, L. Hothorn, and A. Ziegler. A unifying framework for robust association testing, estimation, and genetic model selection using the generalized linear model. European Journal of Human Genetics, 21(12):1442-1448, 2013.
}
\examples{
data(Ghanaian)
head(Ghanaian)
with(Ghanaian, table(y, Genotype))

#graphical display
mosaicplot(with(Ghanaian, table(y, Genotype)),main="")

#calculating minor allele frequency
sum(Ghanaian[,3],2*Ghanaian[,4])/(2*nrow(Ghanaian))
#in this case "G" is the minor allele
Ghanaian$Genotype <- factor(Ghanaian$Genotype, levels=c("TT","GT","GG"))
Ghanaian$GenNum <- as.numeric(Ghanaian$Genotype)

#pseudo numeric variables for different modes of inheritance
Ghanaian$Add <- c(0, 0.5, 1)[Ghanaian$GenNum]
Ghanaian$Dom <- c(0, 1, 1)[Ghanaian$GenNum]
Ghanaian$Rec <- c(0, 0, 1)[Ghanaian$GenNum]

#Approach using three different genetic models
GLMdom <- glm(y ~ Dom ,family=binomial, data=Ghanaian)
GLMadd <- glm(y ~ Add ,family=binomial, data=Ghanaian)
GLMrec <- glm(y ~ Rec ,family=binomial, data=Ghanaian)

#simultaneous assessment of multiple marginal models
g <- glht(mmm(m1=GLMdom, m2=GLMadd, m3=GLMrec), mlf(m1="Dom=0", m2="Add=0", m3="Rec=0"))
summary(g)
summary(g)$test$pvalues
}
\keyword{datasets}
