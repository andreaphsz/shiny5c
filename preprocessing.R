library(foreign)
library(data.table)  # browseVignettes("data.table")

### 5c data
fn <- "5c_merged_dataset_jan_2018_31_countries_visualization.sav"
data.spss <- read.spss(fn, use.value.labels = FALSE, to.data.frame = TRUE)
data.all <- data.table(data.spss)

## compute scales
a <- names(data.all)
ach <- a[grep("(.*)_[[:digit:]]+A$", a)]
imp <- a[grep("(.*)_[[:digit:]]+I$", a)]

## (BasNec_1I + ProFFin_9I + FinSec_10I)/3 → Financial Security (Importance)
## (PosRel_3I + PosRelS_5I + PosFeSup_3I + PosFeCol_5I)/4 → Positive Work Relations (Importance)
## (AchW_6I + ReceIPB_8I + MakMo_10I)/3 → Financial Success (Importance)
## (ContLearn_15I + OppLearn_18i + Inn_19I + Chall_20I)/4 → Learning and Development (Importance)
## (WorkFamB_44I + NonWln_45I + BalanWNW_46I)/3 → Work-Life Balance (Importance)
## (DevelOth_47I + HelpOth_48I + LeavPB_27I)/3 → Positive Impact (Importance)
## (SelfEmp_11I + OwnComp_12I + RunOwnBus_70I )/3 → Entrepreneurship (Importance)

## (BasNec_50A + ProFFin_51A + FinSec_52A)/3 → Financial Security (Achievement)
## (PosRel_37A + PosRelS_38A + PosFeSup_41A + PosFeCol_42A)/4 → Positive Work Relations (Achievement)
## (AchW_6A+ReceIPB_8A+MakMo_10A)/3 → Financial Success (Achievement)
## (ContLearn_15A + OppLearn_18A + Inn_19A + Chall_20A)/4 → Learning and Development (Achievement)
## (WorkFamB_44A+NonWln_45A+BalanWNW_46A)3 → Work-Life Balance (Achievement)
## (DevelOth_47A + HelpOth_48A + LeavPB_27A)/3 → Positive Impact (Achievement)
## (SelfEmp_11A + OwnComp_12A + RunOwnBus_70A )/3 → Entrepreneurship (Achievement)

fse.i <- vars <- c("BasNec_1I", "ProFFin_9I", "FinSec_10I")  # alpha=0.62
pwr.i <- vars <- c("PosRel_3I", "PosRelS_5I", "PosFeSup_3I", "PosFeCol_5I") # alpha=0.72
##fsu.i <- vars <- c("AchW_6I", "ReceIPB_8I", "MakMo_10I")
## --> column(s) not found: AchW_6I, ReceIPB_8I
fsu.i <- vars <- c("AchW_1I", "ReceIPB_6I", "MakMo_10I")  # alpha=0.71
##ld.i  <- vars <- c("ContLearn_15I", "OppLearn_18i", "Inn_19I", "Chall_20I")
## --> column(s) not found: ContLearn_15I, OppLearn_18i, Inn_19I, Chall_20I
ld.i  <- vars <- c("ContLearn_2I",  "OppLearn_7I",  "Inn_9I",  "Chall_6I")  # alpha=0.77
##wlb.i <- vars <- c("WorkFamB_44I", "NonWln_45I", "BalanWNW_46I")
## --> column(s) not found: WorkFamB_44I, NonWln_45I, BalanWNW_46I
wlb.i <- vars <- c("WorkFamB_8I",  "NonWln_2I",  "BalanWNW_4I")  # alpha=0.68
##pi.i  <- vars <- c("DevelOth_47I", "HelpOth_48I", "LeavPB_5I")
## --> column(s) not found: DevelOth_47I, HelpOth_48I, LeavPB_27I
pi.i  <- vars <- c("DevelOth_8I", "HelpOth_1I", "LeavPB_5I")  # alpha=0.72
##es.i  <- vars <- c("SelfEmp_11I", "OwnComp_12I", "RunOwnBus_70I")
## --> column(s) not found: SelfEmp_11I, OwnComp_12I, RunOwnBus_70I
es.i  <- vars <- c("SelfEmp_4I", "OwnComp_2I", "RunOwnBus_10I")  # alpha=0.86

