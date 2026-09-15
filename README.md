# Customer & Product Analytics: Segmentation, Preference Modeling & Competitive Positioning

## Project Overview

A retail business wanted to use customer and product data to improve customer targeting, understand purchasing behaviour, evaluate product preferences and assess competitive positioning.

The analysis combines **customer analytics, behavioural segmentation, prospect targeting, conjoint analysis, willingness to pay, market share modelling and PCA** to translate transaction and preference data into marketing and product decisions.

## Customer Analytics

### Business Problem

The business had transaction level customer data but lacked a structured view of purchasing behaviour, transaction value and customer characteristics. The objective was to identify spending patterns and establish a foundation for customer level analysis.

### Key Results

Average transaction spend was **£20.35**, compared with a median of **£10.20**, with a standard deviation of **£86.15**. This indicated a strongly right skewed distribution with substantial variation in transaction value.

Average purchase quantity was **10.54 units**, while average unit price was **£4.13**.

### Analytical Approach

**Data Preparation & Transformation**

Transaction records were cleaned and converted into analysis ready formats. Missing customer and transaction values were filtered and transaction value was derived as:

`Total Spend = Quantity × Unit Price`

**Descriptive Statistics**

Mean, median and standard deviation were calculated for key transaction and customer variables including quantity, unit price, total spend, income and age.

## Exploratory Data Analysis

### Business Problem

The business needed to understand transaction behaviour and customer characteristics before moving to customer segmentation and targeting.

### What the Analysis Found

The dataset showed a **strongly right skewed transaction value distribution**. The average transaction spend was **£20.35**, while the median was only **£10.20**, indicating that most transactions were relatively low in value and a small number of high value transactions increased the mean. The high standard deviation of **£86.15** further indicates substantial variation in transaction value.

The average purchase quantity was **10.54 units**, with an average unit price of **£4.13**. The quantity versus spend analysis showed that most transactions were concentrated at relatively low quantities and spending levels, while a small number of observations had exceptionally high quantities and transaction values.

The customer base had an average predicted household income of **£68.81** and an average head of household age of **54.46 years**.

### Analytical Approach

**Descriptive Statistics**

Calculated mean, median and standard deviation for transaction and customer variables to assess central tendency and variability.

**Transaction Distribution Analysis**

Used a histogram to examine the distribution of transaction values and identify concentration and extreme observations.

**Quantity vs Spend Analysis**

Used a scatter plot to examine the relationship between quantity purchased and total transaction spend and identify unusual high volume transactions.

### Key Business Insight

The high variability and skewness in transaction spending indicate that **average transaction value alone is not sufficient to understand customer value**. This provided the rationale for moving from transaction level analysis to **customer level RFM segmentation and behavioural clustering**.

## RFM Customer Segmentation

### Business Problem

Aggregate transaction metrics do not distinguish between recently active customers, frequent buyers and high value customers. The objective was to quantify customer value and identify actionable customer segments for retention and marketing.

### Key Results

Using sequential RFM scoring, **1,484 customers** were classified into:

| Segment | Customers |
|---|---:|
| Potential Customers | 713 |
| Loyal Customers | 439 |
| Lost Customers | 240 |
| Champions | 92 |

The independent scoring approach produced a different segment distribution, including **259 Champions** and **312 Lost Customers**, demonstrating the effect of the scoring methodology on customer classification.

### Analytical Approach

**Recency**

Measured the number of days since each customer's most recent purchase.

**Frequency**

Measured the number of distinct transactions associated with each customer.

**Monetary Value**

Measured total customer spending across transactions.

RFM scores were generated using both **sequential and independent quintile based scoring**, followed by rule based customer classification.

### Business Interpretation

The segmentation identifies customers requiring different marketing actions, from retention and loyalty initiatives for high value customers to reactivation strategies for customers with weak recent engagement.

### Visualizations

<img width="800" height="600" alt="RFM_01_Sequential_Segments" src="https://github.com/user-attachments/assets/0669631c-a337-43e7-939c-502c5c01bb0d" />

<img width="800" height="600" alt="RFM_02_Independent_Segments" src="https://github.com/user-attachments/assets/20dc8294-4167-49c3-8002-4abcb76004eb" />

