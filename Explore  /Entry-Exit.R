

#Entry into Germany by Year, Age, & Gender
destatis_entryandexit <- readRDS(here("data", "processed", "destatis_enterandexit.rds"))

#Addition by first arrival from abroad
border_crosses <- destatis_entryandexit %>%
  select(year, age, arrival_male, arrival_female) %>%
  mutate(total = arrival_male + arrival_female) %>%
  group_by(year) %>%
  summarise(entries = sum(total))



# -------------------------------------------------------------------------





destatis_all_permits <- readRDS(here("data", "processed", "all_permits_destatis.rds"))



first_time_visas <- c(
      "Temp. residence title according to Foreigners Act",
      "Residence title for spec. purp. acc. to For. Act",
      "Residence title for except. purp. acc. to For. Act",
      "S.16(1),RA, residence permit for studying",
      "S.16(5),RA,res.perm. for seeking job commens.w.qu.",
      "S.16b(1),RA,res.perm.for language course or school",
      "S.16b(3),RA,res.perm.,seek job aft. school voc.tr.",
      "S.17a(1),RA,residence permit,for training measure",
      "S.17a(4),RA,res.perm.seek job aft.recog.prof.qual.",
      "S.17a(5), RA, residence permit for taking exam.",
      "S.16(6)RA,res.perm.,cond.admiss. part-time studies",
      "S.16(9)RA,res.perm.,studies with protection status",
      "S.17b(1)RA,res.perm.,training interns, EU studies",
      "S.16a RA, residence permit, certificate issued",
      "S.18a(1a), RA, res.perm., qualified foreigners",
      "S.18(4a)RA,res.perm.,publ.official German employer",
      "S.18d(1)RA,resid.permit,European Voluntary Service",
      "S.19b(1)RA, residence permit, ICT card",
      "S.19d(1)RA, residence permit, mobile ICT card",
      "S.20(8)RA,res.perm.,researchers intern.protect.EU",
      "S.20b(1)RA, residence permit, mobile researcher",
      "S.20(7)RA,res.perm.,seek.employment after research",
      "S.19c(1)RA,resid.perm.,intra-corporate transferees",
      "S.20a RA,res.perm.,short-term mobility researchers",
      "S.17(1),RA,res.perm.,enterprise-based voc.training",
      "S.17(3),RA,res.perm.,seek job aft. enterpr.voc.tr.",
      "S.16(6),1.s.,RA,res.perm.,students intra-Comm.mob.",
      "S.16(7),RA, res.perm., appl. to a course of study",
      "S.18,RA,residence permit for taking up employment",
      "S.18c, RA, residence permit for seeking a job",
      "S.19a,RA+S.41a(1),Ord. admission, for employment",
      "S.19a,RA+S.41a(2),Ord. admission, for employment",
      "S.21,RA, residence permit for self-employment",
      "S.21(2a),RA,res.perm.,self-empl.,higher educ.grad.",
      "S.19a,RA+S.2(1)no.2(a),Ord.admiss.of foreig.empl.",
      "S.19a,RA+S.2(1)no.2(b),Ord.admiss.,temp.res.perm.",
      "S.18c,RA,res.perm. for seeking job,entry with visa",
      "S.20(1),RA,residence permit for research purposes",
      "S.20(5),RA,res.perm.,research.,res.title other EU",
      "S.18(3),RA,res.perm. for empl.not requir.voc.qual.",
      "S.18(4),1.s.,RA,res.perm.for empl.requir.voc.qual.",
      'S.18(4),2.s.,RA,res.perm.for empl. when publ.int.',
      "S.18a(1)no.1(a),RA,res.perm.,foreig.with voc.qual.",
      "S.18a(1)no.1(b),RA,res.perm.,foreig.w.higher educ.",
      "S.18a(1)no.1(c),RA,res.perm.,voc.qual.,empl.3years",
      "S.7(1),3.s.,RA,resid.permit, other justified cases",
      "S.4(5),RA,res.perm.,EEC-Turkey Association Agreem.",
      "S.21(1),RA, residence permit for self-employment",
      "S.21(2),RA,res.perm.,self-empl.,special privileges",
      "S.21(5),RA, resid.permit, for free-lance activity"
    #  "S.18b,RA,settl.perm.,higher edu.grad.of Germ.univ.",
    #  "S.19,RA,settlement permit,highly qualif.foreigners",
    #  "S.19(1),RA,settl.perm.,highly qual. for.,not 19(2)",
    #  "S.19(2)no.1,RA,settl.perm.,research.,sp.tech.know.",
    #  "S.19(2)no.2,RA,settl.perm.,teach.,scient.,prom.pos",
    #  "S.19a(6),RA,settlement permit,EU Blue Card holders",
    #  "S.19a(6),1.s.,RA,sett.perm.,EUBlueCard,empl>33mon.",
   #   "S.19a(6),3.s.,RA,sett.perm.,EUBlueCard,empl>21mon."
)

