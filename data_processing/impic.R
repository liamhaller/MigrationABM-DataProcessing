#IMPIC: Dataset of Immigration Policies in Comparison


impic_path <- here("data", "raw", "IMPICDatasetV2_1980-2018.dta")


impic <- haven::read_dta(file = impic_path)

#Restrict
impic <- impic %>% filter(cntry %in% c('de'))

impic <- impic %>% select(cntry,
                          year,
                          CCode,
                          AvgS_ImmPol, #index_immigration_policy_overall
                          AvgS_ExtCont,
                          AvgS_IntCont,
                          AvgS_Cont,
                          dplyr::contains('_b'),
                          expert,
                          name
                         )





# Rename impic columns  ---------------------------------------------------

# Script to rename IMPIC columns with more descriptive names

col_mapping <- list(
  # Country and year identifiers
  "cntry" = "country_code",
  "year" = "year",
  "CCode" = "correlates_of_war_code",

  # Field A: Family Reunification indicators
  "AvgS_a01" = "family_residence_requirements",
  "AvgS_a02" = "family_members_eligibility",
  "AvgS_a03" = "family_age_limits",
  "AvgS_a04" = "family_financial_requirements",
  "AvgS_a05" = "family_accommodation_requirements",
  "AvgS_a06" = "family_language_skills",
  "AvgS_a07" = "family_application_fees",
  "AvgS_a08" = "family_residence_permit",
  "AvgS_a09" = "family_autonomous_residence_permit",
  "AvgS_a10" = "family_employment_rights",
  "AvgS_a12" = "family_reunification_quotas",

  # Field B: Labor Migration indicators
  "AvgS_b01_2" = "labor_targeting",
  "AvgS_b02" = "labor_quotas",
  "AvgS_b03_1_min" = "labor_age_limits_minimum",
  "AvgS_b03_2" = "labor_young_age_beneficial",
  "AvgS_b04" = "labor_financial_sustainability",
  "AvgS_b04_a" = "labor_specific_income_per_month",
  "AvgS_b04_b" = "labor_specific_financial_funds",
  "AvgS_b05" = "labor_language_skills",
  "AvgS_b06" = "labor_application_fee",
  "AvgS_b07" = "labor_job_offer",
  "AvgS_b08" = "labor_equal_work_conditions",
  "AvgS_b09_1" = "labor_list_of_occupations",
  "AvgS_b09_2" = "labor_market_test",
  "AvgS_b10_max" = "labor_work_permit_validity",
  "AvgS_b11_1" = "labor_permit_renewal",
  "AvgS_b11_2" = "labor_transition_temporary_permanent",
  "AvgS_b12" = "labor_loss_of_employment",
  "AvgS_b13" = "labor_work_permit_flexibility",

  # Field C: Asylum indicators
  "AvgS_c01_2" = "asylum_subsidiary_protection_existence",
  "AvgS_c02" = "asylum_nationality_restrictions",
  "AvgS_c03" = "asylum_quotas",
  "AvgS_c04" = "asylum_safe_third_country",
  "AvgS_c05" = "asylum_safe_countries_of_origin",
  "AvgS_c06" = "asylum_place_of_application",
  "AvgS_c07" = "asylum_permit_validity",
  "AvgS_c08" = "asylum_permit_renewal",
  "AvgS_c09" = "asylum_right_to_appeal",
  "AvgS_c10" = "asylum_status_when_crisis_resolved",
  "AvgS_c11" = "asylum_free_movement",
  "AvgS_c12" = "asylum_employment_rights",
  "AvgS_c14" = "asylum_benefits_form",
  "AvgS_c15" = "asylum_resettlement_agreements",

  # Field D: Co-Ethnics indicators
  "AvgS_d03_1" = "coethnic_reasons_eligibility",
  "AvgS_d03_2" = "coethnic_language_skills",
  "AvgS_d03_3" = "coethnic_converts",
  "AvgS_d03_4" = "coethnic_ancestry",
  "AvgS_d04" = "coethnic_country_of_residence",
  "AvgS_d05" = "coethnic_place_of_application",
  "AvgS_d06" = "coethnic_quotas",
  "AvgS_d08" = "coethnic_date_of_birth",
  "AvgS_d09_0" = "coethnic_access_to_citizenship",
  "AvgS_d09_1" = "coethnic_residence_permit_duration",
  "AvgS_d10" = "coethnic_region_of_settlement",
  "AvgS_d11" = "coethnic_employment_program",
  "AvgS_d12" = "coethnic_integration_measures",

  # Control mechanisms (Field E) indicators
  "AvgS_e01" = "control_illegal_residence",
  "AvgS_e02" = "control_aiding_irregular_immigrants",
  "AvgS_e03" = "control_airline_carrier_penalties",
  "AvgS_e04" = "control_identification_documents",
  "AvgS_e05" = "control_aliens_register",
  "AvgS_e06" = "control_information_sharing",
  "AvgS_e07" = "control_biometric_information",
  "AvgS_e08" = "control_forged_expired_documents",
  "AvgS_e09" = "control_amnesty_programs",
  "AvgS_e10" = "control_public_schooling_access",
  "AvgS_e11" = "control_employer_sanctions",
  "AvgS_e12" = "control_marriage_of_convenience",
  "AvgS_e13" = "control_detention",

  # Index scores for each field
  "AvgS_elig_A" = "index_eligibility_family",
  "AvgS_elig_B" = "index_eligibility_labor",
  "AvgS_elig_C" = "index_eligibility_asylum",
  "AvgS_elig_D" = "index_eligibility_coethnic",

  "AvgS_cond_A" = "index_conditions_family",
  "AvgS_cond_B" = "index_conditions_labor",
  "AvgS_cond_C" = "index_conditions_asylum",
  "AvgS_cond_D" = "index_conditions_coethnic",

  "AvgS_righ_A" = "index_rights_family",
  "AvgS_righ_B" = "index_rights_labor",
  "AvgS_righ_C" = "index_rights_asylum",
  "AvgS_righ_D" = "index_rights_coethnic",

  "AvgS_secu_A" = "index_security_family",
  "AvgS_secu_B" = "index_security_labor",
  "AvgS_secu_C" = "index_security_asylum",
  "AvgS_secu_D" = "index_security_coethnic",

  "AvgS_ExtReg_A" = "index_external_regulations_family",
  "AvgS_ExtReg_B" = "index_external_regulations_labor",
  "AvgS_ExtReg_C" = "index_external_regulations_asylum",
  "AvgS_ExtReg_D" = "index_external_regulations_coethnic",

  "AvgS_IntReg_A" = "index_internal_regulations_family",
  "AvgS_IntReg_B" = "index_internal_regulations_labor",
  "AvgS_IntReg_C" = "index_internal_regulations_asylum",
  "AvgS_IntReg_D" = "index_internal_regulations_coethnic",

  "AvgS_Reg_A" = "index_regulations_family",
  "AvgS_Reg_B" = "index_regulations_labor",
  "AvgS_Reg_C" = "index_regulations_asylum",
  "AvgS_Reg_D" = "index_regulations_coethnic",

  # Composite indexes
  "AvgS_ExtCont" = "index_external_controls",
  "AvgS_IntCont" = "index_internal_controls",
  "AvgS_Cont" = "index_controls_overall",
  "AvgS_ImmPol" = "index_immigration_policy_overall",

  # Administrative information
  "R_adm_guide" = "admin_guidelines_use",
  "R_adm_guide_A" = "admin_guidelines_family",
  "R_adm_guide_B" = "admin_guidelines_labor",
  "R_adm_guide_C" = "admin_guidelines_asylum",
  "R_adm_guide_D" = "admin_guidelines_coethnic",
  "R_adm_guide_E" = "admin_guidelines_control",
  "R_adm_guide_F" = "admin_guidelines_other",

  "expert" = "expert_change_indicator",
  "name" = "name"
)


# Get the columns in the dataframe that are also in our mapping
existing_cols <- names(impic)[names(impic) %in% names(col_mapping)]

# Create a new named vector for renaming
new_names <- unlist(col_mapping[existing_cols])

# Rename the columns using dplyr's rename_at (if you have dplyr loaded)
impic <- impic %>%
  rename_with(~new_names[which(existing_cols == .x)], all_of(existing_cols))


rm(col_mapping, impic_path, new_names)


# Save data ---------------------------------------------------------------

saveRDS(object = impic, here("data", "processed", "impic_data.rds"))

