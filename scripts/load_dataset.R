for ( file in list.files(path = "fitbit_data/Fitabase Data 4.12.16-5.12.16")){
  path <- paste0("fitbit_data/Fitabase Data 4.12.16-5.12.16/",file)
  name <- paste0(substr(file,1,nchar(file)-11) )
  assign(name, read.csv(path))
  print(name)}