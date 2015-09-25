soil.vars<-c('CarbonDeep','CarbonShallow','CarbonMinSum',
	'OrganicNSum','AvailableNSum')


soil.lines<-paste("l2 @,@ !",soil.vars[1],"!",sep="")
soil.lines<-c(soil.lines,paste("l1 @,@ !",soil.vars[2:length(soil.vars)],"!",sep=""))

firstline="pif @"

file=cbind(c(firstline,soil.lines))
print(file)
write.table(file,"tem_soilpools.ins",row.names=FALSE,col.names=FALSE,quote=FALSE)

