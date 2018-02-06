library(foreign)
library(data.table)

### 5c data
fn <- "5c_merged_dataset_jan_2018_31_countries_visualization.sav"
data.all <- data.table(read.spss(fn, use.value.labels = FALSE, to.data.frame = TRUE))

a <- names(data.all)
ach <- a[grep("(.*)_[[:digit:]]+A$", a)]
imp <- a[grep("(.*)_[[:digit:]]+I$", a)]

### macro factors
library(readxl)

fn <- "macro_factors_visualization.xlsx"
data.mac <- data.table(read_xlsx(fn))

### aggregate and merge
