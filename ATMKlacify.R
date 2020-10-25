####################################
# ATM Image Classifier
# Convolution Neural Network
# Data Scientist: Usman Tahir
# Version: 1.0.0
# Date: 22th November, 2019
####################################

# Libraries for model
library(reticulate)
library(keras) #Backend is Tensorflow
library(EBImage)

#Scale and Shape Image
ScaledAndShapedImage <- list()
ScaledAndShapedImage[[1]] <- resize(readImage(file.choose()), 100, 100)
ScaledAndShapedImage[[2]] <- resize(readImage(file.choose()), 100, 100)
ScaledAndShapedImage[[3]] <- resize(readImage(file.choose()), 100, 100)
ScaledAndShapedImage[[4]] <- resize(readImage(file.choose()), 100, 100)
ScaledAndShapedImage[[5]] <- resize(readImage(file.choose()), 100, 100)

ScaledAndShapedImage <- combine(ScaledAndShapedImage)
y <- tile(ScaledAndShapedImage, 5)
display(y, title = 'Pics')

#Reorder Dimensions
ScaledAndShapedImage <- aperm(ScaledAndShapedImage, c(4, 1, 2, 3))

#Load Model with weights
model <- load_model_hdf5(file.choose())

# Prediction
pred <- model %>% predict_classes(ScaledAndShapedImage)
prob <- model %>% predict_proba(ScaledAndShapedImage)
cbind(prob, Predicted_class = pred)
stringPrint <-c("")

for(i in 1:5){

  if (prob[i,1]>=0.80 | prob[i,2]>=0.80 ) {
    
    if(prob[i,1]>=0.80){
      stringPrint <- paste(stringPrint, "IMAGE [",i,"] : ATM NOT DETECTED","\n")
    }else{
      stringPrint<- paste(stringPrint,"IMAGE [",i,"] : ATM DETECTED","\n")
    }
    
  } else {
    stringPrint<- paste(stringPrint,"IMAGE [",i,"] : *** COULD NOT CLASSIFY ***","\n")
  }
  
}
cat(stringPrint)