destatis_all_permits %>%
  filter(permit %in% first_time_visas) %>%
  mutate(total = Male + Female) %>%
  group_by(year) %>%
  summarise(immigration = sum(total)) %>%
  print(n=25)





first_time_visas_some <- c(
#"Right of resid. acc.to EU Law on Freedom of Movem.",
#"Exempted from requirem. to have a residence title",
#"Unlimited settlement permit",
#"Temporary residence permit",
"Temporary residence permit for education purposes",
"Temporary residence permit for employment purposes",
#"Temp.res.perm.for reas.of int.law,hum.,pol.reasons",
#"Temporary residence permit for family reasons",
"Temp.resid.permit f.special reasons,national visas"
#"Application for residence title filed",
#"Temporary suspension of deportation",
#"Permission to reside",
#"No res.title, temp.susp. of dep. or perm.to reside"
)

destatis_some_permits <- readRDS(here("data", "processed", "some_permits_destatis.rds"))

destatis_some_permits %>%
  filter(permit %in% first_time_visas_some) %>%
  mutate(total = Male + Female) %>%
  filter(year > 2015)





destatis_some_permits %>%
  filter(permit %in% first_time_visas_some) %>%
  mutate(total = Male + Female) %>%
  group_by(year) %>%
  summarise(immigration = sum(total)) %>%
  print(n=25)



# Exit Data ---------------------------------------------------------------



#What percent of total Turksih Emigration went to germany by year
oecd_emigration <- readRDS(here("data", "processed", "oecd_emigration.rds"))


# Calculate means of each metric
mean_total_emigration <- mean(oecd_emigration$total_emigration_to_de)
mean_pct_emigration <- mean(oecd_emigration$pct_emigration_to_de)

# Create new rows for missing years with mean values
missing_years <- tibble(
  year = c(2016, 2022, 2023),
  total_emigration_to_de = rep(mean_total_emigration, 3),
  pct_emigration_to_de = rep(mean_pct_emigration, 3)
)

# Combine original and new data
complete_oecd_emigration <- bind_rows(oecd_emigration, missing_years) %>%
  arrange(year)





#How many Turkish citizens emigrated by year and province
turkstat_migration_cit_and_prov <- readRDS(here("data", "processed", "turkstat_migration_cit_and_prov.rds"))

prov_emigrants <- turkstat_migration_cit_and_prov %>%
  select(year, province, emigrants_turkish)

prov_emigrants <- prov_emigrants %>%
  group_by(year) %>%
  summarise(total_emigration = sum(emigrants_turkish)) %>%
  dplyr::inner_join(complete_oecd_emigration, by = 'year')


prov_emigrants %>%
  mutate(emig_to_de = total_emigration * pct_emigration_to_de, .before = 2) %>%
  select(year, emig_to_de)


#######
turkstat_migration <- readRDS(here("data", "processed", "turkstat_migration.rds"))

emigration <- turkstat_migration %>%
  select(year, `citizenship (turkish)`, emigrants_total) %>%
  filter(`citizenship (turkish)` == "Türk vatandaşları") %>%
  dplyr::inner_join(complete_oecd_emigration, by = 'year') %>%
  mutate(emig_total = emigrants_total * pct_emigration_to_de, .before = 2) %>%
  arrange(year)


emigration




#########
turkstat_migration_prov <- readRDS(here("data", "processed", "turkstat_migration_by_providence.rds"))





########
turkstat_pop_age_prov_sex <- readRDS(here("data", "processed", "turkstat_pop_age_prov_sex.rds"))







