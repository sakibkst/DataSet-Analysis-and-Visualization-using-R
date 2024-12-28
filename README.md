# DataSet-Analysis-and-Visualization-using-R

This project involves analyzing and visualizing relationships between stress levels and other attributes using statistical methods and graphical representations. It includes correlation analysis, skewness measurement, and various plots to explore the data.

---

## Key Features

### Data Import and Exploration
1. **Dataset Import:**
   - Load the dataset using the `read.csv()` function.
   - Examine attributes and handle missing or empty values.

2. **Exploratory Data Analysis:**
   - Compute correlation matrices.
   - Identify numerical columns for analysis.

### Statistical Measures
1. **Correlation Analysis:**
   - Calculate Pearson and Spearman correlations between variables.
   - Identify variables with the strongest positive and negative correlations to stress levels.

2. **Skewness Measurement:**
   - Assess skewness of numerical variables.
   - Classify distributions as right-skewed, left-skewed, or symmetrical.

3. **Central Tendency Metrics:**
   - Calculate mean, median, and mode.
   - Visualize their relationships using histograms.

---

## Visualizations

### Distribution and Trends
1. **Histograms:**
   - Display distributions of variables with skewness annotations.

2. **Scatter Plots:**
   - Show relationships between pairs of variables.
   - Overlay regression lines with calculated correlation coefficients.

3. **Line Graphs:**
   - Compare trends in stress levels and academic performance over time.

### Group Comparisons
1. **Bar Graphs:**
   - Visualize counts of stress levels categorized as low, medium, and high.

2. **Box Plots:**
   - Highlight variability and outliers for attributes like safety and social support.

3. **Violin Plots:**
   - Show distributions of variables by stress level categories.

### Correlation Matrix
- Generate a heatmap with correlation values between all attributes.

### Advanced Visualizations
1. **Radar Charts:**
   - Represent multiple variables on a single plot.

2. **Interactive Legends:**
   - Add customizable legends for multi-line graphs.

---

## Technical Details
- **Libraries Used:** `ggplot2`, `corrplot`, `reshape2`, `e1071`, `dplyr`, `fmsb`.
- **Statistical Insights:**
  - Skewness classification and visualization.
  - Outlier detection and handling using box plots.
- **Visualization Tools:**
  - Scatter, line, bar, box, violin, and radar charts for comprehensive data representation.

---

## Project Goals
- Explore relationships between stress levels and factors like anxiety, safety, and academic performance.
- Provide statistical insights and visualizations to support data-driven decision-making.

---

## How to Run the Analysis
1. **Load Required Libraries:**
   ```r
   install.packages("ggplot2")
   install.packages("corrplot")
   install.packages("reshape2")
   install.packages("e1071")
   install.packages("fmsb")
   library(ggplot2)
   library(corrplot)
   library(reshape2)
   library(e1071)
   library(dplyr)
   library(fmsb)
   ```

2. **Prepare Data:**
   - Load and clean the dataset.
   - Handle missing or invalid data.

3. **Execute Visualization Functions:**
   - Run scatter plots, correlation heatmaps, and radar charts.
   - Adjust parameters as needed for custom insights.

---

## Potential Enhancements
1. Incorporate interactive plots using `plotly`.
2. Automate outlier detection and removal.
3. Integrate machine learning models for predictive analysis.

 
