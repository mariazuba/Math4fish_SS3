#install and getting the code set up
#require(devtools)
#devtools::install_github('r4ss/r4ss')
library(r4ss)

# setting a working directory, where future paths will be relative to this value
dir <- ("C:\\CursoSS\\Runs\\")
setwd(dir)

# folder name for a SINGLE/ONE model run
readme<-"Anch\\0"

# set path to read in a SINGLE/ONE model run
#note if cover=T you need a hessian; if covar=F you do not need a hessian
tmp <- SS_output(dir=paste0(dir,readme),covar=F)

#plot a SINGLE/ONE model run
#note if uncertainty=T you need a hessian; if uncertainty=F you do not need a hessian
SS_plots(tmp, uncertainty=F)

####################################################################################
################ PLOT MULTIPLE MODEL RUNS TOGETHER ################################
####################################################################################

#MULTIPLE folder names to read in for plotting multiple model runs
base <- 'Anch\\0'
B1 <- 'trimanch\\8'


#PLOT labels, name of each model run
legend.labels <- c('base','B1')

#read in all model runs
#note if cover=T you need a hessian; if covar=F you do not need a hessian
biglist <- SSgetoutput(keyvec = NULL, dirvec = c(base,B1),	getcovar = F)

#create summary of model runs from list above
summaryoutput <- SSsummarize(biglist)

# names of quantities to write to output text file
names <- c("SSB_Unfished","TotBio_Unfished","SmryBio_Unfished","Recr_Unfished","SSB_Btgt",
"SPR_Btgt","Fstd_Btgt","TotYield_Btgt","SSB_SPRtgt","Fstd_SPRtgt","TotYield_SPRtgt",
"SSB_MSY","SPR_MSY","Fstd_MSY","TotYield_MSY","RetYield_MSY","Bratio_2015",
"F_2015", "SPRratio_2015", "Recr_2015", "Recr_Virgin",
"L_at_Amin_Fem_GP_1","L_at_Amax_Fem_GP_1","VonBert_K_Fem_GP_1","CV_young_Fem_GP_1",
"CV_old_Fem_GP_1")

#likelihood component to write to output text file
like <- c("TOTAL","Catch","Equil_catch","Survey",
"Length_comp","Age_comp","Parm_priors")

#write out table of quantities named above (names, like)
TableCompare <- SStableComparisons(summaryoutput,likenames=like,
names=names,modelnames=legend.labels,csv=TRUE,csvdir="workingdirectory",
csvfile="ModelCompare.csv",verbose=FALSE)

#create plots comparing multiple model runs
#note if uncertainty=T you need a hessian; if uncertainty=F you do not need a hessian
#note, the endyrvec is the last year that will be plotted. You may or may not want to
#plot the forecast, the example below is not plotting the forecast. Length of endyrvec
#needs to be equal to or greater than the number of indicies in the model.
SSplotComparisons(summaryoutput,subplots=c(1:13),plot=TRUE,print=T, indexUncertainty=T,
 endyrvec=c(2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015),
 labels=c("Year", "Spawning biomass (mt)", "Spawning depletion", "Age-0 recruits (1,000s)",
 "Recruitment deviations", "Index", "Log index", "Density"),
 uncertainty=F,
 legend=TRUE, legendlabels=legend.labels, legendloc="bottomleft",btarg=0.4, minbthresh=0.10,
 pwidth=7,pheight=7,punits="in",res=300,ptsize=9,cex.main=1,plotdir=dir,
 densitynames=c("SPB_Virgin","SPB_2011","Bratio_2011","Recr_Virgin","TotYield_MSY"),
 densityxlabs=c("B0 (mt)","Spawning Biomass in 2011 (mt)","depletion in 2011",
 "log(R0)","MSY (mt)"))

