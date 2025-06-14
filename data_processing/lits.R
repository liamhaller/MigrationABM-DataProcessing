# Import data

life_in_transition_path <- here("data", "raw", "lits_iv.dta")
life_in_transition <- read_dta(life_in_transition_path)

# Filter for Turkey (country code for Turkey is 35, not used in data)
turkey_data <- life_in_transition %>%
  filter(country == 35)


# Select Relevant Variables -----------------------------------------------


# # Select variables related to migration attitudes
# migration_attitudes <- turkey_data %>%
#   select(
#     # Life satisfaction and perceptions of change
#     q401c,  # "My household lives better nowadays than around 4 years ago"
#     q401d,  # "All things considered, I am satisfied with my life now"
#     q401e,  # "Children who are born now will have a better life than my generation"
#
#     # Economic perceptions
#     q235,   # "Place on 10 step wealth ladder"
#     q236,   # "Place on 10 step wealth ladder - 4 years ago"
#     q237,   # "Place on 10 step wealth ladder - 4 years from now"
#     q411,   # "Change in the gap between rich and poor"
#
#     # Job satisfaction (if employed)
#     q401h,  # "All things considered, I am satisfied with my job on the whole"
#
#     # Risk attitudes
#     q418    # "Willingness to take risks"
#   )
#
# # Select variables related to subjective norms
# subjective_norms <- turkey_data %>%
#   select(
#     # Social networks and connections
#     q508,   # "Friends or relatives in the place where moving is planned"
#     q509,   # "HH members who left to live abroad"
#
#     # Trust and social perceptions
#     q402,   # "People can be trusted"
#     q413,   # "Likelihood of returned wallet"
#
#     # Cultural and religious identity
#     q811492, # "Turkey - Turkish" (ethnic identity)
#     q811493, # "Turkey - Kurdish" (ethnic identity)
#     q811496, # "Turkey - Muslim" (religious identity)
#     q814,    # "Religion"
#     q814b,   # "Importance of religion"
#
#     # Views on migrants
#     q828,    # "Opinion on immigrants"
#     q836g    # "People looking for better economic opportunities - arriving to live in country"
#   )
#
# # Select variables related to perceived behavioral control
# behavioral_control <- turkey_data %>%
#   select(
#     # Education and skills
#     q109b,   # "Highest level of education obtained - Primary respondent"
#     q334a,   # "Technical skills - level of skills"
#     q334b,   # "Computer skills - level of skills"
#     q334c,   # "Foreign language skills - level of skills"
#
#     # Financial resources
#     q225,    # "Household monthly income"
#     q227,    # "Savings - how long could they last"
#     q228,    # "Emergency - would able to pay"
#     q229,    # "Current financial situation of HH"
#     q232,    # "Account at a bank or another type of formal financial institution"
#
#     # Employment status and security
#     q301,    # "Working or have ever worked"
#     q304,    # "Work during the past 7 days"
#     q310,    # "Employment status - main job"
#     q326,    # "Likelihood of losing job"
#     q327,    # "Likelihood of finding a new job in case of losing current"
#
#     # Communication abilities
#     q813,    # "Mother tongue"
#     q106b    # "Main language - Primary respondent"
#   )
#
# # Select variables related to migration intentions/behavior
# migration_intentions <- turkey_data %>%
#   select(
#     # Migration intentions
#     q505,    # "Plans for moving abroad"
#     q507a,   # "Country - intend to go" (look for Germany specifically)
#
#     # Prior migration experience
#     q5011,   # "Length of time in this city/town/village - Years"
#     q5012,   # "Length of time in this city/town/village - Months"
#     q5013,   # "Length of time in this city/town/village - Have lived here my entire life"
#     q503a,   # "Country of birth"
#
#     # Household migration experience
#     q510,    # "Age of HH member who left"
#     q511,    # "Gender of HH member who left"
#     q512,    # "Education level of HH member who left"
#     q516,    # "Country HH member who left went to"
#
#     # Reason for migration
#     q5131,   # "To search for work - decided to leave"
#     q5132,   # "To take a job - decided to leave"
#     q5134    # "To study abroad - decided to leave"
#   )
#
# # Select demographic variables for controls
# demographics <- turkey_data %>%
#   select(
#     # Basic demographics
#     q1031,   # "Male or female - HH member 1" (assuming this is the respondent)
#     q1051,   # "Age - HH member 1" (assuming this is the respondent)
#     q107b,   # "Marital status - Primary respondent"
#
#     # Household characteristics
#     q1,      # "Number of HH members"
#     q209,    # "Ownership of the dwelling"
#     q206e,   # "Car including a company car used for private purposes"
#
#     # Location
#     region,  # "Region"
#     urbanity # "Urbanity"
#   )
#
# # Combine all relevant variables for the ABM
# lits <- turkey_data %>%
#   select(
#     # Include a unique identifier
#     hhid,    # "Household identification number"
#
#     # Include all variables from each component
#     names(migration_attitudes),
#     names(subjective_norms),
#     names(behavioral_control),
#     names(migration_intentions),
#     names(demographics)
#   )


# Save Processed data -----------------------------------------------------



saveRDS(turkey_data, here('data', 'processed', 'lits.rds'))




# Extra -------------------------------------------------------------------

#Get labels for all columns

labels <- sapply(turkey_data, function(x) attr(x, "label"))
tibble(
  column = names(labels),
  description = labels
)
