#quick and dirty plotting code for looking at drainage effects on soil moisture

#first run = poorly drained drainage type 0
outdir<-'~/Desktop/pest/allpft_weighted/'
setwd('/tmp/year-cal-dvmdostem/')
library(rjson)

avg.years=10
jsons=dir(pattern='json')
num.files=length(jsons)
last.jsons=jsons[(num.files-avg.years):num.files]

i=10
cmtbgc<-fromJSON(file=last.jsons[i])

#soil pools
carbondeep<-cmtbgc$CarbonDeep
carbonshlw<-cmtbgc$CarbonShallow
carbonmin<-cmtbgc$CarbonMineralSum
organicn<-cmtbgc$OrganicNitrogenSum
availn<-cmtbgc$AvailableNitrogenSum
soil.vals<-c(carbondeep,carbonshlw,carbonmin,organicn,availn)

#pftspecific
pft.nums<-3:6
pft.ids<-paste('PFT',pft.nums,sep='')
num.pfts=length(pft.ids)

soil.vars<-c('CarbonDeep','CarbonShallow','CarbonMineralSum','OrganicNitrogenSum','AvailableNitrogenSum')
pft.vars<-c('GPPAll','NPPAll','VEGCL','VEGCW','VEGCR','VEGCSUM','VEGNL','VEGNW','VEGNR','VEGNSUM','VEGLBLN')

pft.vals.mat<-matrix(0,length(pft.vars),num.pfts)
for(j in 1:num.pfts)
{
  pft=pft.ids[j]
  pft.dat<-cmtbgc[[pft]]
  
  gppall<-pft.dat$GPPAll
  nppall<-pft.dat$NPPAll
  
  vegc.l<-pft.dat$VegCarbon$Leaf
  vegc.w<-pft.dat$VegCarbon$Stem
  vegc.r<-pft.dat$VegCarbon$Root
  vegc.sum<-vegc.l+vegc.w+vegc.r
  
  veg.strn.l<-pft.dat$VegStructuralNitrogen$Leaf
  veg.strn.w<-pft.dat$VegStructuralNitrogen$Stem
  veg.strn.r<-pft.dat$VegStructuralNitrogen$Root
  veg.strn.sum<-veg.strn.l+veg.strn.w+veg.strn.r
  
  veg.lbln<-pft.dat$VegLabileNitrogen
  pft.vals<-c(gppall,nppall,vegc.l,vegc.w,vegc.r,vegc.sum,veg.strn.l,veg.strn.w,veg.strn.r,veg.strn.sum,veg.lbln)
 
  if(length(dim(pft.vals.mat))>1){ 
  pft.vals.mat[,j]=pft.vals} else {
  pft.vals.mat=pft.vals}
}

pft.vars.rep<-rep(pft.vars,num.pfts)
vars<-c(soil.vars,pft.vars.rep)
pft.for.df<-c(rep("",length(soil.vars)),rep(pft.nums,each=length(pft.vars)))
vars.numd=paste(vars,pft.for.df,sep='')

pft.vals.vec<-c(pft.vals.mat)
vals<-c(soil.vals,pft.vals.vec)

obs.vals<-data.frame(Variable=vars.numd,Value=vals)

setwd(outdir)
write.table(obs.vals,'TEM_Pest_Output_w.txt',row.names=FALSE,quote=FALSE,sep=',')






