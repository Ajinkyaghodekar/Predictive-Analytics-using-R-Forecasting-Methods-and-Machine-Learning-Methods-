#install.packages("dplyr")

library(dplyr)

library(forecast)

rm(list=ls(all=TRUE))

tranData = read.csv(file = "F:\\OneDrive_1_21-06-2019\\transaction_data.csv")

quantity_zero = tranData[tranData$QUANTITY == 0 & tranData$SALES_VALUE > 0,]

summary(quantity_zero)

quantity_gt_zero = tranData[!(tranData$QUANTITY == 0),]

summary(quantity_gt_zero)

t = select(quantity_gt_zero,WEEK_NO,SALES_VALUE,QUANTITY,RETAIL_DISC,COUPON_DISC,COUPON_MATCH_DISC,RETAIL_DISC)

summary(t)


### formaula 
##  Actual_price = (SALES_VALUE - (RETAIL_DISC + COUPON_MATCH_DISC)/QUANTITY) 

t$Actual_price = (t$SALES_VALUE - (t$RETAIL_DISC + t$COUPON_MATCH_DISC)/t$QUANTITY)



##########Time Series data 

ti = select(t,WEEK_NO,Actual_price)

u = aggregate( Actual_price ~ WEEK_NO , ti, sum)

sum(is.na(u))


## remove the complete transcational data file from memeory. 

#rm(ls = tranData)


## Explore

tsdata<- ts(u$Actual_price, frequency = 4)

start(tsdata)

end(tsdata)

class(tsdata)

frequency(tsdata)

sum(is.na(tsdata))

summary(tsdata)

plot(u,type = "l")


# multiplicative time series

ddata<- decompose(tsdata, "multiplicative")

plot(ddata)

plot(ddata$trend)

plot(ddata$seasonal)

plot(ddata$random)

plot(tsdata)

abline(reg = lm(tsdata ~ time(tsdata)))

cycle(tsdata)


## Box plot of cycle
boxplot(tsdata ~ cycle(tsdata) , xlab = "Quater" , ylab= "Sales Value", main = "Quaterly sales value")

plot(tsdata)


####### ARIMA Model automatic

mymodel <- auto.arima(ts(u$Actual_price[0:95]))

mymodel

auto.arima(ts(u$Actual_price[0:95]) , ic = 'aic' , trace = TRUE )


# Library timeseries

library(tseries)

plot(mymodel$residuals)


# Autocorrelation Fuction(ACF)

acf(ts(mymodel$residuals), main = "ACF Residuals")


# Partial Autocorrelation

pacf(ts(mymodel$residuals), main = "PACF Residuals")



## Forecast 

myforecast <- forecast(mymodel,level = c(90),h=6)

plot(myforecast)

myforecast


# See the Forecasted Values

myforecast$mean


# plot last observations and the forecast

plot(myforecast, xlim = c(85, 110))


# Comparision plot for 2 models 

library(ggplot2)
autoplot(myforecast)+
  forecast::autolayer(myforecast$mean,
                      series = 'ARIMA model') +
  xlab('WEEK_NO') +
  ylab('SALES_VALUE') +
  guides(
    colour = guide_legend(
      Title = 'Forecast Method')) +
  theme(
    legend.position = c(0.8, 0.8))

  

### Box test

Box.test(mymodel$residuals,lag = 4, type = "Ljung-Box")

Box.test(mymodel$residuals,lag = 1, type = "Ljung-Box")

Box.test(mymodel$residuals,lag = 2, type = "Ljung-Box")