### Techniques

`RFM Analysis` `Recency` `Frequency` `Monetary Value` `Quintile Scoring` `Customer Segmentation` `Retention Analytics`

## Behavioural Customer Clustering

### Business Problem

RFM scores provide structured customer classifications, but customers within the same segment can still exhibit very different behavioural profiles. The objective was to identify naturally occurring customer groups based on behavioural and value characteristics.

### Key Results

Four behavioural clusters were identified:

| Cluster | Customers | Avg Recency | Avg Frequency | Avg Monetary |
|---|---:|---:|---:|---:|
| 1 | 914 | 5.0 | 453.0 | 17,619 |
| 2 | 709 | 59.5 | 4.7 | 141 |
| 3 | 2,048 | 32.4 | 5.7 | 184 |
| 4 | 909 | 141.3 | 1.5 | 51 |

Cluster 1 represents an extremely high frequency and high monetary value group, while Cluster 4 represents a low frequency, low monetary value and less recent customer group.

### Analytical Approach

**Hierarchical Clustering**

Hierarchical clustering was used to group customers according to behavioural similarity and construct a hierarchy of customer profiles.

**Dendrogram Analysis**

The dendrogram was used to examine how customers merge across different levels of similarity and support the selection of an appropriate segmentation structure.

**Elbow Method**

Within cluster variation was evaluated across different cluster counts to identify a practical number of behavioural segments.

**Cluster Profiling**

The resulting clusters were profiled using recency, frequency, monetary value, income and age to understand the commercial characteristics of each customer group.

### Visualizations

<img width="900" height="600" alt="Cluster_01_Dendrogram" src="https://github.com/user-attachments/assets/ec9cd6ae-4a55-47c7-aaf4-b28113546b92" />

<img width="800" height="600" alt="Cluster_02_Elbow_Method" src="https://github.com/user-attachments/assets/25bb4d82-2a7a-4462-833f-7490a032d783" />

<img width="800" height="600" alt="Segment_01_Monetary" src="https://github.com/user-attachments/assets/741395a3-5252-4aa0-a4fb-b56814f9e5d1" />

<img width="800" height="600" alt="Segment_02_Age" src="https://github.com/user-attachments/assets/e9efc582-bf9d-4b62-bf2c-28e19d40f2d4" />

### Techniques

`Hierarchical Clustering` `Dendrogram` `Elbow Method` `Cluster Profiling` `Behavioural Segmentation`

## Prospect Targeting

### Business Problem

After identifying valuable customer profiles, the next objective was to extend these insights to prospective customers and prioritize prospects for acquisition activities.

### Key Results

The prospect dataset contained **2,000 prospects**. The targeting model assigned:

| Target Segment | Prospects |
|---|---:|
| Segment 1 | 218 |
| Segment 2 | 336 |
| Segment 3 | 1,446 |

This creates a structured prospect prioritization framework that can be connected to differentiated acquisition and marketing strategies.

### Analytical Approach

Prospective customers were evaluated using demographic and household variables including income, age, household size, marital status, work and education. The resulting targeting output assigned each prospect to a target segment.

### Techniques

`Prospect Segmentation` `Targeting Analytics` `Customer Acquisition Analytics` `Demographic Profiling`

## Conjoint Preference Modeling

### Business Problem

Customer segmentation explains **who** customers are, but product decisions also require understanding **what attributes drive preference**. The objective was to quantify customer preferences across competing product features and configurations.

### Analytical Approach

Conjoint models were estimated at the respondent level using:

`Price`

`Brand`

`Horsepower`

`Colour`

`Sunroof`

**Part Worth Utilities**

Linear models were used to estimate the utility contribution of individual attribute levels to respondent preference.

**Attribute Importance**

Utility ranges were calculated for each attribute and normalized to estimate the relative importance of price, brand, horsepower, colour and sunroof.

### Business Application

The analysis provides a quantitative basis for feature prioritization and product configuration decisions by identifying which attributes contribute most strongly to customer preference.

### Visualizations

