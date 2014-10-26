uci_data_filename <- function (filename) {
	return (paste("UCI HAR Dataset/",filename, sep=""))
}
load_data_set <- function (setId {
	#returns filtered data.frame (subject, activity, selected features) for given set (train/test)
	filename <- function(prefix) {
		#return full filename for prefix in current set 
		return (uci_data_filename(paste(setId,"/",prefix,"_",setId,".txt",sep="")))
	}
	features = get_variable_names()
	activities = get_activity_names()
	X <- read.table(filename("X"), header=FALSE, col.names = features)
	y <- read.table(filename("y"), header=FALSE, col.names=c("activityId"))
	subject <- read.table(filename("subject"), header=FALSE, col.names=c("subject"))
	selFeatures <- grep("std|mean",features)
	
	result <- data.frame(
			subject$subject,
			activities[y$activityId],
			X[selFeatures])
	names(result) <-c("subject","activity",features[selFeatures])
	return(result)
}

get_activity_names  <- function() {
	#return vector with activity labels
	return (as.character(
		unlist(
			read.delim (uci_data_filename("activity_labels.txt"),
				sep=" ",
				header=FALSE, 
				col.names=c("activityId","activityName")
			)$activityName
		      )
		)
	       )
}

get_variable_names <- function() {
	#return vector with feature names
	return (as.character(
			unlist(
				read.delim(uci_data_filename("features.txt"),
					sep=" ",
					header=FALSE, 
					col.names=c("featureId","featureName")
					)$featureName
			      )
			)
	       )
}

mergedData <- rbind(load_data_set("train"), load_data_set("test"))

agregatedData = aggregate(
	mergedData[3:ncol(mergedData)],
	list(mergedData$subject,mergedData$activity),
	mean)
names(agregatedData)[1:2] <- c("subject","activity")

write.table(agregatedData,"agregatedData.txt",row.names=FALSE)

