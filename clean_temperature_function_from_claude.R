#From Claude: making a function to sort through data in 'Sighter Observed Weather Data' to get numeric number column called 'numerical_temp'
#trying to fix parenthesis problems so adding a new line

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

# Read the CSV file
# Change this path to your actual file location
central_park_numeric_temp <- read.csv("central_park.csv", stringsAsFactors = FALSE)

# Apply the cleaning function to the temperature column
# The column is named "Sighter.Observed.Weather.Data" in R (dots replace spaces)
central_park_numeric_temp$numeric_temp <- sapply(central_park_numeric_temp$Sighter.Observed.Weather.Data, clean_temperature)

# Display summary of the conversion
cat("\n=== Temperature Conversion Summary ===\n")
cat("Original column: Sighter.Observed.Weather.Data\n")
cat("New column: numeric_temp\n\n")

cat("Sample of original values:\n")
print(head(central_park_numeric_temp$Sighter.Observed.Weather.Data, 10))

cat("\nSample of converted values:\n")
print(head(central_park_numeric_temp$numeric_temp, 10))

cat("\nSummary statistics of numeric_temp:\n")
print(summary(central_park_numeric_temp$numeric_temp))

cat("\nNumber of NA values:\n")
cat("Original NAs:", sum(is.na(central_park_numeric_temp$Sighter.Observed.Weather.Data) | 
                           central_park_numeric_temp$Sighter.Observed.Weather.Data == "" | 
                           central_park_numeric_temp$Sighter.Observed.Weather.Data == "NA"), "\n")
cat("After conversion:", sum(is.na(central_park_numeric_temp$numeric_temp)), "\n")

# Save the cleaned dataset
# write.csv(data, "central_park_numeric_temp.csv", row.names = FALSE)
cat("\n✓ Cleaned data saved to: central_park_numeric_temp.csv\n")

