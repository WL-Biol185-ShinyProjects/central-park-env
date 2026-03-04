#Renaming table variable names

#I want to get rid of all the spaces in between our variable names

colnames(central_park)<-gsub(" ","_",
                             colnames(central_park),
                             fixed=TRUE)

colnames(central_park_numeric_temp)<-gsub(".","_",
                                          colnames(central_park_numeric_temp),
                                          fixed=TRUE)

colnames(central_park_act_obs)<-gsub(" ","_",
                                          colnames(central_park_act_obs),
                                          fixed=TRUE)

colnames(central_park_attitude)<-gsub(" ","_",
                                     colnames(central_park_attitude),
                                     fixed=TRUE)

colnames(central_park_noise_obs)<-gsub(" ","_",
                                     colnames(central_park_noise_obs),
                                     fixed=TRUE)

colnames(central_park_og)<-gsub(" ","_",
                                     colnames(central_park_og),
                                     fixed=TRUE)

colnames(central_park_tailbeh_obs)<-gsub(" ","_",
                                     colnames(central_park_tailbeh_obs),
                                     fixed=TRUE)
