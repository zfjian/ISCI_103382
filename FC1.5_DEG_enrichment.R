rm(list = ls())
#首先读入基因列表
setwd("C:\\Users\\Benemae\\Desktop\\project\\code")
#rt = read.table('BAT_FC1.5.txt',header = T,sep = '\t')
rt = read.table("EAT_FC2.txt",header = T,sep = '\t')
rt = read.table("SAT_FC2.txt",header = T,sep = '\t')
head(rt)
x = rt$gene_id
##mouse## 
library(clusterProfiler)
library(IRanges)
library(S4Vectors)
library(grDevices)
library("org.Mm.eg.db")
#library(help = "org.Mm.eg.db")
#bitr函数进行id转换，使用的是bioconductor的db系列包
# fromType和toType包括："ACCNUM, ALIAS, ENSEMBL, ENSEMBLPROT, ENSEMBLTRANS, ENTREZID, 
# ENZYME, EVIDENCE, EVIDENCEALL, GENENAME, GO, GOALL, IPI, MAP, OMIM, ONTOLOGY, 
# ONTOLOGYALL, PATH, PFAM, PMID, PROSITE, REFSEQ, SYMBOL, UCSCKG, UNIGENE, UNIPROT"
eg <- bitr(x, 
           fromType="SYMBOL", 
           toType=c("ENTREZID","ENSEMBL",'SYMBOL'),
           OrgDb="org.Mm.eg.db")
head(eg)


#kegg富集
#使用enrichKEGG函数，同样建议使用ENTREZID id
# Multiple samples KEGG analysis
#使用enrichKEGG函数，同样建议使用ENTREZID id
kegg <- enrichKEGG(eg$ENTREZID, 
                   organism = 'mmu',  ## hsa为人的简写，bta是牛的简写  ## mmu##
                   keyType = 'kegg', 
                   pvalueCutoff = 0.05,
                   pAdjustMethod = 'fdr', 
                   minGSSize = 3,
                   maxGSSize = 500,
                   qvalueCutoff = 0.2)
head(kegg)
library(org.Mm.eg.db)
ego3=as.data.frame(kegg)
ensembl=strsplit(ego3$geneID,"/")
head(ensembl)
symbol=sapply(ensembl,function(x){
  y=bitr(x, fromType="ENTREZID", toType="SYMBOL", OrgDb="org.Mm.eg.db")
  #一对多，取第一个
  y=y[!duplicated(y$ENTREZID),-1]
  y=paste(y,collapse = "/")
})
ego3$geneID=symbol
ego3
write.table(ego3,file = "EAT_FC1.5_pathwayenrich.txt",sep = "\t")
###########

#可视化，和上面的一样
dotplot(kegg, showCategory=20) #气泡图
barplot(kegg,showCategory=20,drop=T) #柱状图
cnetplot(kegg, foldChange=geneList) #网络图
heatplot(kegg) #热力图