fse.a <- vars <- c("BasNec_1A", "ProFFin_9A", "FinSec_10A")  # alpha=0.76
pwr.a <- vars <- c("PosRel_3A", "PosRelS_5A", "PosFeSup_3A", "PosFeCol_5A") # alpha=0.75
fsu.a <- vars <- c("AchW_1A", "ReceIPB_6A", "MakMo_10A")  # alpha=0.75
ld.a  <- vars <- c("ContLearn_2A",  "OppLearn_7A",  "Inn_9A",  "Chall_6A")  # alpha=0.81
wlb.a <- vars <- c("WorkFamB_8A",  "NonWln_2A",  "BalanWNW_4A")  # alpha=0.8
pi.a  <- vars <- c("DevelOth_8A", "HelpOth_1A", "LeavPB_5A")  # alpha=0.71
es.a  <- vars <- c("SelfEmp_4A", "OwnComp_2A", "RunOwnBus_10A")  # alpha=0.85

psych::alpha(data.all[, vars, with=FALSE])

data.all[, `:=`(fse_i = rowMeans(.SD, na.rm=TRUE)), .SDcols = fse.i]
data.all[, `:=`(pwr_i = rowMeans(.SD, na.rm=TRUE)), .SDcols = pwr.i]
data.all[, `:=`(fsu_i = rowMeans(.SD, na.rm=TRUE)), .SDcols = fsu.i]
data.all[, `:=`(ld_i  = rowMeans(.SD, na.rm=TRUE)), .SDcols = ld.i]
data.all[, `:=`(wlb_i = rowMeans(.SD, na.rm=TRUE)), .SDcols = wlb.i]
data.all[, `:=`(pi_i  = rowMeans(.SD, na.rm=TRUE)), .SDcols = pi.i]
data.all[, `:=`(es_i  = rowMeans(.SD, na.rm=TRUE)), .SDcols = es.i]

data.all[, `:=`(fse_a = rowMeans(.SD, na.rm=TRUE)), .SDcols = fse.a]
data.all[, `:=`(pwr_a = rowMeans(.SD, na.rm=TRUE)), .SDcols = pwr.a]
data.all[, `:=`(fsu_a = rowMeans(.SD, na.rm=TRUE)), .SDcols = fsu.a]
data.all[, `:=`(ld_a  = rowMeans(.SD, na.rm=TRUE)), .SDcols = ld.a]
data.all[, `:=`(wlb_a = rowMeans(.SD, na.rm=TRUE)), .SDcols = wlb.a]
data.all[, `:=`(pi_a  = rowMeans(.SD, na.rm=TRUE)), .SDcols = pi.a]
data.all[, `:=`(es_a  = rowMeans(.SD, na.rm=TRUE)), .SDcols = es.a]

data.all[, fse_gap := fse_a - fse_i]
data.all[, pwr_gap := pwr_a - pwr_i]
data.all[, fsu_gap := fsu_a - fsu_i]
data.all[, ld_gap  := ld_a  - ld_i]
data.all[, wlb_gap := wlb_a - wlb_i]
data.all[, pi_gap  := pi_a  - pi_i]
data.all[, es_gap  := es_a  - es_i]

## plot hist of data
data <- data.frame(data.all)
png(file="hist.png", width=800, height=1600, res=150)
par(mfcol=c(7,3))
for (j in 298:318) print(hist(data[,j], main=names(data)[j]))
dev.off()

### compute/collect variables
varl <- list()
varl[[1]] <- paste0(c("fse","pwr","fsu","ld","wlb","pi","es"),
               rep( c("_i","_a","_gap"), each=7))

### individual factors
### Reference: "Career Questionnaire"
labs <- attr(data.spss, "variable.labels")

find.labs <- function(str) {
    labs[grep(str, labs, ignore.case=TRUE)]
}

## 7. Overall, how successful do you feel your career has been to date?
data.all$WorkSuc[data.all$WorkSuc == 999] <- NA
varl[[2]] <- "WorkSuc"

## 11. How many occupations have you worked in
varl[[3]] <- "Occchange"

## How many employers (including yourself) have you worked for?
varl[[4]] <- "Empchange"

## How many promotions have you received during your whole working life?
varl[[5]] <- "Promotion"

## 14. Please indicate to what extent you have practiced the following behaviors in the past year.
vars <- paste0("CareerBeh_",1:5)
psych::alpha(data.all[, vars, with=FALSE])  # alpha=0.86
data.all[,`:=`(CareerBeh = rowMeans(.SD, na.rm=TRUE)), .SDcols=vars]
varl[[6]] <- "CareerBeh"

## 15. To what extent do you agree or disagree with the following statements?
vars <- paste0("IntQuit_", 1:3)
psych::alpha(data.all[, vars, with=FALSE])  # alpha=0.92
data.all[,`:=`(IntQuit = rowMeans(.SD, na.rm=TRUE)), .SDcols=vars]
varl[[7]] <- "IntQuit"

