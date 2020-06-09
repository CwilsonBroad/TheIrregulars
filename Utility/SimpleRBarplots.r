#load libraries
library(tidyverse)

#Create the columns: 
contstruct <- c("M3", "M3M14") 
value_Km <- c(900, 18)
SD_Km <- c(0, 1.76)
value_kcat <- c(8.6, 24)
SD_kcat <- c(1.11, 0.5)
fill <- c("M3", "M3M14")

#Create dataframe:
df_Km <- data.frame(contstruct, value_Km, SD_Km, fill)
df_kcat <- data.frame(contstruct, value_kcat, SD_kcat, fill)

#Create ggplot: 
p <- ggplot(df_Km, aes(x=df_Km$contstruct, y=df_Km$value_Km, fill=fill)) +
  geom_bar(stat = "identity", color="black", position = position_dodge()) +
  geom_errorbar(aes(ymin=value_Km-SD_Km, ymax=value_Km+SD_Km), width=.2,
                position=position_dodge(.9))

#Finished bar plot:
p+labs(title = "Km", x="Construct", y ="[Substrate]/nM") + 
  theme_linedraw() +
  scale_fill_manual(values = c('#F69017', "#23A8E1"))

print(p)

p <- ggplot(df_kcat, aes(x=df_kcat$contstruct, y=df_kcat$value_kcat, fill=fill)) +
  geom_bar(stat = "identity", color="black", position = position_dodge()) +
  geom_errorbar(aes(ymin=value_kcat-SD_kcat, ymax=value_kcat+SD_kcat), width=.2,
                position=position_dodge(.9))

#Finished bar plot:
p+labs(title = "Vmax", x="Construct", y ="h^-1") + 
  theme_linedraw() +
  scale_fill_manual(values = c('#F69017', "#23A8E1"))

print(p)

#Calculate the fold changes:
Km_FoldChange=df_Km[1,2]/df_Km[2,2]
Vmax_FoldChange=df_kcat[2,2]/df_kcat[1,2]

#Create dataframe containing the fold changes. 
construct_foldchange <- c("Km", "Vmax")
value_foldchange <- c(Km_FoldChange, Vmax_FoldChange)
fill_foldchange <- c("Km", "Vmax")

df_foldchange <- data.frame(construct_foldchange, value_foldchange, fill_foldchange)

#Create the plot

p <- ggplot(df_foldchange, aes(x=df_foldchange$construct_foldchange, y=df_foldchange$value_foldchange, fill=fill_foldchange)) +
  geom_bar(stat = "identity", color="black", position = position_dodge())

p+labs(title = "Fold Changes", y ="Fold Change") + 
  theme_linedraw() +
  scale_fill_manual(values = c('#006600', "#990099"))

print(p)
