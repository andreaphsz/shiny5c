library(readxl)
data.all <- read_excel("WorldMap_DummyData_andrea.xlsx")
names(data.all) <- gsub(" ","_",names(data.all))
