## read data from disk
data.all <- readRDS("data_mrg.rda")

## define global variables
i.list <- list(
    "Financial Success" = "fsu_i",
    "Entrepreneurship" = "ent_i",
    "Positive Work Relationships" = "pwr_i",
    "Positive Impact" = "pim_i",
    "Learning and Development" = "lde_i",
    "Work-Life Balance" = "wlb_i",
    "Financial Security" = "fse_i")

a.list <- list(
    "Financial Success" = "fsu_a",
    "Entrepreneurship" = "ent_a",
    "Positive Work Relationships" = "pwr_a",
    "Positive Impact" = "pim_a",
    "Learning and Development" = "lde_a",
    "Work-Life Balance" = "wlb_a",
    "Financial Security" = "fse_a")

gap.list <- list(
    "Financial Success" = "fsu_gap",
    "Entrepreneurship" = "ent_gap",
    "Positive Work Relationships" = "pwr_gap",
    "Positive Impact" = "pim_gap",
    "Learning and Development" = "lde_gap",
    "Work-Life Balance" = "wlb_gap",
    "Financial Security" = "fse_gap")

ind.list <- list(
    "Overall Career Success" = "carsuc",
    "No. of Occupations" = "no_occ",
    "No. of Employers" = "no_emp",
    "No. of Promotions" = "no_prom",
    "Career Aspirations" = "carasp",
    "Turnover Intention" = "turnint",
    "Supervisor Support" = "svsupp",
    "Affective Commitment" = "affcom",
    "Employability" = "employ",
    "Employee development" = "pied",
    "Life Satisfaction" = "lifesat",
    "Health" = "health"
)

cnt.list <- list(
    "GDP" = "gdp",
    "Global Competitiveness Score" =  "gcs",
    "Gini Coefficient" =  "gini",
    "Poverty rate" = "povr",
    "Education/Skills" = "educ"
)

all.list <- list(i.list, a.list, gap.list, ind.list, cnt.list)

## read data info table from disk
info.tab <- readRDS("info_tab.rda")
