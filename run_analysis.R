RunAnalysis <- function()
{
        Path <- getwd()
        
        ## These parameters from the README file that came with the original data set.
        RecordLength <- 561
        NumberOfSubjects <- 30
        
        ## NameActivity supplies a human readable explanation of the measured activities.
        NameActivity <- c("Walking", "Walking upstairs","Walking downstairs", 
                          "Sitting", "Standing", "Laying down")
        
        ## Not having sufficient of an explanation of what the different (calculated)
        ## measurements are in the supplied datasets I have used those measurements
        ## for which the features.txt names of those measurements contained either 
        ## the word "mean" or the word "std". Visual inspection of the selected
        ## features did not show obvious wrong choices.
        setwd("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
        Features <- read.table("Features.txt", colClasses="character")
        Index <- grep("mean", Features[,2], fixed=TRUE)
        Index <- append(Index, grep("std", Features[,2], fixed=TRUE))
        NOF <- length(Index) ## Number of selected features)
        
        ## Read in the "test" data.
        setwd(Path)
        setwd("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test")
        X_test <- scan("X_test.txt")
        subject_test <- scan("subject_test.txt", what=integer())
        y_test <- scan("y_test.txt", what=character())
        
        ## Use the selected features (above) to fill a matrix with those features
        ## from the read X_test data.
        Selected <- matrix(nrow=length(subject_test), ncol=NOF)
        
        for (i in 1:length(subject_test))
        {
                Selected[i,] <- X_test[(i-1)*RecordLength + Index]
        }

        TestFrame <- data.frame(subject_test, y_test, Selected, stringsAsFactors=FALSE)
        ## Assign human readable column names to the test data frame.The measurement names 
        ## have been taken from 'features.txt' file. It i relatively easy to modify
        ## these column names by something more descriptive if I just knew what 
        ## they represent :(.
        names(TestFrame) <- c("Subject", "Activity", Features[Index,2] )
        
        ## Read the "train" data and create a "train" frame with subject, activity 
        ## and selected features.
        setwd(Path)
        setwd("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train")
        X_train <- scan("X_train.txt")
        subject_train <- scan("subject_train.txt", what=integer())
        y_train <- scan("y_train.txt", what=character())
        
        Selected <- matrix(nrow=length(subject_train), ncol=NOF)
        
        for (i in 1:length(subject_train))
        {
                Selected[i,] <- X_train[(i-1)*RecordLength + Index]
        }
        
        TrainFrame <- data.frame(subject_train, y_train, Selected, stringsAsFactors=FALSE)   
        ## Assign human readable column names to the train data frame.
        names(TrainFrame) <- c("Subject", "Activity", Features[Index,2] )
        ## Combine the train data and test data frames into one final data frame.
        CombinedFrame <- rbind(TestFrame, TrainFrame)
        
        ## Subsititute an explanatory string in the data frame for the current 
        ## string representation of a number.
        for (i in 1:nrow(CombinedFrame)) 
                CombinedFrame[i,"Activity"] <- NameActivity[as.integer(CombinedFrame[i,"Activity"])]
        
        
        ##
        ## Create the requested new tidy dataset.Tiis part of the algorithm can also be
        ## implemented by using 'tapply' but although it is more compact and probably
        ## faster it is also very hard to understand and read. For this reasosn I have chosen
        ## to do it with 'for' loops. I have another version using 'by':
        ##
        ## TidyFrame <- CombinedFrame[1:(NumberOfSubjects*6),]
        ## TidyFrame[,2] <- rep(rev(NameActivity), each = 6) 
        ## TidyFrame[,1] <- rep(1:NumberOfSubjects, times = 6)
        ##
        ##
        ## for (M in 1:length(Index))
        ## {
        ##        TidyFrame[,M+2] <-
        ##                as.vector(by(CombinedFrame[,2+M], 
        ##                             list(CombinedFrame[, "Subject"], CombinedFrame[,"Activity"]),
        ##                             mean))  
        ## }    
        ##

        TidyFrame <- CombinedFrame[NumberOfSubjects*6,]
        
        for (A in 1:6)
        {
                for (S in 1:NumberOfSubjects)
                {
                        TidyFrame[(A-1)*NumberOfSubjects + S,1] = S
                        TidyFrame[(A-1)*NumberOfSubjects + S,2] = NameActivity[A]
                        
                        for (M in 1:length(Index))
                        {
                                m <- mean(CombinedFrame[CombinedFrame[,1] == S &
                                                          CombinedFrame[,2] == NameActivity[A], M+2])
                                TidyFrame[(A-1)*NumberOfSubjects + S, M+2] <- m
                        }    

                }
        }
        setwd(Path)
        write.table(TidyFrame, row.names=FALSE, file="Tidy.txt")
}