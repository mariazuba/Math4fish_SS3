## installing and getting the code set up
#devtools::install_github("r4ss/r4ss")
#install.packages('r4ss') # download package, same as using menu in Rgui
library(r4ss) # load package into current session
dir <- "C://MATH4FISH//GITLAB_SS3_boqueron//quarter//10a_anchcadiz"
setwd(dir)

#case <- "10a_anchcadiz"

#THIS EXAMPLE PLOTS A SINGLE RUN
tmp <- SS_output(dir=dir,covar=F,forecast=F, ncols=211) 
SS_plots(tmp, uncertainty=F,datplot = F, png=T, aalresids = F,btarg=0.60, minbthresh=0.25, forecast=F)

