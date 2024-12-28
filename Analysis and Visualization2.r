install.packages("ggplot2")
install.packages("corrplot")
install.packages("reshape2")
install.packages("e1071")
install.packages("fmsb")
library(fmsb)
library(ggplot2)
library(corrplot)
library(reshape2)
library(e1071)
library(dplyr)


df <- read.csv("D:/AIUB/Summer/DS/StressLevelDataset.csv",header = TRUE,sep = ",")
print(df)
missingValue<- colSums(is.na(df))
missingValue
empty<-colSums(df == "" | df == " ")
empty
total_attributes <- ncol(df)
print(total_attributes)
print(colnames(df))
correlation_matrix <- cor(df, use = "complete.obs")



numerical_columns <- sapply(df, is.numeric)
numerical_df <- df[, numerical_columns]
skewness_values <- sapply(numerical_df, skewness, na.rm = TRUE)
print(skewness_values)









skewness_value <- skewness(df$anxiety_level, na.rm = TRUE)
print(paste("Skewness of Anxiety Level:", round(skewness_value, 2)))
if (skewness_value > 0) {
  print("The data is positively skewed (right-skewed).")
} else if (skewness_value < 0) {
  print("The data is negatively skewed (left-skewed).")
} else {
  print("The data is approximately symmetric.")
}








classify_skewness <- function(skewness_value) {
  if (skewness_value > 0) {
    return("Right Skewed")
  } else if (skewness_value < 0) {
    return("Left Skewed")
  } else {
    return("Normal")
  }
}

generate_histogram_with_skewness <- function(data, attribute_name, binwidth = 1) {
  skewness_value <- skewness(data)
  skew_type <- classify_skewness(skewness_value)
  ggplot(data = data.frame(attribute = data), aes(x = attribute)) +
    geom_histogram(binwidth = binwidth, fill = "lightblue", color = "black") +
    labs(title = paste("Histogram of", attribute_name), x = attribute_name, y = "Frequency") +
    theme_minimal() +
    annotate("text", x = Inf, y = Inf, 
             label = paste("Skewness:", round(skewness_value, 2), "\nType:", skew_type),
             hjust = 1.5, vjust = 2, size = 4, color = "red")
}
generate_histogram_with_skewness(df$anxiety_level, "Anxiety Level")
generate_histogram_with_skewness(df$stress_level, "stress_level")
generate_histogram_with_skewness(df$academic_performance, "Academic Performance")









calculate_mode <- function(data) {
  uniq_data <- unique(data)
  freq_table <- table(data)
  mode_value <- uniq_data[which.max(freq_table)]
  return(mode_value)
}

generate_histogram <- function(data, title) {
  
  
  mean_value <- mean(data)
  median_value <- median(data)
  mode_value <- calculate_mode(data)
  skew_value <- skewness(data)
  skew_type <- ifelse(skew_value > 0, "Right Skewed", ifelse(skew_value < 0, "Left Skewed", "Symmetrical"))
  
  
  ggplot(data = data.frame(data), aes(x = data)) +
    geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black", alpha = 0.7) +
    geom_density(color = "blue", size = 1) +
    geom_vline(aes(xintercept = mean_value), color = "red", linetype = "dashed", size = 1.5) +
    geom_vline(aes(xintercept = median_value), color = "red", linetype = "solid", size = 1.5) +
    geom_vline(aes(xintercept = mode_value), color = "red", linetype = "dotted", size = 1.5) +
    annotate("text", x = mean_value, y = Inf, label = paste("Mean:", round(mean_value, 2)), color = "red", size = 4, vjust = 2) +
    annotate("text", x = median_value, y = Inf, label = paste("Median:", round(median_value, 2)), color = "red", size = 4, vjust = 2) +
    annotate("text", x = mode_value, y = Inf, label = paste("Mode:", round(mode_value, 2)), color = "red", size = 4, vjust = 2) +
    labs(title = paste(title, "\nSkewness:", round(skew_value, 2), "-", skew_type), 
         x = "Value", y = "Density") +
    theme_minimal()
}

generate_histogram(df$anxiety_level, "Distribution of Anxiety Level")
generate_histogram(df$safety, "Distribution of safety")
generate_histogram(df$social_support, "Distribution of social_support")











df <- df %>%
  mutate(stress_level_label = recode(stress_level,
                                     `0` = "Low",
                                     `1` = "Medium",
                                     `2` = "High"))


