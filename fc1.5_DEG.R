
#setwd("C:\\Users\\Benemae\\Desktop\\project\\code")
setwd("C:\\Users\\Benemae\\Desktop\\project\\code") ## path 
group1 <- read.delim('BAT_FC1.5.txt', sep = '\t')
group2 <- read.delim('EAT_FC1.5.txt', sep = '\t')
group3 <- read.delim('SAT_FC1.5.txt', sep = '\t')
#绘制Venn+饼图
#install.packages('GOplot')
library(GOplot)
venn <- GOVenn(group1, group2, group3, #3组基因列表
               label = c('BAT_BN vs veh', 'EAT_BN vs veh', 'SAT_BN vs veh'), #3组名称
               
               circle.col = c('purple', 'green', 'yellow'), #3组圈图颜色
               
               lfc.col = c('red', 'grey', 'green4'), #上调基因、趋势相反基因和下调基因的颜色
               
               plot = FALSE) #plot=FALSE时，出图的同时输出交集统计信息

venn
group_only  = rbind(venn$table$A_only,venn$table$B_only,venn$table$C_only)
#write.table(group_only,file = "group_only.txt",sep= "\t")
#write.table(venn$table$AC,file = "BAT_SAT_overlap.txt",sep= "\t")
#write.table(venn$table$AB,file = "BAT_EAT_overlap.txt",sep = "\t")
#write.table(venn$table$BC,file = "EAT_SAT_overlap.txt",sep = "\t")
#write.table(venn$table$ABC,file = "overlap.txt",sep = "\t")