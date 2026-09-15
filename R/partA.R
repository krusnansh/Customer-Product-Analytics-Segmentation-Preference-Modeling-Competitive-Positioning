# PART A 

# Load required libraries
suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(cluster)
  library(MASS)
  library(scales)
})

# Create output folder
if (!dir.exists("plots")) dir.create("plots")

# Import customer datasets
current_data  <- read_excel("Current-Customers.xlsx")
prospect_data <- read_excel("Prospect-Customers.xlsx")

# Clean and prepare transaction data
clean_data <- current_data %>%
  filter(!is.na(CustomerID)) %>%
  mutate(
    Quantity = as.numeric(Quantity),
    UnitPrice = as.numeric(UnitPrice),
    Income = as.numeric(Income),
    Age = as.numeric(Age),
    Household_size = as.numeric(Household_size),
    TotalSpend = Quantity * UnitPrice,
    InvoiceDate = as.Date(InvoiceDate)
  ) %>%
  filter(!is.na(InvoiceDate), !is.na(TotalSpend))

# Generate descriptive statistics
desc_stats <- clean_data %>%
  summarise(
    Mean_Quantity = round(mean(Quantity, na.rm = TRUE), 2),
    Mean_UnitPrice = round(mean(UnitPrice, na.rm = TRUE), 2),
    Mean_TotalSpend = round(mean(TotalSpend, na.rm = TRUE), 2),
    Mean_Income = round(mean(Income, na.rm = TRUE), 2),
    Mean_Age = round(mean(Age, na.rm = TRUE), 2),
    Median_TotalSpend = round(median(TotalSpend, na.rm = TRUE), 2),
    SD_TotalSpend = round(sd(TotalSpend, na.rm = TRUE), 2)
  )

write.csv(desc_stats, "plots/Descriptive_Statistics.csv", row.names = FALSE)

# Plot transaction value distribution
jpeg("plots/EDA_01_Transaction_Distribution.jpg", width = 800, height = 600)

ggplot(clean_data, aes(x = TotalSpend)) +
  geom_histogram(bins = 50, fill = "steelblue", color = "white") +
  scale_x_continuous(labels = comma) +
  labs(
    title = "Distribution of Transaction Values",
    x = "Transaction Value (£)",
    y = "Frequency"
  ) +
  theme_minimal(base_size = 13)

dev.off()

# Plot quantity versus total spend
jpeg("plots/EDA_02_Quantity_vs_Spend.jpg", width = 800, height = 600)

ggplot(clean_data, aes(x = Quantity, y = TotalSpend)) +
  geom_point(alpha = 0.35, color = "darkblue") +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Quantity vs Total Spend",
    x = "Quantity Purchased",
    y = "Total Spend (£)"
  ) +
  theme_minimal(base_size = 13)

dev.off()

# Define reference date for RFM
ref_date <- max(clean_data$InvoiceDate) + 1

# Create customer RFM table
rfm_table <- clean_data %>%
  group_by(CustomerID) %>%
  summarise(
    Recency = as.numeric(ref_date - max(InvoiceDate)),
    Frequency = n_distinct(InvoiceNo),
    Monetary = round(sum(TotalSpend), 2),
    .groups = "drop"
  )

# Apply sequential RFM scoring
rfm_seq <- rfm_table %>%
  mutate(R_Seq = ntile(desc(Recency), 5)) %>%
  group_by(R_Seq) %>%
  mutate(F_Seq = ntile(Frequency, 5)) %>%
  group_by(R_Seq, F_Seq) %>%
  mutate(M_Seq = ntile(Monetary, 5)) %>%
  ungroup() %>%
  mutate(
    RFM_Score_Seq = R_Seq * 100 + F_Seq * 10 + M_Seq,
    Segment_Seq = case_when(
      R_Seq >= 4 & F_Seq >= 4 & M_Seq >= 4 ~ "Champions",
      R_Seq >= 3 & F_Seq >= 3 ~ "Loyal Customers",
      R_Seq <= 2 & F_Seq <= 2 ~ "Lost Customers",
      TRUE ~ "Potential Customers"
    )
  )

# Apply independent RFM scoring
rfm_ind <- rfm_table %>%
  mutate(
    R_Ind = ntile(desc(Recency), 5),
    F_Ind = ntile(Frequency, 5),
    M_Ind = ntile(Monetary, 5),
    RFM_Score_Ind = R_Ind * 100 + F_Ind * 10 + M_Ind,
    Segment_Ind = case_when(
      R_Ind >= 4 & F_Ind >= 4 & M_Ind >= 4 ~ "Champions",
      R_Ind >= 3 & F_Ind >= 3 ~ "Loyal Customers",
      R_Ind <= 2 & F_Ind <= 2 ~ "Lost Customers",
      TRUE ~ "Potential Customers"
    )
  )

# Merge both RFM approaches
rfm_export <- rfm_seq %>%
  left_join(
    rfm_ind %>%
      dplyr::select(
        CustomerID,
        R_Ind,
        F_Ind,
        M_Ind,
        RFM_Score_Ind,
        Segment_Ind
      ),
    by = "CustomerID"
  )

write.csv(rfm_export, "plots/RFM_Full_Table.csv", row.names = FALSE)

# Visualise sequential RFM segments
jpeg("plots/RFM_01_Sequential_Segments.jpg", width = 800, height = 600)

rfm_seq %>%
  count(Segment_Seq) %>%
  ggplot(aes(x = reorder(Segment_Seq, n), y = n, fill = Segment_Seq)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(
    title = "Sequential RFM Segments",
    x = "Customer Segment",
    y = "Number of Customers"
  ) +
  theme_minimal(base_size = 13)

dev.off()
