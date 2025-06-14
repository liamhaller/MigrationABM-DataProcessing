

lits <-readRDS(here("data", "processed", "lits.rds"))

table(lits$q505)

names(lits)

lits$region

lits$weight_trt

surveyexplorer::single_table(dataset = lits, question = q505, weights = weight_trt, group_by = region)

surveyexplorer::single_table(dataset = lits, question = q505, weights = weight_trt)
