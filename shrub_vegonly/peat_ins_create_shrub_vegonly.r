
vars<-c('GPPALL','NPPALL','VEGCL','VEGCW','VEGCR','VEGCSUM',
'VEGNL','VEGNW','VEGNR','VEGNSUM','VEGLBLN')
pft.nums<-0:8

pft.ids=paste('l1 @,@ !',sep='')

p.num.rep=rep(pft.nums,each=length(vars))
vars.rep=rep(vars,length(pft.ids))
vars.rep=paste(vars.rep,p.num.rep,"!",sep='')

lines<-paste("l2 @,@ !",vars.rep[1],sep="")
lines<-c(lines,paste("l1 @,@ !",vars.rep[2:length(vars.rep)],sep=""))

firstline="pif @"

file=cbind(c(firstline,lines))
print(file)
write.table(file,"tem_shrub_vegonly.ins",row.names=FALSE,col.names=FALSE,quote=FALSE)

