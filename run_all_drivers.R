library("foreach")
library("doParallel")

#PURPOSE: this file will run the analysis for all the drivers
#TODO: allow this to write to the file by appending instead of joining a large data.frame

write_driver = function(driver){
  write.table(round(get_trip_data(driver), 6), file=paste0("driver_features/", driver,".csv"), sep=",", col.names=NA)
}

#this queues up a 3-core parallel solution; leaves one for the rest of the computer
registerDoParallel(cores = 3)

#go through the drivers and find the ones that are real
driver.list = as.numeric(dir("drivers", include.dirs = TRUE))
#driver.list = read.csv("redo_drivers.txt")
#driver.list = driver.list$trip

#run the dopar solution and combine rows together (looks like this will fail)
foreach (index=1:length(driver.list)) %dopar% write_driver(driver.list[index])
  
  #analyze_driver(driver.list[index])

#write the answers out to a single file (will need to re-do this on failures)
#write.csv(file="results/all.csv", x = all_probs, row.names=FALSE)

stopImplicitCluster()