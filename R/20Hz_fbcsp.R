class1 <- read.csv('feature vectors/FBCSP/20hz/feature_agg_target_only.csv')
data <- class1[,3:8]
class2 <- read.csv('feature vectors/FBCSP/20hz/feature_agg_non_target_only.csv')
data <- rbind(data,class2[,3:8])
data$label <- as.factor(c(rep(1, 528), rep(2,1584)))


library(caTools)
split = sample.split(data$label, SplitRatio = 0.75)
training_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)


#-----------------------kpca
library(kernlab)
kpca = kpca(~., data = training_set[-7], kernel = 'rbfdot', features = 2)
training_set_pca = as.data.frame(predict(kpca, training_set))
training_set_pca$label = training_set$label
test_set_pca = as.data.frame(predict(kpca, test_set))
test_set_pca$label = test_set$label

data.plot <- rbind(training_set_pca, test_set_pca)
ggplot(data = data.plot) +
  geom_point(aes(x =V1 , y = V2, color = label), size =3.5) + labs(x = "PC1", y = "PC2", title = "20Hz Features (FBCSP)")

#===========================================================================


# #---------------------pca
# library(caret)
# library(e1071)
# pca = preProcess(x = training_set[-7], method = 'pca', pcaComp = 2)
# training_set = predict(pca, training_set)
# training_set = training_set[c(2, 3, 1)]
# test_set = predict(pca, test_set)
# test_set = test_set[c(2, 3, 1)]
# 
# data.plot <- rbind(training_set, test_set)
# ggplot(data = data.plot) +
#   geom_point(aes(x =PC1 , y = PC2, color = label), shape = 21)
#============================================================================




library(e1071)
model <- svm(label ~ ., data = training_set, kernel = "radial", type = "C-classification")

y_pred <-  predict(model, newdata = test_set[-7])

cm <-  table(test_set[, 7], y_pred)
cm
