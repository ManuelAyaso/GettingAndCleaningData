createTidyData <- function () {
    X <- mergeData() # Step 1
    X <- extractMeanAndStdCols(X) # Step 2
    # Steps 3 and 4 already achieved in getCompleteData 
    
    tidyData <- ddply(X, .(subjectId, label), numcolwise(mean)) # Step 5
    
    tidyData
}

extractMeanAndStdCols <- function (X) {
    cols <- NULL
    for (name in colnames(X)) {
        if (contains("mean", name) || contains("std", name)) {
            cols <- c(cols, name)
        }
    }
    cols <- c(cols, "subjectId", "label")
    X[, cols]
}

contains <- function (sub, s) {
    length(grep(sub, s)) > 0
}

mergeData <- function () {
    X_train <- getCompleteData("train")
    X_test <- getCompleteData("test")
   
    X <- rbind(X_train, X_test)
    X
}

getCompleteData <- function (type) {
    colNames <- read.table("./UCI HAR Dataset/features.txt", sep = "")[, 2]
    subjectIds <- read.table(paste("./UCI HAR Dataset/", type, "/subject_", type, ".txt", sep = ""), sep = "")
    labelIds <- read.table(paste("./UCI HAR Dataset/", type, "/y_", type, ".txt", sep = ""), sep = "") 
    
    X <- read.table(paste("./UCI HAR Dataset/", type, "/X_", type, ".txt", sep = ""), sep = "", col.names = colNames)
    lastColIndex <- length(colnames(X))
    X <- cbind(X, subjectIds)
    colnames(X)[lastColIndex + 1] <- "subjectId"
    lastColIndex <- length(colnames(X))
    X <- cbind(X, labelIds)
    colnames(X)[lastColIndex + 1] <- "labelId"
    
    activities <- as.data.frame(read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("labelId", "label")))
    X <- join(X, activities, type = "inner")
    
    # Now we can remove labelId
    X <- X[, -which(names(X) == "labelId")]
    
    X
}

tidyData <- createTidyData()
write.table(tidyData, "tidy_data.txt", row.names = FALSE)
