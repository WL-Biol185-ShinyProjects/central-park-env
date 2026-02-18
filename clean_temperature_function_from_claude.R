#From Claude: making a function to sort through data in 'Sighter Observed Weather Data' to get numeric number column called 'numerical_temp'
#trying to fix parenthesis problems so adding a new line

central_park <- read.csv("central_park.csv", stringsAsFactors=FALSE)

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
  return(NA)
}




#creating the column using sapply
#may need to click over on columns to get to column 51 because can only show 50 in one window

central_park$numerical_temp <- sapply(central_park$`Sighter Observed Weather Data`,clean_temperature)
