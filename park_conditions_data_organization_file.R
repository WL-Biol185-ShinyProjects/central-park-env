#Emma Batty data organizing
#I consulted Claude to help me sift through and organize data from the 'Sighter Observed Weather Data'
#to get numeric number column called 'numeric_temp'

#I ran into issues with Claude and had to go through and manually edit the code and cut out parts that were excessive and fix
#parenthesis problems

#here is my edited code from Claude:
clean_temperature <- function(temp_string) {
  # Handle NA values
  if (is.na(temp_string) || temp_string == "" || temp_string == "NA") {
    return(NA)
  }
  
  # Convert to character and lowercase for easier processing
  temp_string <- tolower(as.character(temp_string))
  
  # Extract numeric values using regex
  # Look for patterns like "61º F", "Mid 40s", "70s", "Low 50s", etc.
  
  # Pattern 1: Direct numbers followed by º or degree symbol (e.g., "61º F", "52º F")
  if (grepl("\\d+\\s*[ºo°]", temp_string)) {
    temp <- as.numeric(sub(".*?(\\d+)\\s*[ºo°].*", "\\1", temp_string))
    return(temp)
  }
  
  # Pattern 2: "mid 40s", "low 50s", "high 60s"
  if (grepl("(low|mid|high)\\s*(\\d+)s?", temp_string)) {
    match <- regmatches(temp_string, regexec("(low|mid|high)\\s*(\\d+)s?", temp_string))[[1]]
    if (length(match) >= 3) {
      base_temp <- as.numeric(match[3])
      modifier <- match[2]
      
      # Adjust based on modifier
      if (modifier == "low") {
        return(base_temp + 2)  # e.g., "low 50s" = 52
      } else if (modifier == "mid") {
        return(base_temp + 5)  # e.g., "mid 40s" = 45
      } else if (modifier == "high") {
        return(base_temp + 7)  # e.g., "high 60s" = 67
      }
    }
  }
  
  # Pattern 3: Just "40s", "50s", "60s", "70s"
  if (grepl("\\d+s", temp_string) && !grepl("(low|mid|high)", temp_string)) {
    temp <- as.numeric(sub(".*?(\\d+)s.*", "\\1", temp_string))
    return(temp + 5)  # Default to mid-range (e.g., "60s" = 65)
  }
  
  # Pattern 4: Plain numbers (e.g., "70", "65")
  if (grepl("^\\d+$", temp_string)) {
    return(as.numeric(temp_string))
  }
  
  # Pattern 5: Numbers with ~ or other prefixes (e.g., "~low 50s")
  if (grepl("~", temp_string)) {
    temp_string <- gsub("~", "", temp_string)
    # Recursively call the function on the cleaned string
    return(clean_temperature(temp_string))
  }
  
  # If no pattern matches, return NA
  NA
}

# Read the CSV file
# Change this path to your actual file location
central_park_numeric_temp <- read.csv("central_park.csv", stringsAsFactors = FALSE)

# Apply the cleaning function to the temperature column
# The column is named "Sighter.Observed.Weather.Data" in R (dots replace spaces)
central_park_numeric_temp$numeric_temp <- sapply(central_park_numeric_temp$Sighter.Observed.Weather.Data, clean_temperature)


#After this function was run on the data it created a new table for me to work in
# called "central_park_numeric_temp" where I continued to add another new column concerning
# proper date formatting called "proper_date_format"

#Before making this new variable I cleaned up the names of the columns in all of our major tables
#using the following code

#Renaming table variable names

#I want to get rid of all the spaces in between our variable names

colnames(central_park)<-gsub(" ","_",
                             colnames(central_park),
                             fixed=TRUE)

colnames(central_park_numeric_temp)<-gsub(".","_",
                                          colnames(central_park_numeric_temp),
                                          fixed=TRUE)

colnames(central_park_act_obs)<-gsub(" ","_",
                                     colnames(central_park_act_obs),
                                     fixed=TRUE)

colnames(central_park_attitude)<-gsub(" ","_",
                                      colnames(central_park_attitude),
                                      fixed=TRUE)

colnames(central_park_noise_obs)<-gsub(" ","_",
                                       colnames(central_park_noise_obs),
                                       fixed=TRUE)

colnames(central_park_og)<-gsub(" ","_",
                                colnames(central_park_og),
                                fixed=TRUE)

colnames(central_park_tailbeh_obs)<-gsub(" ","_",
                                         colnames(central_park_tailbeh_obs),
                                         fixed=TRUE)


#The code I wrote to create "proper_date_format" is below:

library(tidyverse)
library(lubridate)

s = as.character(central_park_numeric_temp$Date)

months <- substring(s,1,2)
days <- substring(s,3,4)
years <- substring(s,5,8)
dates <- make_date(year = years, month = months, day = days)

central_park_numeric_temp$proper_date_format <- dates



