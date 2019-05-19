# Exploratory analysis of housing prices data: https://www.kaggle.com/harlfoxem/housesalesprediction

library(dplyr)
library(skimr)
library(ggplot2)
library(moderndive)

options(scipen = 999) ### turn off scientific notation like 1e-09

# load and examine data -----------------------------------------------------------------
house_prices <- house_prices
skim(house_prices)

# explore data --------------------------------------------------------------------------

# price
ggplot(house_prices, aes(x = price)) +
   geom_histogram()

# log transform of price
ggplot(house_prices, aes(x = log10(price))) +
   geom_histogram()

# sqft
ggplot(house_prices, aes(x = log10(sqft_living))) +
   geom_histogram() + 
   labs(x = "Sq.feet living", y = "count")

# year 
ggplot(house_prices, aes(x = yr_built)) +
   geom_histogram() + 
   labs(x = "Year built", y = "count")

# add additional variables to dataset ---------------------------------------------------
houses <- house_prices %>% 
   mutate(log10_price = log10(price),
          log10_sqft_living = log10(sqft_living))


# more plots ----------------------------------------------------------------------------
# Price vs. sqft
ggplot(houses, aes(x = sqft_living, y = price, col = condition)) +
   geom_point() +
   labs(x = "Sq. feet living", y = "Price")

ggplot(houses, aes(x = sqft_living, y = price, col = condition)) +
   geom_point(alpha = 0.6) +
   labs(x = "Sq. feet living", y = "Price") + 
   scale_y_log10() +
   scale_x_log10()

# Price ~ bedrooms
ggplot(houses, aes(x = bedrooms, y = price, col = condition)) + 
   geom_jitter(alpha = 0.6) +
   scale_y_log10()

# Price ~ grade
ggplot(houses, aes(x = grade, y = price, col = condition)) +
   geom_jitter(alpha = 0.6) +
   scale_y_log10()

ggplot(houses, aes(x = grade, y = price)) +
   geom_jitter(aes(col = condition), alpha = 0.3) +
   geom_boxplot(aes(col = grade), 
                alpha = 0.01, 
                lwd = .8,
                fatten = .7,
                outlier.shape = NA, 
                show.legend = FALSE) +
   labs(x = "Housing Grade", y = "Price", col = "Condition",
        title = "Distribution of Housing Prices in Seattle \nby housing grade and condition") +
   scale_y_log10() + 
   theme_minimal()

# boxplot Price ~ waterfront
ggplot(houses, aes(x = waterfront, y = log10_price)) +
   geom_boxplot()+
   scale_y_log10()


# create models of price ----------------------------------------------------------------

# Price ~ sqft living space: expliains 45% of variation in housing price
lm_sqft <- lm(log10_price ~ log10_sqft_living, data = houses)
summary(lm_sqft)

summary(lm(price ~ sqft_living, data = houses))








