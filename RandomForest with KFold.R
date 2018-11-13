###########################################################################
####################### random forest - function  #########################
###########################################################################

rf.kfold <- function(data,target_name,kfold=10, class="binary",seed=0775,confusionMatrix=FALSE){
  library(caret) # confusion matrix 내장
  if(!require(randomForest)){
    install.packages("randomForest");library(randomForest)
  }else{
    library(randomForest)
  }  
  
  target<-target_name
  colnames(data)[colnames(data)==target]<-"target"
  
  k = kfold # K-fold 개수
  list <- 1:k # k-fold list
  set.seed(seed)
  data$id <- sample(1:k, nrow(data), replace = TRUE) # data sampling
  predict <- total_test <- data.frame() # empty data frame generation
  
  data[,"target"]<-as.factor(data[,"target"])
  
  for(i in 1:k){
    train <- subset(data, id %in% list[-i])
    test <- subset(data, id %in% i)
    model <- randomForest(train$target~.-id, data = train, importance = TRUE, ntree = 100)
    predict_i <- as.data.frame(predict(model, test))
    predict <- rbind(predict, predict_i)
    total_test <- rbind(total_test, as.data.frame(test[,"target"]))#종속변수 열
  }
  result <- cbind(predict, total_test)
  names(result) <- c("Predicted", "Actual")
  
  if(class=="binary"){ # binary-class일 땐, 함수 사용
    if(confusionMatrix == FALSE){
      accuracy<-as.numeric(confusionMatrix(result$Predicted, result$Actual)[[3]][1])
      recall<-recall(result$Predicted,result$Actual)
      precision<-precision(result$Predicted,result$Actual)
      F1<-F_meas(result$Predicted,result$Actual)
      
      tot = data.frame("accuracy"=accuracy, "recall"=recall,"precision"=precision,"F1"=F1)
      return(tot)  
    }
    else if(confusionMatrix == TRUE){
      return(confusionMatrix(result$Predicted, result$Actual))  
    }
  }
  else if(class=="multi"){ #multi-class일 땐, macro_value  직접 계산
    if(confusionMatrix == FALSE){
      mat<-confusionMatrix(result$Predicted, result$Actual)[[2]]
      accuracy<-sum(diag(mat))/sum(mat)
      recall <- mean(diag(mat) / colSums(mat))
      precision <- mean(diag(mat) / rowSums(mat))
      F1 = mean(2 * precision * recall/(precision + recall)) 
      tot = data.frame("Accuracy"=accuracy,"Macro_precision"=precision,"Macro_recall" =recall, "Macro_F1"=F1)
      
      return(tot)  
    }
    else if(confusionMatrix == TRUE){
      return(confusionMatrix(result$Predicted, result$Actual))  
    }
  }
  
}

# binary class example
data <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
data$rank<-as.factor(data$rank)
data$admit<-as.factor(data$admit)

rf.kfold(data,target_name = "admit",confusionMatrix = F)
rf.kfold(data,target_name = "admit",kfold=5,seed=10,confusionMatrix = T)

# multi class example
data<-iris
rf.kfold(data,target_name = "Species",kfold = 10,class = "multi",seed=0775,confusionMatrix = F)
rf.kfold(data,target_name = "Species",class = "multi")