<img width="800" height="600" alt="Conjoint_WTP_Analysis" src="https://github.com/user-attachments/assets/01f5b479-9d0a-40fa-ba93-21c305c00d5d" />

### Techniques

`Conjoint Analysis` `Linear Regression` `Part Worth Utilities` `Attribute Importance` `Preference Modeling`

## Willingness To Pay

### Business Problem

Understanding preference alone does not indicate the economic value customers place on product attributes. The objective was to translate conjoint utilities into an interpretable willingness to pay framework.

### Analytical Approach

Average respondent utilities were calculated and price sensitivity was derived from the estimated price coefficient. Utility differences were then expressed relative to price sensitivity to estimate willingness to pay across attribute levels.

### Business Application

WTP analysis supports pricing, feature valuation and product configuration decisions by quantifying the relative economic value associated with product attributes.

### Techniques

`Willingness To Pay` `Price Sensitivity` `Utility Analysis` `Pricing Analytics`

## Competitive Market Share Prediction

### Business Problem

The business also needed to understand how alternative product configurations could perform relative to competitors.

### Analytical Approach

Four competing product profiles were evaluated:

`Volkswagen`

`Toyota`

`Saturn`

`Kia`

Respondent level conjoint models were used to predict preference scores for each competitive profile. The highest utility profile for each respondent was used to estimate predicted market share.

### Business Application

The analysis provides a preference based framework for evaluating competitive product configurations and estimating potential market outcomes.

### Techniques

`Preference Prediction` `Market Share Simulation` `Competitive Analysis` `Conjoint Modeling`

## PCA & Competitive Product Positioning

### Business Problem

A large number of product attributes can make competitive relationships difficult to interpret directly. The objective was to reduce the dimensionality of the product attribute space and visualize competitive positioning.

### Analytical Approach

**Principal Component Analysis**

PCA was performed on standardized product attributes to identify the main dimensions explaining variation across the products.

**Component Loadings**

PC1 and PC2 loadings were examined to understand which attributes contributed most strongly to the principal dimensions.

**Perceptual Mapping**

A PCA based perceptual map was created to visualize relative product positioning and identify similarities and differences among competing products.

### Visualization

<img width="800" height="800" alt="PCA_Perceptual_Map" src="https://github.com/user-attachments/assets/0e18b345-307b-4e27-99b3-f646bacfaf19" />

### Techniques

`PCA` `Standardization` `Variance Explained` `Component Loadings` `Perceptual Mapping` `Competitive Positioning`

## Integrated Business Insights

The analysis connects customer and product analytics into one decision framework.

**Customer Analytics** identifies purchasing behaviour and transaction patterns.

**RFM Analysis** identifies valuable, loyal and at risk customer groups.

**Clustering** reveals deeper behavioural differences across customer profiles.

**Prospect Targeting** extends customer insights to acquisition decisions.

**Conjoint Analysis** identifies the product attributes that drive customer preference.

**WTP Analysis** quantifies the economic value associated with product attributes.

**Market Share Prediction** evaluates potential competitive outcomes.

**PCA Perceptual Mapping** provides a visual view of competitive product positioning.

Together, these analyses provide a framework for **customer retention, prospect acquisition, product configuration, pricing and competitive strategy**.

## Technology & Analytical Methods

### Technology

`R` `RStudio` `readxl` `tidyverse` `dplyr` `tidyr` `ggplot2` `cluster` `MASS`

### Analytical Methods

`Data Cleaning`

`Data Transformation`

`Descriptive Statistics`

`Exploratory Data Analysis`

`RFM Analysis`

`Customer Segmentation`

`Hierarchical Clustering`

`Dendrogram Analysis`

`Elbow Method`

`Cluster Profiling`

`Prospect Targeting`

`Conjoint Analysis`

`Part Worth Utility Estimation`

`Attribute Importance`

`Willingness To Pay`

`Price Sensitivity Analysis`

`Market Share Prediction`

`Principal Component Analysis`

`Perceptual Mapping`


<img width="800" height="600" alt="EDA_01_Transaction_Distribution" src="https://github.com/user-attachments/assets/03bb1018-6613-42c3-a372-17dea4301faf" />
