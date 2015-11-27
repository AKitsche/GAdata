\name{Depression}
\alias{Depression}
\docType{data}
\title{
Association study on depressive symptoms at follow-up.
}
\description{
Genome-wide association studies have reported an association between the SNP rs1006737 within the CACNA1C gene and nine psychiatric
disorders: i) dispositional optimism, ii) anger suppression, iii) perceived
social support, vi) depression (Zerssen), v) psychoticism, vi) extraversion, vii) neuroticism,
viii) sense of coherence, and ix) depressive symptoms at follow-up..
}
\usage{data("Depression")}
\format{
  A data frame with 3793 observations on the following 16 variables.
  \describe{
    \item{\code{ID}}{a numeric vector}
    \item{\code{GEBURT}}{a numeric vector}
    \item{\code{Age}}{a numeric vector}
    \item{\code{sex}}{a numeric vector}
    \item{\code{geno}}{a numeric vector}
    \item{\code{LOT}}{Dispositional optimism}
    \item{\code{Al}}{Anger suppression}
    \item{\code{SozU}}{Perceived social support}
    \item{\code{D}}{Depression (Zerssen)}
    \item{\code{P}}{Psychoticism}
    \item{\code{E}}{Extraversion}
    \item{\code{N}}{Neuroticism}
    \item{\code{SOC}}{Sense of coherence}
    \item{\code{DS}}{Depressive symptoms at follow-up}
    \item{\code{Genotyp}}{a factor with levels \code{AA} \code{AG} \code{GG}}
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
#############################################################
#######    Analysis count phenotype             #############
#############################################################
data(Depression)
Depression <- Depression[Depression$Gender=="males",]

#generating numerical dummy variables
Depression$numgeno <- as.numeric(Depression$Genotyp)
#Approach using three different genetic models
Depression$add <- c(0, 0.5, 1)[Depression$numgeno]
Depression$rec <- c(0, 0, 1)[Depression$numgeno]
Depression$dom <- c(0, 1, 1)[Depression$numgeno]


#Fitting the three Poisson regression models
GLMdomDS <- glm(D ~ dom ,family=poisson, data=Depression)
GLMaddDS <- glm(D ~ add ,family=poisson, data=Depression)
GLMrecDS <- glm(D ~ rec ,family=poisson, data=Depression)
#simultaneous assessment of multiple marginal models
g <- glht(mmm(m1=GLMdomDS, m2=GLMaddDS, m3=GLMrecDS),
          mlf(m1="dom=0", m2="add=0", m3="rec=0"))
summary_g <- summary(g)#multiplicity adjusted p-values


##############################################################
#######   Analysis of plaiotropic effects             ########
##############################################################

data(Depression)
Depression <- Depression[Depression$Gender=="females",]
Depression$Genotyp <- factor(Depression$Genotyp, levels=c("GG","AG","AA"))

#generating numerical dummy variables
Depression$numgeno <- as.numeric(Depression$Genotyp)
#Approach using three different genetic models
Depression$add <- c(0, 0.5, 1)[Depression$numgeno]
Depression$rec <- c(0, 0, 1)[Depression$numgeno]
Depression$dom <- c(0, 1, 1)[Depression$numgeno]

#fitting the poisson regression models
#LOTsum
GLMdomLOT <- glm(LOT ~ dom ,family=poisson, data=Depression)
GLMaddLOT <- glm(LOT ~ add ,family=poisson, data=Depression)
GLMrecLOT <- glm(LOT ~ rec ,family=poisson, data=Depression)
#LOTsum
GLMdomAl <- glm(Al ~ dom ,family=poisson, data=Depression)
GLMaddAl <- glm(Al ~ add ,family=poisson, data=Depression)
GLMrecAl <- glm(Al ~ rec ,family=poisson, data=Depression)
#SOZUsum
GLMdomSozU <- glm(SozU ~ dom ,family=poisson, data=Depression)
GLMaddSozU <- glm(SozU ~ add ,family=poisson, data=Depression)
GLMrecSozU <- glm(SozU ~ rec ,family=poisson, data=Depression)

#D
GLMdomD <- glm(D ~ dom ,family=poisson, data=Depression)
GLMaddD <- glm(D ~ add ,family=poisson, data=Depression)
GLMrecD <- glm(D ~ rec ,family=poisson, data=Depression)
#P
GLMdomP <- glm(P ~ dom ,family=poisson, data=Depression)
GLMaddP <- glm(P ~ add ,family=poisson, data=Depression)
GLMrecP <- glm(P ~ rec ,family=poisson, data=Depression)
#E
GLMdomE <- glm(E ~ dom ,family=poisson, data=Depression)
GLMaddE <- glm(E ~ add ,family=poisson, data=Depression)
GLMrecE <- glm(E ~ rec ,family=poisson, data=Depression)

#N
GLMdomN <- glm(N ~ dom ,family=poisson, data=Depression)
GLMaddN <- glm(N ~ add ,family=poisson, data=Depression)
GLMrecN <- glm(N ~ rec ,family=poisson, data=Depression)
#SOC
GLMdomSOC <- lm(SOC ~ dom ,data=Depression)
GLMaddSOC <- lm(SOC ~ add ,data=Depression)
GLMrecSOC <- lm(SOC ~ rec ,data=Depression)
#DS
GLMdomDS <- glm(DS ~ dom ,family=poisson, data=Depression)
GLMaddDS <- glm(DS ~ add ,family=poisson, data=Depression)
GLMrecDS <- glm(DS ~ rec ,family=poisson, data=Depression)

library(multcomp)
MultTest <- glht(mmm(m1=GLMdomLOT, m2=GLMaddLOT, m3=GLMrecLOT,
                     m4=GLMdomAl, m5=GLMaddAl, m6=GLMrecAl,
                     m7=GLMdomSozU, m8=GLMaddSozU, m9=GLMrecSozU,
                     m10=GLMdomD, m11=GLMaddD, m12=GLMrecD,
                     m13=GLMdomP, m14=GLMaddP, m15=GLMrecP,
                     m16=GLMdomE, m17=GLMaddE, m18=GLMrecE,
                     m19=GLMdomN, m20=GLMaddN, m21=GLMrecN,
                     m22=GLMdomSOC, m23=GLMaddSOC, m24=GLMrecSOC,
                     m25=GLMdomDS, m26=GLMaddDS, m27=GLMrecDS), 
                 mlf(m1="dom=0", m2="add=0", m3="rec=0",
                     m4="dom=0", m5="add=0", m6="rec=0",
                     m7="dom=0", m8="add=0", m9="rec=0",
                     m10="dom=0", m11="add=0", m12="rec=0",
                     m13="dom=0", m14="add=0", m15="rec=0",
                     m16="dom=0", m17="add=0", m18="rec=0",
                     m19="dom=0", m20="add=0", m21="rec=0",
                     m22="dom=0", m23="add=0", m24="rec=0",
                     m25="dom=0", m26="add=0", m27="rec=0"))
ResultMMM <-summary(MultTest)

Results <- data.frame(Estimate =ResultMMM[[9]]$coefficients,
                      Std.Error = ResultMMM[[9]]$sigma,
                      TestStat = ResultMMM[[9]]$tstat,
                      PValue = ResultMMM[[9]]$pvalues)
rownames(Results) <- paste(rep(c("dom","add","rec"),times=9), 
                           rep(c("dispositional optimism",
                                 "anger suppression",
                                 "perceived social support",
                                 "depression (Zerssen)",
                                 "psychoticism",
                                 "extraversion",
                                 "neuroticism",
                                 "sense of coherence",
                                 "depressive symptoms at follow-up"), each=3))
colnames(Results) <- c("Estimate", "Std. Error", "t value", "Pr(>|t|)")
Results


#################################################################
########    Analysis Gender-specific mode of inheritance  #######
#################################################################
# Building subsets with males and females
data(Depression)

#generating numerical dummy variables
Depression$numgeno <- as.numeric(Depression$Genotyp)

#Approach using three different genetic models
Depression$add <- c(0, 0.5, 1)[Depression$numgeno]
Depression$rec <- c(0, 0, 1)[Depression$numgeno]
Depression$dom <- c(0, 1, 1)[Depression$numgeno]

#generate sex specific outcome variables
Depression$SozUfemales <- Depression$SozUmales <- Depression$SozU
Depression[Depression$Gender=="males", "SozUfemales"] <- NA
Depression[Depression$Gender=="females", "SozUmales"] <- NA

# Builing genetic model for each subset and mode of inheritance
# Fitting regression models for all observations
domAll <- glm(SozU ~ dom ,family=poisson, data=Depression)
addAll <- glm(SozU ~ add ,family=poisson, data=Depression)
recAll <- glm(SozU ~ rec ,family=poisson, data=Depression)

# Fitting regression models for females
domFemale <- glm(SozUfemales ~ dom ,family=poisson, na.action = na.exclude, data=Depression)
addFemale <- glm(SozUfemales ~ add ,family=poisson, na.action = na.exclude, data=Depression)
recFemale <- glm(SozUfemales ~ rec ,family=poisson, na.action = na.exclude, data=Depression)

# Fitting regression models for males
domMale <- glm(SozUmales ~ dom ,family=poisson, na.action = na.exclude, data=Depression)
addMale <- glm(SozUmales ~ add ,family=poisson, na.action = na.exclude, data=Depression)
recMale <- glm(SozUmales ~ rec ,family=poisson, na.action = na.exclude, data=Depression)

# Simultaneous assessing all marginal models
g <- glht(mmm(m1=domAll, m2=addAll, m3=recAll,
              m4=domFemale, m5=addFemale, m6=recFemale,
              m7=domMale, m8=addMale, m9=recMale),
          mlf(m1="dom=0", m2="add=0", m3="rec=0",
              m4="dom=0", m5="add=0", m6="rec=0",
              m7="dom=0", m8="add=0", m9="rec=0"))
summary(g)#multiplicity adjusted p-values

#################################################################
########    Analysis using non-paramteric procedures      #######
#################################################################
data(Depression)
Depression <- Depression[Depression$Gender=="females",]
Depression$numgeno <- as.numeric(Depression$Genotyp)
Depression$add <- c(0, 0.5, 1)[Depression$numgeno]
Depression$rec <- c(0, 0, 1)[Depression$numgeno]
Depression$dom <- c(0, 1, 1)[Depression$numgeno]

Depression$rD <- rank(Depression$SOC)
library(coin)
Depression$iD <- normal_trafo(Depression$SOC)
RdomS <- lm(rD ~ dom , data=Depression)
RaddS <- lm(rD ~ add , data=Depression)
RrecS <- lm(rD ~ rec , data=Depression)
IdomS <- lm(iD ~ dom , data=Depression)
IaddS <- lm(iD ~ add , data=Depression)
IrecS <- lm(iD ~ rec , data=Depression)

library(multcomp)
npTest <- glht(mmm(m1=RdomS, m2=RaddS, m3=RrecS),
               mlf(m1="dom=0", m2="add=0", m3="rec=0"))
summary(npTest)
invTest <- glht(mmm(m1=IdomS, m2=IaddS, m3=IrecS),
                mlf(m1="dom=0", m2="add=0", m3="rec=0"))
summary(invTest)
both <- glht(mmm(m1 = IdomS, m2 = IaddS, m3 = IrecS,
                 m4 = RdomS, m5 = RaddS, m6 = RrecS),
             mlf(m1 = "dom = 0", m2 = "add = 0", m3 = "rec = 0", 
                 m4 = "dom = 0", m5 = "add = 0", m6 = "rec = 0"))
summary(both)

}
\keyword{datasets}
