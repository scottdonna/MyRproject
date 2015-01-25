complete <- function(directory, id = 1:332) {
        files_list <- list.files(directory, full.names=TRUE)  #creates a list of files
        dat <- data.frame()  #creates an empty dataframe for csv files
        d2 <- data.frame()  #creates an empty dataframe for current csv file
        dobs <- data.frame()  #creates an empty dataframe for all complete observations
        dobs2 <- data.frame()  #creates an empty dataframe for current complete observations
        for (i in id) {
                #loops trhough the files, rbinding them together
                d2 <-  read.csv(files_list[i]) #reads the csv with the current value in "id"
                dat <- rbind(dat, d2) #rbinds the current csv with the previous csv
                comp_obs <- d2[complete.cases(d2[2:3]),] #removes rows with NA in 2nd or 3rd columns
                nobs <- nrow(comp_obs) # counts the rows of complete observations
                dobs2 <- c(i, nobs) # fills the variable with current csv complete observations
                dobs <- rbind(dobs, dobs2) #adds current csv's observation with previous csv's observations
        }
        names(dobs) <- c("ID", "nobs") #names the columns
        print(dobs) #prints the results
}