## 24. The questions below concern your supervisor.
## todo: Supervisor_4 is reversed -> is this allready done in the data?
data.all[,`:=`(Supervisor_4R = Supervisor_4*(-1)+8)]
vars <- paste0("Supervisor_", c(1:3,"4R"))
psych::alpha(data.all[, vars, with=FALSE])  # alpha=0.86
data.all[,`:=`(Supervisor = rowMeans(.SD, na.rm=TRUE)), .SDcols=vars]
varl[[8]] <- "Supervisor"

## 26. To what extent do you agree or disagree with the following statements?
## todo: OrgCom_4,5,6,8 seem to be reversed -> allready in the data?
## todo: maybe drop OrgCom_4?
data.all[,`:=`(OrgCom_4R = OrgCom_4*(-1)+8,
               OrgCom_5R = OrgCom_5*(-1)+8,
               OrgCom_6R = OrgCom_6*(-1)+8,
               OrgCom_8R = OrgCom_8*(-1)+8)]
vars <- paste0("OrgCom_", c(1:3,"4R","5R","6R",7,"8R"))
psych::alpha(data.all[, vars, with=FALSE])  # alpha=0.79
data.all[,`:=`(OrgCom = rowMeans(.SD, na.rm=TRUE)), .SDcols=vars]
varl[[9]] <- "OrgCom"

## 27. To what extent do you agree or disagree with the following statements?
## todo: Employ_2 seem to be reversed -> allready in the data?
data.all[,`:=`(Employ_2R = Employ_2*(-1)+8)]
vars <- paste0("Employ_", c(1,"2R",3))
psych::alpha(data.all[, vars, with=FALSE])  # alpha=0.76
data.all[,`:=`(Employ = rowMeans(.SD, na.rm=TRUE)), .SDcols=vars]
varl[[10]] <- "Employ"

## 28. Please indicate the degree to which you agree or disagree
## with the following statements about your organisation.
vars <- paste0("Orginvest_", 1:7)
psych::alpha(data.all[, vars, with=FALSE])  # alpha=0.92
data.all[,`:=`(Orginvest = rowMeans(.SD, na.rm=TRUE)), .SDcols=vars]
varl[[11]] <- "Orginvest"

## 29. To what extent do you agree or disagree with the following statements?
## todo: there are intermediate values in the data? should be 1,2,...,6(,7)
## Vigor scale
vars <- paste0("WorkEng_", 1:3)
#varl[[12]] <- "WorkEng_Vigor"

## Dedication scale
vars <- paste0("WorkEng_", 4:6)
#varl[[13]] <- "WorkEng_Dedi"

## Absorption scale
vars <- paste0("WorkEng_", 7:9)
#varl[[14]] <- "WorkEng_Abs"

## 30. To what extent do you agree or disagree with the following statements?
vars <- paste0("LifeSat_", 1:5)
psych::alpha(data.all[, vars, with=FALSE])  # alpha=0.89
data.all[,`:=`(LifeSat = rowMeans(.SD, na.rm=TRUE)), .SDcols=vars]
varl[[15]] <- "LifeSat"

## 31. In general would you say your health is?
varl[[16]] <- "Health"

## 42. Which is the highest level of education that you [...] completed?
varl[[17]] <- "Educ"

## 44. What is your pre-tax individual employment income in the last financial year
## todo: very large scale. we might compute log instead original scale.
## todo: some countries with all 0 entries
data.all[,`:=`(Salary_log = log10(Salary))]
data.all$Salary_log[data.all$Salary_log == -Inf] <- NA  # Salary == 0
#varl[[18]] <- "Salary_log"

### aggregate
## clean up country names
data.all[, `:=`(COUNTRY = trimws(COUNTRY))]
data.all$COUNTRY[data.all$COUNTRY == "NIGERIA"] <- "Nigeria"
data.all$COUNTRY[data.all$COUNTRY == "TURKEY"] <- "Turkey"

## agg
vars.agg <- do.call(c, varl)
data.agg <- data.all[, lapply(.SD, mean, na.rm=TRUE),
                     by=COUNTRY, .SDcols=vars.agg]

### macro factors
library(readxl)

fn <- "macro_factors_visualization.xlsx"
data.mac <- data.table(read_xlsx(fn))
names(data.mac) <- c("COUNTRY","GDP","GCS","PGini","Pov","Edu")

###  merge
data.mrg <- data.agg[data.mac, on = "COUNTRY"]

