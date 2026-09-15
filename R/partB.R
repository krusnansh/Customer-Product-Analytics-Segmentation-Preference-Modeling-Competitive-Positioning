# Part B

library(tidyverse)
library(readxl)

# Create output folder
if (!dir.exists("plots_part_b")) {
  dir.create("plots_part_b")
}

# 1 CONJOINT ANALYSIS

# Load conjoint datasets
profiles_b = read_excel("Product-Profiles-A2.xlsx")
prefs_b = read_excel("Conjoint-Preferences-A2.xlsx")

# Convert variables into correct formats
conjoint_df = profiles_b %>%
  mutate(
    Price = as.numeric(Price),
    Brand = as.factor(Brand),
    Horsepower = as.factor(Horsepower),
    Color = as.factor(Color),
    Sunroof = as.factor(Sunroof)
  )

# Create lists for utilities and importance
pw_list = list()
importance_list = list()

# Run conjoint model for each respondent
for (i in 2:16) {
  
  resp_name = colnames(prefs_b)[i]
  resp_ratings = prefs_b[[i]]
  
  # Estimate part-worth utilities
  fit = lm(
    resp_ratings ~ Price + Brand + Horsepower + Color + Sunroof,
    data = conjoint_df
  )
  
  coeffs = coef(fit)
  
  # Store respondent coefficients
  pw_list[[resp_name]] = coeffs
  
  # Calculate utility range for price
  p_range = abs(
    coeffs["Price"] *
      (max(conjoint_df$Price) - min(conjoint_df$Price))
  )
  
  # Calculate utility range for brand
  b_range = max(c(0,
                  coeffs[grep("Brand", names(coeffs))])) -
    min(c(0,
          coeffs[grep("Brand", names(coeffs))]))
  
  # Calculate utility range for horsepower
  h_range = max(c(0,
                  coeffs[grep("Horsepower", names(coeffs))])) -
    min(c(0,
          coeffs[grep("Horsepower", names(coeffs))]))
  
  # Calculate utility range for color
  c_range = max(c(0,
                  coeffs[grep("Color", names(coeffs))])) -
    min(c(0,
          coeffs[grep("Color", names(coeffs))]))
  
  # Calculate utility range for sunroof
  s_range = max(c(0,
                  coeffs[grep("Sunroof", names(coeffs))])) -
    min(c(0,
          coeffs[grep("Sunroof", names(coeffs))]))
  
  # Compute total utility range
  total_r = p_range + b_range + h_range + c_range + s_range
  
  # Calculate attribute importance percentages
  importance_list[[resp_name]] =
    c(
      Price = p_range,
      Brand = b_range,
      HP = h_range,
      Color = c_range,
      Sunroof = s_range
    ) / total_r
}

# Combine all respondent utilities
partworth_table = do.call(cbind, pw_list)

# Export part-worth utilities
write.csv(
  partworth_table,
  "plots_part_b/PartWorth_Utilities.csv"
)

# Average Willingness to Pay (WTP)

# Compute average utilities
avg_coeffs = rowMeans(do.call(cbind, pw_list))

# Estimate price sensitivity
price_sensitivity = abs(avg_coeffs["Price"])

# Calculate willingness to pay
wtp_values = avg_coeffs / price_sensitivity

# Create average utility table
avg_partworths = data.frame(
  Attribute_Level = names(avg_coeffs),
  Average_Utility = round(avg_coeffs, 3)
)

# Export average utilities
write.csv(
  avg_partworths,
  "plots_part_b/Average_PartWorths.csv",
  row.names = FALSE
)

# Combine respondent importance scores
importance_df = as.data.frame(do.call(cbind, importance_list))

# Calculate average attribute importance
avg_importance = rowMeans(importance_df)

# Create attribute importance table
importance_output = data.frame(
  Attribute = names(avg_importance),
  Importance_Percentage = round(avg_importance * 100, 2)
)

# Export attribute importance
write.csv(
  importance_output,
  "plots_part_b/Attribute_Importance.csv",
  row.names = FALSE
)

# Generate WTP visualization
jpeg(
  "plots_part_b/Conjoint_WTP_Analysis.jpg",
  width = 800,
  height = 600
)

# Plot willingness to pay values
barplot(
  wtp_values[3:length(wtp_values)],
  las = 2,
  main = "Willingness to Pay per Attribute Level",
  col = "darkgreen"
)

dev.off()

# Market Share Prediction

# Create competitor market profiles
market_scenario = data.frame(
  Brand = c(
    "Volkswagen",
    "Toyota",
    "Saturn",
    "Kia"
  ),
  
  Price = c(
    27000,
    27000,
    29000,
    23000
  ),
  
  Horsepower = as.factor(
    c(220, 250, 280, 220)
  ),
  
  Color = as.factor(
    c("Blue", "Red", "Green", "Blue")
  ),
  
  Sunroof = as.factor(
    c("No", "No", "No", "No")
  )
)

# Create prediction matrix
pref_matrix = matrix(
  0,
  nrow = 15,
  ncol = 4
)

# Predict preference scores
for(i in 1:15){
  
  resp_name = colnames(prefs_b)[i + 1]
  
  temp_model = lm(
    prefs_b[[resp_name]] ~
      Price +
      Brand +
      Horsepower +
      Color +
      Sunroof,
    
    data = conjoint_df
  )
  
  # Predict utility for each car
  pref_matrix[i, ] = predict(
    temp_model,
    newdata = market_scenario
  )
}

# Select highest utility option
final_choices = apply(
  pref_matrix,
  1,
  which.max
)

# Calculate market share percentages
market_shares =
  table(final_choices) / 15

print(
  "Predicted Market Shares (Volkswagen, Toyota, Saturn, Kia):"
)

print(market_shares)

# 2 PRINCIPAL COMPONENT ANALYSIS (PCA)

# Load PCA dataset
cars_data = read_excel("Cars-PCA-A2.xlsx")

# Remove model column
pca_input = cars_data %>%
  dplyr::select(-Model)

# Run PCA with scaling
pca_run = prcomp(
  pca_input,
  scale. = TRUE
)

# Display singular values
print("Singular Values:")
print(pca_run$sdev)

# Calculate variance explained
pve_values =
  (pca_run$sdev^2) /
  sum(pca_run$sdev^2)

print("Proportion of Variance Explained:")
print(pve_values)

# Display loading factors
print("Loading Factors (PC1 and PC2):")
print(pca_run$rotation[, 1:2])

# Create PCA perceptual map
jpeg(
  "plots_part_b/PCA_Perceptual_Map.jpg",
  width = 800,
  height = 800
)

# Plot PCA biplot
biplot(
  pca_run,
  scale = 0,
  cex = 0.7,
  main = "PCA Perceptual Map of Car Attributes",
  xlabs = cars_data$Model
)

dev.off()