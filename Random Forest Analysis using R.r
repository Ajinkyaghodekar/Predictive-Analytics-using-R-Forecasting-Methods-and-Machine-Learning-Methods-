# Random Forest Regression

# Data Preprocessing 

# Importing the dataset 

dataset = read.csv('transaction1_data.csv')

View(dataset)



# Taking care of Missing data 

dataset$QUANTITY = ifelse(is.na(dataset$QUANTITY),
                          ave(dataset$QUANTITY, FUN = function(x) mean(x, na.rm = TRUE)),
                          dataset$QUANTITY)

dataset$QUANTITY = ifelse(0,1,dataset$QUANTITY)



dataset$SALES_VALUE = ifelse(is.na(dataset$SALES_VALUE),
                             ave(dataset$SALES_VALUE, FUN = function(x) mean(x, na.rm = TRUE)),
                             dataset$SALES_VALUE)


# Formula

dataset$Actual_price = (dataset$SALES_VALUE - (dataset$RETAIL_DISC + dataset$COUPON_MATCH_DISC)/dataset$QUANTITY)


# Drop the unnecessary columns of the dataframe

library(dplyr)

mydata <- dataset

library(sos)

findFn("select")

T = select (mydata, -c(X,household_key,BASKET_ID, DAY, PRODUCT_ID, STORE_ID, TRANS_TIME, QUANTITY, COUPON_DISC, SALES_VALUE, COUPON_MATCH_DISC, RETAIL_DISC ))

View(T)

summary(T)



##### Encoding categorical data 



# Splitting dataset into a training set and test set 

# install.packages('caTools')

u = aggregate( Actual_price ~ WEEK_NO, T, sum)

library(caTools)

set.seed(123)

split = sample.split(u$WEEK_NO, SplitRatio = 0.8)

training_set = subset(u, split == TRUE)

test_set = subset(u, split == FALSE)


# Feature Scaling

#training_set = scale(training_set)

#test_set = scale(test_set)


# Random Forest Regression for aggregated data(u), training_set, test_set

# install.packages("randomForest")

library(randomForest)

set.seed(1234)


regressor = randomForest(x = u[1],
                         y = u$Actual_price,
                         ntree = 500)

 
regressor = randomForest(x = training_set[1],
                         y = training_set$Actual_price,
                         ntree = 300)

regressor = randomForest(x = test_set[1],
                         y = test_set$Actual_price,
                         ntree = 200)


# Visualizing Random Forest regression

library(ggplot2)

ggplot() +
  geom_point(aes(x = u$WEEK_NO, y = u$Actual_price),
             colour = 'red') +
  geom_line(aes(x = u$WEEK_NO, y = predict(regressor, newdata = u )),
            colour = 'blue') +
  ggtitle('Truth or Bluff(Random Forest Regression)') + 
  xlab('WEEK_NO')+
  ylab('ACTUAL_PRICE')


# Visualizing the Random Forest Regression results (for higher resolution)

# install.packages('ggplot2')

library(ggplot2)

x_grid = seq(min(u$WEEK_NO), max(u$WEEK_NO), 0.01)
ggplot() +
  geom_point(aes(x = u$WEEK_NO, y = u$Actual_price),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(WEEK_NO = x_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Random Forest Regression)') +
  xlab('WEEK_NO') +
  ylab('SALES_VALUE')


#Predicting a new result for WEEK_NO 98

y_pred = predict(regressor, data.frame(WEEK_NO = 98))

    
  
  
  







