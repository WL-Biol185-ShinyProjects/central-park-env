library(tidyverse)
library(lubridate)
    
    s = as.character(central_park_numeric_temp$Date)
    
    months <- substring(s,1,2)
    days <- substring(s,3,4)
    years <- substring(s,5,8)
    dates <- make_date(year = years, month = months, day = days)
    
    central_park_numeric_temp$proper_date_format <- dates
  