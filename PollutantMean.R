pollutantmean <- function(directory, pollutant, id = 1:332) {
        files_list <- list.files(directory, full.names=TRUE)  #creates a list of files
        dat <- data.frame()  #creates an empty dataframe
        for (i in id) {
                #loops trhough the files, rbinding them together
                dat <- rbind(dat, read.csv(files_list[i]))    
        }
        dat_sub <- dat[which(dat[,"ID"] %in% id),] #subsets the data contained in the 'id' input
        mean(dat_sub[, pollutant], na.rm=TRUE)  #identifies the mean of pollutant and removes NA
}
