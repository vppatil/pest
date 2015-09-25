#quick and dirty plotting code for looking at drainage effects on soil moisture

#first run = poorly drained drainage type 0
outdir<-'~/Desktop/pest/soilpoolsonly/'
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


soil.vars<-c('CarbonDeep','CarbonShallow','CarbonMineralSum','OrganicNitrogenSum','AvailableNitrogenSum')
vars<-c(soil.vars)
vals<-c(soil.vals)

obs.vals<-data.frame(Variable=vars,Value=vals)

setwd(outdir)
write.table(obs.vals,'TEM_Pest_Output_soilpools.txt',row.names=FALSE,quote=FALSE,sep=',')