##########
turkstat_migration_prov_and_reason <- readRDS(here("data", "processed", "turkstat_migration_prov_and_reason.rds"))

turkstat_migration_prov_and_reason %>%
  group_by(year) %>%
  summarise(total = sum(total))


# Calculate percentages for each migration reason by province and year
migration_percentages <- turkstat_migration_prov_and_reason %>%
  # First pivot to long format (excluding the total column)
  pivot_longer(
    cols = -c(year, Province, total),
    names_to = "reason",
    values_to = "count"
  ) %>%
  # Group by year and province
  group_by(year, Province) %>%
  # Calculate percentage for each reason
  mutate(
    percentage = round((count / total) * 100, 2)
  ) %>%
  # Sort by province and percentage (descending)
  arrange(year, Province, desc(percentage))

# View the result
head(migration_percentages, 10)



# Calculate overall proportions for each migration reason by year
migration_proportions_by_year <- turkstat_migration_prov_and_reason %>%
  # Group by year
  group_by(year) %>%
  # Calculate sum for each migration reason
  summarize(
    total_migrants = sum(total),
    job_change_prop = round(sum(`\nchange of job`) / sum(total) * 100, 2),
    start_job_prop = round(sum(`Starting or finding a job`) / sum(total) * 100, 2),
    education_prop = round(sum(Education) / sum(total) * 100, 2),
    family_reasons_prop = round(sum(`family-related reasons`) / sum(total) * 100, 2),
    better_housing_prop = round(sum(`Better housing and living conditions`) / sum(total) * 100, 2),
    household_related_prop = round(sum(`Migration related to any member of the household`) / sum(total) * 100, 2),
    returning_home_prop = round(sum(`Returning to family home`) / sum(total) * 100, 2),
    health_prop = round(sum(Health) / sum(total) * 100, 2),
    house_purchase_prop = round(sum(`Buying a house`) / sum(total) * 100, 2),
    retirement_prop = round(sum(Retirement) / sum(total) * 100, 2),
    other_prop = round(sum(Other) / sum(total) * 100, 2),
    unknown_prop = round(sum(Unknown) / sum(total) * 100, 2)
  )

# Now pivot to get reasons by row
migration_proportions_by_year_long <- migration_proportions_by_year %>%
  pivot_longer(
    cols = -c(year, total_migrants),
    names_to = "reason",
    values_to = "percentage"
  ) %>%
  # Sort by year and percentage (descending)
  arrange(year, desc(percentage)) %>%
  select(-total_migrants)
migration_proportions_by_year_long

migration_proportions_by_year_long %>% print(n=60)


# Starting with our wide format data
education_and_job_summary <- turkstat_migration_prov_and_reason %>%
  # Group by year
  group_by(year) %>%
  # Calculate the percentages and their sum
  summarize(
    total_migrants = sum(total),
    education_prop = round(sum(Education) / sum(total) * 100, 2),
    job_change_prop = round(sum(`\nchange of job`) / sum(total) * 100, 2),
    start_job_prop = round(sum(`Starting or finding a job`) / sum(total) * 100, 2),
    better_conditions = round(sum(`Better housing and living conditions`) / sum(total) * 100, 2),
    education_and_job_total = round(
      (sum(Education) + sum(`Better housing and living conditions`) + sum(`\nchange of job`) + sum(`Starting or finding a job`)) / sum(total) * 100, 2
    )/100
  ) %>% select(year, education_and_job_total)



emigration %>%
  mutate(alt_metric = emigrants_total*pct_emigration_to_de) %>%
  select(year, alt_metric) %>%
  inner_join(education_and_job_summary, by = 'year') %>%
  mutate(total = alt_metric*education_and_job_total)



emigration %>% select(year, emigrants_total) %>%
  inner_join(oecd_emigration, by = 'year') %>%
  select(-total_emigration_to_de) %>%
  inner_join(education_and_job_summary, by = 'year') %>%
  mutate(emig_to_de = emigrants_total*pct_emigration_to_de*education_and_job_total, .before = 2)


oecd_emigration %>% select(year, total_emigration_to_de) %>%
  inner_join(education_and_job_summary, by = 'year') %>%
  mutate(emig_to_de = total_emigration_to_de*education_and_job_total, .before = 2)


names(turkstat_migration_prov_and_reason)

