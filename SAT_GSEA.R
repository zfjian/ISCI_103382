rm(list = ls())
###packages##
library(enrichplot)
library(clusterProfiler)
library(IRanges)
library(S4Vectors)
library(grDevices)
library("org.Mm.eg.db")

rt = read.table("SAT.txt",header = T,sep = '\t') ### SAT≤ªø®fc‘Ÿ≤‚ ‘“ª±È## 
x = rt$gene_id
###GSEA plot for mimic the plot ###
eg <- bitr(x, 
           fromType="SYMBOL", 
           toType=c("ENTREZID","ENSEMBL",'SYMBOL'),
           OrgDb="org.Mm.eg.db")
head(eg)
#merge(eg$ENTREZID)
rt = rt[rt$gene_id %in% eg$SYMBOL,]
all = merge(rt,eg, by.x = "gene_id",by.y = "SYMBOL")
gsea_input = all$log2FoldChange
names(gsea_input)= as.character(all$ENTREZID)
gsea_input = sort(gsea_input,decreasing = TRUE)
gseKEGG.res <- gseKEGG(gsea_input, organism = 'mmu',keyType = "kegg")

gseaplot2(gseKEGG.res, geneSetID = 4, pvalue_table = TRUE,rel_heights = c(1.5, 0.5, 1.1),title = gseKEGG.res$Description[4])
ridgeplot(gseKEGG.res)
A = as.data.frame(gseKEGG.res@result)
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("pathview")

#library("pathview")
library("pathview")
mmu04020<- pathview(gene.data  = geneList,
                     pathway.id = "mmu04020",
                     species    = "mmu",
                     limit      = list(gene=max(abs(gsea_input)), cpd=1))
