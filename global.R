library(readxl)
data.all <- read_excel("WorldMap_DummyData_andrea_v2.xlsx")
names(data.all) <- gsub(" ","_",names(data.all))

data.all <- readRDS("data_mrg.rda")

i.list <- list(
    "Financial Success" = "fsu_i",
    "Entrepreneurship" = "es_i",
    "Positive Work Relationships" = "pwr_i",
    "Positive Impact" = "pi_i",
    "Learning and Development" = "ld_i",
    "Work-Life Balance" = "wlb_i",
    "Financial Security" = "fse_i")

a.list <- list(
    "Financial Success" = "fsu_a",
    "Entrepreneurship" = "es_a",
    "Positive Work Relationships" = "pwr_a",
    "Positive Impact" = "pi_a",
    "Learning and Development" = "ld_a",
    "Work-Life Balance" = "wlb_a",
    "Financial Security" = "fse_a")

gap.list <- list(
    "Financial Success" = "fsu_gap",
    "Entrepreneurship" = "es_gap",
    "Positive Work Relationships" = "pwr_gap",
    "Positive Impact" = "pi_gap",
    "Learning and Development" = "ld_gap",
    "Work-Life Balance" = "wlb_gap",
    "Financial Security" = "fse_gap")

ind.list <- list(
    "WorkSuc" = "WorkSuc",
    "Occchange" = "Occchange",
    "Empchange" = "Empchange",
    "Promotion" = "Promotion",
    "CareerBeh" = "CareerBeh",
    "IntQuit" = "IntQuit",
    "Supervisor" = "Supervisor",
    "OrgCom" = "OrgCom",
    "Employ" = "Employ",
    "Orginvest" = "Orginvest",
    "LifeSat" = "LifeSat",
    "Health" = "Health",
    "Educ" = "Educ"
)

cnt.list <- list(
    "GDP" = "GDP",
    "Global Competitiveness Score" =  "GCS",
    "Post-transfer Gini" =  "PGini",
    "Poverty rate" = "Pov",
    "Education/Skills" = "Edu"
)
