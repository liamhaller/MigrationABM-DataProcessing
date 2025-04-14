#Location of visa data
eumagine_path <- here("data", "raw", "Individual questionnaire - STUM 20121001 - incl hh and mgcount - mv.dta")

eumagine <- read_dta(eumagine_path)

#Filter for only turkey data
eumagine <- eumagine %>% filter(country == 2)


# Process data ------------------------------------------------------------

  eumagine <- eumagine %>% rename(
    # Basic identifiers
    household_id = HHid,
    interview_date = date_ind,
    interviewer_id = INTERVIEWERid,
    respondent_id = PERSONid,
    country_code = country,
    research_area = ra,

    # Migration aspirations
    migration_aspiration = a1,         # ideally, would like to go abroad to live/work
    preferred_country = a2,            # which country would like to go to
    migration_intention = a3,          # will try to go to that country within 5 years

    # Networks
    has_family_abroad = mg1,           # family members living abroad
    has_family_migration_history = mg10, # family members lived abroad
    has_non_family_contacts_abroad = mg18, # knows people abroad

    # Perceptions of home country
    life_women_home = p1,              # life of women in home country
    life_men_home = p2,                # life of men in home country
    schools_home = p3,                 # schools in home country
    healthcare_home = p4,              # healthcare in home country
    govt_aid_home = p5,                # government help for poor people
    corruption_home = p6,              # corruption in home country
    politician_trust_home = p7,        # politicians do what's best for people
    job_opportunity_home = p8,         # easy to find good job in home country
    safety_home = p9,                  # dangerous to walk at night
    gender_equality_home = p10,        # women have same opportunities as men
    free_speech_home = p11,            # can say whatever they want in public
    local_politician_trust = p12,      # local politicians do what's best for people

    # Perceptions of Europe
    life_women_europe = peu1,          # life of women in Europe
    life_men_europe = peu2,            # life of men in Europe
    schools_europe = peu3,             # schools in Europe
    healthcare_europe = peu4,          # healthcare in Europe
    govt_aid_europe = peu5,            # government help for poor people
    corruption_europe = peu6,          # corruption in Europe
    politician_trust_europe = peu7,    # politicians do what's best for people
    job_opportunity_europe = peu8,     # easy to find good job in Europe
    safety_europe = peu9,              # dangerous to walk at night
    gender_equality_europe = peu10,    # women have same opportunities as men
    free_speech_europe = peu11,        # can say whatever they want in public

    # Perceptions of migrants
    eu_migration_encouragement = a5,   # anyone encouraged to go to Europe
    migrants_get_rich = a15,           # migrants become rich
    migrants_gain_skills = a16,        # migrants gain valuable skills
    migrants_lose_family_ties = a17,   # migrants lose touch with family

    # Demographics
    gender = hh3,                      # sex of respondent
    age = age,                         # age of respondent
    education_years = hh7,             # years of schooling
    occupation = hh8,                  # principal activity
    marital_status = hh9,              # marital status
    religion = i3,                     # religion

    # Migration capability
    has_passport = a18,                # ever had passport
    has_valid_passport = a19,          # currently has valid passport
    applied_eu_visa = a21,             # applied for EU visa
    obtained_non_eu_visa = a22,        # obtained non-EU visa

    # Life satisfaction
    life_satisfaction = l1,            # overall life satisfaction
    financial_satisfaction = l2,       # satisfaction with financial situation
    living_standard = l5,               # statement about living conditions

    spouse_location = cf1a,               # where does your partner live
    spouse_household_id = cf1a1,          # partner ID from household
    spouse_location_code = cf1a2,         # partner location code
    spouse2_location = cf1b,              # where does spouse2 live
    spouse2_household_id = cf1b1,         # spouse2 ID from household
    spouse2_location_code = cf1b2,        # spouse2 location code
    spouse3_location = cf1c,              # where does spouse3 live
    spouse3_household_id = cf1c1,         # spouse3 ID from household
    spouse3_location_code = cf1c2,        # spouse3 location code
    spouse4_location = cf1d,              # where does spouse4 live
    spouse4_household_id = cf1d1,         # spouse4 ID from household
    spouse4_location_code = cf1d2,        # spouse4 location code
    father_location = cf2,                # where does your father live
    father_household_id = cf201,          # father ID from household
    father_location_code = cf202,         # father location code
    father_lived_abroad = cf3,            # has father lived in another country
    father_country_lived = cf301,         # country where father lived longest
    mother_location = cf4,                # where does your mother live
    mother_household_id = cf401,          # mother ID from household
    mother_location_code = cf402,         # mother location code
    mother_lived_abroad = cf5,            # has mother lived in another country
    mother_country_lived = cf501,         # country where mother lived longest
    has_children_in_household = cf6,      # children living in household
    child1_id = cf601,                    # ID of child 1
    child2_id = cf602,                    # ID of child 2
    child3_id = cf603,                    # ID of child 3
    child4_id = cf604,                    # ID of child 4
    child5_id = cf605,                    # ID of child 5
    child6_id = cf606,                    # ID of child 6
    child7_id = cf607,                    # ID of child 7
    child8_id = cf608,                    # ID of child 8
    child9_id = cf609,                    # ID of child 9
    child10_id = cf6010,                  # ID of child 10
    child11_id = cf6011,                  # ID of child 11
    child12_id = cf6012,                  # ID of child 12
    child13_id = cf6013,                  # ID of child 13
    child14_id = cf6014,                  # ID of child 14
    child15_id = cf6015,                  # ID of child 15
    has_children_outside_household = cf7, # children not living in household
    children_outside_count = cf701,       # number of children outside household

    # Migration perception questions
    europe_countries_perception = a401,   # countries thought of for Europe
    europe_country1_name = a41_place,     # country 1 name
    europe_country2 = a402,               # country 2 code
    europe_country2_name = a42_place,     # country 2 name
    europe_country3 = a403,               # country 3 code
    europe_country3_name = a43_place,     # country 3 name
    europe_country4 = a404,               # country 4 code
    europe_country4_name = a44_place,     # country 4 name
    europe_country5 = a405,               # country 5 code
    europe_country5_name = a45_place,     # country 5 name
    europe_country6 = a406,               # country 6 code
    europe_country6_name = a46_place,     # country 6 name
    europe_country7 = a407,               # country 7 code
    europe_country7_name = a47_place,     # country 7 name
    europe_country8 = a408,               # country 8 code
    europe_country8_name = a48_place,     # country 8 name
    europe_country9 = a409,               # country 9 code
    europe_country9_name = a49_place,     # country 9 name

    # Encouragement network - who encouraged migration
    spouse_in_country = a6010a,           # spouse in this country
    spouse_in_europe = a6010b,            # spouse in Europe
    spouse_elsewhere = a6010c,            # spouse elsewhere abroad
    partner_in_country = a6020a,          # girlfriend/boyfriend in this country
    partner_in_europe = a6020b,           # girlfriend/boyfriend in Europe
    partner_elsewhere = a6020c,           # girlfriend/boyfriend elsewhere
    son_in_country = a6030a,              # son in this country
    son_in_europe = a6030b,               # son in Europe
    son_elsewhere = a6030c,               # son elsewhere
    daughter_in_country = a6040a,         # daughter in this country
    daughter_in_europe = a6040b,          # daughter in Europe
    daughter_elsewhere = a6040c,          # daughter elsewhere
    father_in_country = a6050a,           # father in this country
    father_in_europe = a6050b,            # father in Europe
    father_elsewhere = a6050c,            # father elsewhere
    mother_in_country = a6060a,           # mother in this country
    mother_in_europe = a6060b,            # mother in Europe
    mother_elsewhere = a6060c,            # mother elsewhere
    brother_in_country = a6070a,          # brother in this country
    brother_in_europe = a6070b,           # brother in Europe
    brother_elsewhere = a6070c,           # brother elsewhere
    sister_in_country = a6080a,           # sister in this country
    sister_in_europe = a6080b,            # sister in Europe
    sister_elsewhere = a6080c,            # sister elsewhere
    male_relative_in_country = a6090a,    # male relative in this country
    male_relative_in_europe = a6090b,     # male relative in Europe
    male_relative_elsewhere = a6090c,     # male relative elsewhere
    female_relative_in_country = a60100a, # female relative in this country
    female_relative_in_europe = a60100b,  # female relative in Europe
    female_relative_elsewhere = a60100c,  # female relative elsewhere
    male_nonrel_in_country = a60110a,     # male non-relative in this country
    male_nonrel_in_europe = a60110b,      # male non-relative in Europe
    male_nonrel_elsewhere = a60110c,      # male non-relative elsewhere
    female_nonrel_in_country = a60120a,   # female non-relative in this country
    female_nonrel_in_europe = a60120b,    # female non-relative in Europe
    female_nonrel_elsewhere = a60120c,    # female non-relative elsewhere

    # Respondent encouraged others to migrate
    encouraged_migration = a7,            # encouraged anyone to go to Europe
    encouraged_spouse = a801,             # encouraged spouse
    encouraged_partner = a802,            # encouraged girlfriend/boyfriend
    encouraged_son = a803,                # encouraged son
    encouraged_daughter = a804,           # encouraged daughter
    encouraged_father = a805,             # encouraged father
    encouraged_mother = a806,             # encouraged mother
    encouraged_brother = a807,            # encouraged brother
    encouraged_sister = a808,             # encouraged sister
    encouraged_male_relative = a809,      # encouraged male relative
    encouraged_female_relative = a8010,   # encouraged female relative
    encouraged_male_nonrel = a8011,       # encouraged male non-relative
    encouraged_female_nonrel = a8012,     # encouraged female non-relative

    # Family attitudes and community perceptions
    family_approval = a9,                 # family approval of migration
    young_men_preference = a10,           # where young men prefer to live
    young_women_preference = a11,         # where young women prefer to live
    migrants_treated_badly = a12,         # migrants treated badly in Europe
    migration_good_women = a13,           # migration good for women
    migration_good_men = a14,             # migration good for men

    # Migration capability
    obtained_eu_visa = a20,               # obtained visa for Europe
    applied_noneu_visa = a23,             # applied for non-EU visa
    applied_eu_university = a24,          # applied for EU university
    applied_noneu_university = a25,       # applied for non-EU university
    contacted_eu_work_agent = a26,        # contacted agent for EU work
    contacted_noneu_work_agent = a27,     # contacted agent for non-EU work
    best_migration_country = a28,         # best country to migrate to
    papers_migration_decision = a29,      # if given papers, would migrate
    migration_reason = a30,               # reason for migration decision
    country_movement_preference = a31,    # preference for movement within country

    # Additional home country perceptions
    language_respect_home = p13,          # govt respects different languages
    hardwork_success_home = p14,          # can get ahead by working hard

    # Language and nationality
    childhood_language = i1,              # language spoken at age 7
    speaks_other_languages = i2,          # speaks other languages
    language1 = i201,                     # language 1
    language2 = i202,                     # language 2
    language3 = i203,                     # language 3
    language4 = i204,                     # language 4
    language5 = i205,                     # language 5
    language6 = i206,                     # language 6
    language1_proficiency = i20b01,       # proficiency in language 1
    language2_proficiency = i20b02,       # proficiency in language 2
    language3_proficiency = i20b03,       # proficiency in language 3
    language4_proficiency = i20b04,       # proficiency in language 4
    language5_proficiency = i20b05,       # proficiency in language 5
    language6_proficiency = i20b06,       # proficiency in language 6

    # Gender attitudes
    men_household_finance = i4,           # men responsible for finances
    education_boys_vs_girls = i5,         # education more important for boys
    unmarried_women_independence = i6,    # young unmarried women living alone
    mothers_not_work = i7,                # women with children should not work
    women_travel_permission = i8,         # women need permission to travel

    # Citizenship and nationality
    is_citizen = i9,                      # citizen of country of residence
    has_other_nationality = i10,          # has another nationality
    other_nationality1 = i11,             # which nationality 1
    other_nationality2 = i1102,           # which nationality 2
    other_nationality3 = i1103,           # which nationality 3
    has_residence_permit = i12,           # has residence permit for other country
    residence_permit_country1 = i13,      # which country 1
    residence_permit_country2 = i1302,    # which country 2
    residence_permit_country3 = i1303,    # which country 3

    # Additional Europe perceptions
    language_respect_europe = peu13,      # govts respect different languages
    hardwork_success_europe = peu14,      # can get ahead by working hard

    # Technology use
    internet_user = t1,                   # used internet in past 12 months
    has_email = t2,                       # has email address
    uses_messenger = t3a,                 # uses messenger program
    messenger_foreign_contact = t3b,      # uses messenger for foreign contacts
    uses_social_network = t4a,            # uses social networking site
    social_network_foreign_contact = t4b, # uses social network for foreign contacts
    uses_dating_site = t5a,               # uses dating website
    dating_site_foreign_contact = t5b,    # uses dating site for foreign contacts

    # Health and comparison
    health_status = l3,                   # general health status
    financial_comparison = l4,            # financial comparison with others
    parents_living_standard = l6,         # parents' standard of living comparison
    living_standard_trend = l7,           # standard of living getting better/worse

    # Household conditions and assets
    room_count = w1,                      # number of rooms in house
    has_electricity = w2,                 # has electricity
    has_toilet = w3,                      # has toilet
    has_hot_water = w4,                   # has hot water
    has_shower = w5,                      # has shower
    has_radio = w6,                       # has radio
    has_tv = w7,                          # has television
    has_satellite = w8,                   # has satellite dish
    has_video_player = w9,                # has video/DVD player
    has_telephone = w10,                  # has telephone
    has_computer = w11,                   # has computer
    has_internet = w12,                   # has internet
    has_refrigerator = w13,               # has refrigerator
    has_stove = w14,                      # has stove
    has_dishwasher = w15,                 # has dishwasher
    has_air_conditioning = w16,           # has air conditioning
    has_washing_machine = w17,            # has washing machine
    has_bicycle = w18,                    # has bicycle
    has_cart = w18B,                      # has cart (Senegal)
    has_motorcycle = w19,                 # has motorcycle
    has_car = w20,                        # has car
    housing_status = w21,                 # housing ownership status
    has_other_houses = w22,               # has other houses
    other_houses_count = w2201,           # number of other houses
    has_agricultural_land = w23,          # has agricultural land
    has_livestock = w24,                  # has livestock
    owns_business = w25,                  # owns non-farm business
    business_forestry = w2601,            # business: forestry
    business_fishing = w2602,             # business: fishing
    business_manufacturing = w2603,       # business: manufacturing
    business_artisan = w2604,             # business: artisan
    business_construction = w2605,        # business: construction
    business_shop = w2606,                # business: small shop
    business_commerce = w2607,            # business: large scale commerce
    business_hotel = w2608,               # business: hotel
    business_restaurant = w2609,          # business: restaurant
    business_taxi = w26010,               # business: taxi
    business_transport = w26011,          # business: transport
    business_education = w26012,          # business: education/health
    business_repair = w26013,             # business: repair shop
    business_service = w26014,            # business: other service
    business_other = w26015,              # business: other

    # Income sources
    income_main_source = w27a,            # main source of income
    income_second_source = w27b,          # second source of income
    income_third_source = w27c,           # third source of income

    # Interview quality indicators
    interview_language = iq1,             # language used in interview
    respondent_language_skill = iq2,      # how well respondent spoke language
    other_language_used = iq3,            # used other languages
    other_interview_language = iq4,       # which other language
    other_language_skill = iq5,           # how well respondent spoke other language
    understood_questions = iq6,           # understood questions
    interviewer_alone = iq701,            # interviewer alone with respondent
    household_members_present = iq702,    # household members present
    friends_present = iq703,              # friends present
    neighbors_present = iq704,            # neighbors present
    free_answering = iq801,               # respondent freely answered
    impression_constraints = iq802,       # impression respondent constrained
    asked_others_opinion = iq803,         # respondent asked others' opinions
    others_commented = iq804,             # others commented on answers

    # Administrative data
    interview_start_time = starttime_ind, # start time of interview
    interview_end_time = endtime_ind,     # end time of interview
    interview_duration = indivtime,       # duration of interview
    urban_rural = urban,                  # urban/rural status
    stratum = strat,                      # sampling stratum
    cluster = clust,                      # sampling cluster
    relation_to_head = hh2,               # relation to household head
    at_home_yesterday = hh5,              # was at home yesterday
    include_in_selection = hh6,           # include in selection
    respondent_birth_year = hh4,          # year of birth
    partner_in_another_country = hh10,    # partner living in another country
    birthplace = hh11,                    # where respondent was born
    arrival_year = hh12,                  # year came to research area
    lived_elsewhere = hh13,               # lived elsewhere
    returned_from_elsewhere = hh14,       # returned from elsewhere
    first_departure_year = hh15,          # year left for first time
    first_destination = hh16,             # first destination
    last_place_before_return = hh17,      # last place before return
    lived_abroad = hh18,                  # lived abroad for 3+ months
    return_year = hh19,                   # year returned
    household_grid_respondent = id_hhg,   # ID of household grid respondent
    first_selected_member = id1,          # ID of first selected member
    second_selected_member = id2,         # ID of second selected member
    household_size = hhsize,              # household size
    eligible_members = n_eligible,        # number eligible for interview
    household_interview_date = date,      # date of household interview
    household_start_time = starttime,     # start time of household interview
    supervisor_id = SUPERVISORid,         # supervisor ID
    data_entry_id = dataentryID,          # data entry ID
    data_entry_date = dateDE,             # data entry date
    household_end_time = endtime,         # end time of household interview
    households_at_address = Nr_of_households_at_address, # households at address
    age_group = n_agegroup,               # age group
    household_interview_duration = hhtime, # household interview duration
    secondary_sampling_unit = ssu,        # secondary sampling unit
    third_selected_member = id3,          # ID of third selected member
    random_number = rand,                 # random number
    migrant_grid1_count = mg1count,       # count in migrant grid 1
    migrant_grid2_count = mg2count,       # count in migrant grid 2
    migrant_grid3_count = mg3count,       # count in migrant grid 3
    total_eligible = toteligible,         # total eligible
    stratum_size = stratsize,             # stratum size
    sampling_weight = sweight,            # sampling weight
    country_additional = a4010            # additional country information
  )






# Save Data ---------------------------------------------------------------



saveRDS(object = eumagine, file =  here("data", "processed", "eumagine.rds"))
