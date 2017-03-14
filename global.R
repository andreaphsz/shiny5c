library(readxl)
data.all <- read_excel("WorldMap_DummyData_andrea_v2.xlsx")
names(data.all) <- gsub(" ","_",names(data.all))
