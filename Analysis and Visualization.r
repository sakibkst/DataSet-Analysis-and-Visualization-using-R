install.packages("ggplot2")
install.packages("corrplot")
install.packages("reshape2")
library(ggplot2)
library(corrplot)
library(reshape2)


df <- read.csv("D:/AIUB/Summer/DS/StressLevelDataset.csv",header = TRUE,sep = ",")
print(df)
total_attributes <- ncol(df)
print(total_attributes)





correlation_matrix <- cor(df, use = "complete.obs")
melted_corr <- melt(correlation_matrix)
print(melted_corr)

stress_corr <- melted_corr[((melted_corr$Var1 == 'stress_level') | (melted_corr$Var2 == 'stress_level')) &
                             (melted_corr$Var1 != melted_corr$Var2), ]


max_positive_stress_corr <- stress_corr[which.max(stress_corr$value), ]


max_negative_stress_corr <- stress_corr[which.min(stress_corr$value), ]


cat("Max Positive Correlation with Stress Level:\n")
print(max_positive_stress_corr)

cat("\nMax Negative Correlation with Stress Level:\n")
print(max_negative_stress_corr)





var1 <- 'anxiety_level'
var2 <- 'stress_level'



data_subset <- df[, c(var1, var2)]


correlation_value <- cor(data_subset[[var1]], data_subset[[var2]], use = "complete.obs")


print(paste("Correlation between", var1, "and", var2, "is:", round(correlation_value, 2)))

ggplot(data = df, aes(x = .data[[var1]], y = .data[[var2]])) +
  geom_point() +
  geom_smooth(method = 'lm', color = 'blue', se = FALSE) +
  labs(title = paste("regression line & Scatter Plot of", var1, "vs.", var2,"Positive Correlation"),
       x = var1,
       y = var2) +
  theme_minimal()







var1 <- 'self_esteem'
var2 <- 'stress_level'

data_subset <- df[, c(var1, var2)]


correlation_value <- cor(data_subset[[var1]], data_subset[[var2]], use = "complete.obs")


print(paste("Correlation between", var1, "and", var2, "is:", round(correlation_value, 2)))

ggplot(data = df, aes(x = .data[[var1]], y = .data[[var2]])) +
  geom_point() +  
  geom_smooth(method = 'lm', color = 'blue', se = FALSE) +
  labs(title = paste("regression line & Scatter Plot of", var1, "vs.", var2 ,"(Negative Correlation)"),
       x = var1,
       y = var2) +
  theme_minimal()











corrplot(correlation_matrix, method = 'color', type = 'upper', 
         tl.col = 'black', tl.srt = 45, addCoef.col = 'black',
         col=colorRampPalette(c("blue", "white", "red"))(200))



melted_corr <- melt(correlation_matrix)
ggplot(data = melted_corr, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(value, 2)), color = "black", size = 3) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), space = "Lab", 
                       name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
  labs(title = "Correlation Matrix", x = "Attributes", y = "Attributes")
