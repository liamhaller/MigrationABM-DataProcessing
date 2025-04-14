

# Data Processing ---------------------------------------------------------


# Script to add a simplified visa category column

# Define patterns to categorize visas
visa_categories <- list(
  "Deportation Suspension" = "susp(ension)?.*(deportation|deport)",
  "Student Visa" = "(studying|student|course|school|language|studies)",
  "Employment/Work Visa" = "(employment|work|job|empl\\.|Blue Card|labor)",
  "Self-Employment Visa" = "(self.empl|free.lance)",
  "Research Visa" = "research",
  "Training Visa" = "(training|voc.training)",
  "Family Reunification" = "(spouse|family|child|parent|dependant|minor|juv|subs.imm)",
  "Settlement Permit" = "(settl.perm|settlement permit)",
  "Humanitarian/Asylum" = "(asylum|refugee|humanit|protect|hardship)",
  "EU/EEA Mobility" = "(EU|EEA|Swiss|EC|movement)",
  "Former German" = "former German"
)

# Function to determine visa category
determine_category <- function(visa_description) {
  for (category_name in names(visa_categories)) {
    if (grepl(visa_categories[[category_name]], visa_description, ignore.case = TRUE)) {
      return(category_name)
    }
  }
  return("Other")
}
