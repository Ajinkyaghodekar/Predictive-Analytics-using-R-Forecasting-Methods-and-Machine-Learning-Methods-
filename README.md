# Predictive Analytics using R(Forecasting Methods and Machine Learning Methods)

The Dataset is consist of three CSV files which contains Transactional Dataset, Demographoic Dataset, Product Dataset.

The Demographic Dataset contains HOUSEHOLD_KEY, AGE_DESC, MARITIAL_STATUS_CODE, INCOME_DESC, HOMEOWNER_DESC, HH_COMP_DESC, HOUSEHOLD_SIZE_DESC, KID_CATEGORY_DESC.

The Product contains information on each product such as type of product, national or private label and brand identifier. Dataset consist of PRODUCT_ID, DEPARTMENT, COMMODITY_DESC, SUBCOMMODITY_DESC, MANUFACTURER, BRAND, CURR_SIZE_OF_PRODUCT.

The Transactions_data contains all products purchased by households. Dataset Consist of HOUSEHOLD_KEY, BASKET_ID, DAY, PRODUCT_ID, QUANTITY, SALES_VALUE, STORE_ID, COUPON_MATCH_DISC, COUPON_DISC, RETAIL_DISC, TRANS_TIME, WEEKS_NO.

The variable SALES_VALUE in Transaction data is the amount of dollars received by the retailer on the sale of the specific product, taking the coupon match and loyalty card discount into account. If a customer uses a coupon, the actual price paid will be loss than the SALES_VALUE because the manufacturer issuing the coupon will reimburse the retailer for the amount of the coupon.

Formula need to be used to calculate actual product prices, use the following formula below: 1.Loyalty card price = (sales_value - (retail_disc + coupon_match_disc)/ quantity 2.Non-Loyalty card price = (sales_value-(coupon_match_disc))/quantity.

Questions to find out: 1.Quick validation how many products are offered by the store in WEEK_NO=50? 2.What is the best selling product? 3.To Forecast sales for WEEK_NO = 98 using ARIMA and Random Forests 4.Finally to find which method ARIMA or RANDOM Forests to recommend to use?

To solve this problem

To understand data collection, data analysis, filters, size limits.
Then to understand cleaning and preprocessing. First to preprocess data before analysis.
After that to work on descriptive analysis examples like Aggregations, Histogram, Descriptive charts.
Later worked on Predictive Analytics methods like Forecast models, Regression models, Machine Learning, Choice modelling.
Finally to worked on Optimization models (use predictive models as input of optimization) and advanced visulization.
Finally to understand ARIMA methods are useful for long term future.
The all code for ARIMA and Random Forest methods with full predictions images are detailed in PDF files.
