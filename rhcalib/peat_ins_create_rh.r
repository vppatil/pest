outdir='~/Desktop/pest/rhcalib/'

setwd(outdir)
soil.vars<-c('CarbonDeep','CarbonShallow','CarbonMinSum',
	'OrganicNSum','AvailableNSum','RH')

vars<-c('GPPALL','NPPALL','VEGCL','VEGCW','VEGCR','VEGCSUM',
'VEGNL','VEGNW','VEGNR','VEGNSUM','VEGLBLN')
pft.nums<-3:6

pft.ids=paste('l1 @,@ !',sep='')

pft.ids.rep<-rep(pft.ids,each=length(vars))

p.num.rep=rep(pft.nums,each=length(vars))
vars.rep=rep(vars,length(pft.ids))
vars.rep=paste(vars.rep,p.num.rep,"!",sep='')

lines<-paste(pft.ids.rep,vars.rep,sep='')

soil.lines<-paste("l2 @,@ !",soil.vars[1],"!",sep="")
soil.lines<-c(soil.lines,paste("l1 @,@ !",soil.vars[2:length(soil.vars)],"!",sep=""))

firstline="pif @"

file=cbind(c(firstline,soil.lines,lines))
print(file)
write.table(file,"tem_rh.ins",row.names=FALSE,col.names=FALSE,quote=FALSE)

