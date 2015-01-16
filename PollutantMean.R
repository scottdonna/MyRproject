pollutantmean <- function(directory, pollutant, id) {
        files_list <- list.files(directory, full.names=TRUE)  #creates a list of files
        dat <- data.frame()  #creates an empty dataframe
        for (i in 1:length(files_list)) {
                #loops trhough the files, rbinding them together
                dat <- rbind(dat, read.csv(files_list[i]))    
        }
        dat_sub <- dat[which(dat[,"ID"] %in% id),]
        mean(dat_sub[, pollutant], na.rm=TRUE)  #identifies the mean of pollutant and removes NA
}