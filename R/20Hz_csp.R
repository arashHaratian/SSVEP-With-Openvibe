class1 <- read.csv('feature vectors/csp/20hz/feature_agg_target_only.csv')
data.t <- class1[,3:4]
class2 <- read.csv('feature vectors/csp/20hz/feature_agg_non_target_only.csv')
data <- rbind(data.t,class2[,3:4])
data$label <- as.factor(c(rep(1, 528), rep(2,1584)))


ggplot(data = data) +
  geom_point(aes(x = Feature.1, y = Feature.2, color = label) , size =3.5) + labs(x = "Feature 1", "Feature 2", title = "20Hz Features (CSP)")


library(caTools)
split = sample.split(data$label, SplitRatio = 0.75)
training_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)

library(e1071)
model <- svm(label ~ ., data = training_set, kernel = "radial", type = "C-classification")

y_pred <-  predict(model, newdata = test_set[-3])

cm <-  table(test_set[, 3], y_pred)
cm