ggplot(df, aes(x = stress_level_label, fill = stress_level_label)) +
  geom_bar(color = "black") +
  labs(title = "Bar Graph of Stress Level", x = "Stress Level", y = "Count") +
  scale_fill_manual(values = c("Low" = "skyblue", "Medium" = "lightgreen", "High" = "salmon")) +
  theme_minimal()









generate_box_plot <- function(data, attribute_name) {
  ggplot(data, aes(y = .data[[attribute_name]])) +
    geom_boxplot(fill = "lightgreen", color = "black") +
    labs(title = paste("Box Plot of", attribute_name), y = attribute_name) +
    theme_minimal()
}

generate_box_plot(df, "safety")
generate_box_plot(df, "anxiety_level")
generate_box_plot(df, "social_support")



















generate_scatter_plot <- function(data, var1, var2, method = "pearson") {
  correlation_value <- cor(data[[var1]], data[[var2]], use = "complete.obs", method = method)
  correlation_type <- ifelse(correlation_value > 0, "Positive", 
                             ifelse(correlation_value < 0, "Negative", "Zero"))
  cat(paste(method, "Correlation between", var1, "and", var2, "is:", round(correlation_value, 2)), "\n")
  ggplot(data = data, aes(x = .data[[var1]], y = .data[[var2]])) +
    geom_point() +
    geom_smooth(method = 'lm', color = 'blue', se = FALSE) +  # Add regression line
    labs(title = paste("Scatter Plot of", var1, "vs.", var2),
         x = var1,
         y = var2) +
    theme_minimal() + 
    annotate("text", x = Inf, y = Inf, label = paste(method, "Correlation (R):", round(correlation_value, 2)),
             hjust = 1.1, vjust = 1.5, size = 5, color = "red") +
    annotate("text", x = Inf, y = Inf, label = paste("Method:", toupper(method)),
             hjust = 1.1, vjust = 2.5, size = 5, color = "blue") +
    annotate("text", x = Inf, y = Inf, label = paste("Correlation Type:", correlation_type),
             hjust = 1.1, vjust = 3.5, size = 5, color = "green")
}

generate_scatter_plot(df, "anxiety_level", "stress_level", method = "pearson")
generate_scatter_plot(df, "anxiety_level", "stress_level", method = "spearman")

generate_scatter_plot(df, "self_esteem", "academic_performance", method = "pearson")
generate_scatter_plot(df, "self_esteem", "academic_performance", method = "spearman")

generate_scatter_plot(df, "academic_performance", "study_load", method = "pearson")
generate_scatter_plot(df, "academic_performance", "study_load", method = "spearman")


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













df <- df %>%
  mutate(stress_level_label = recode(stress_level,
                                     `0` = "Low",
                                     `1` = "Medium",
                                     `2` = "High"))



generate_violin_plot <- function(data, continuous_var) {
  ggplot(data, aes(x = stress_level_label, y = .data[[continuous_var]])) +
    geom_violin(fill = "lightblue") +
    labs(title = paste("Violin Plot of", continuous_var, "by Stress Level"),
         x = "Stress Level", 
         y = continuous_var) +
    theme_minimal()
}

generate_violin_plot(df, "anxiety_level")
generate_violin_plot(df, "sleep_quality")
generate_violin_plot(df, "extracurricular_activities")












data <- as.data.frame(matrix( sample(2:20 , 10 ,replace=T) ,ncol=5))
colnames(data) <- c("headache", "sleep_quality", "mental_health_history", "depression", "blood_pressure")
data <- rbind(rep(20,5) , rep(0,5) , data)
radarchart(data)














time <- 1:10
data <- data.frame(
  time = time,
  stress_level = sample(10:30, 10, replace = TRUE),
  academic_performance = sample(50:100, 10, replace = TRUE)
)

ggplot(data, aes(x = time)) +
  geom_line(aes(y = stress_level, color = "Stress Level"), size = 1) +
  geom_line(aes(y = academic_performance, color = "Academic Performance"), size = 1) +
  labs(
    title = "Line Graph of Stress Level and Academic Performance Over Time",
    x = "Time",
    y = "Value"
  ) +
  theme_minimal() +
  scale_color_manual(
    values = c("Stress Level" = "blue", "Academic Performance" = "red"),
    name = "Legend"
  ) +
  theme(
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )


