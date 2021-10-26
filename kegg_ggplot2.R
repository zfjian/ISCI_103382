rm(list = ls())
setwd("C:\\Users\\Benemae\\Desktop\\project\\胡芳脂质数据\\RNA-seq结果")
library(ggplot2)
pathway = read.csv("EAT.txt",header=TRUE,sep= "\t")
head(pathway)
p = ggplot(pathway,aes(RichFactor,Pathway))
p=p + geom_point()
p=p + geom_point(aes(size=round(Number,0)))

pbubble = p + geom_point(aes(size=round(Number,0),color=Pvalue))

pbubble =pbubble+ scale_colour_gradient(low="green",high="red")

pr = pbubble + scale_colour_gradient(low="green",high="red") +
  theme(axis.text = element_text(face = "bold",size = 10))+
  labs(color=expression(Pvalue),size="Number",x="Rich factor",title="Top pathway enrichment")
pr


