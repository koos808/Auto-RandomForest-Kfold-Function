# RandomForest withKfold
- This Function. Automatically executes Randomforest with k-fold.
- You can use it both when the class of Y is binary and when it is multi.
- Just use the preprocessed data to put the target_name in the function.
- Run the model automatically and output Accuracy, Recall, Precision, F1-score, ConfusionMatrix.
---
- 이 함수는 자동으로 k-fold를 적용한 뒤 RandomForest 모델을 실행시켜주는 함수 입니다.
- Y가 binary-class 이거나 multi-class 일 때 모두 사용 가능합니다.
- 전처리한 데이터를 변수 타입을 맞추고 Y의 이름을 target_name에 넣기만 하면 됩니다. 
- 자동으로 모델을 실행시켜서 Accuracy, Recall, Precision, F1-score , ConfusionMatrix를 출력해줍니다. 

## Supported class -> binary, multi

## multi-class  : Macro-average Method
- Macro-average precision / Macro-average recall

- Macro-average is used when you want to know how well (on average) your classifier works for all classes.
- Macro-average는 내 classifier가 모든 class에 대해 얼마나 (평균적으로) 잘 동작하는지 알고 싶을 때 사용한다.

## 함수 Arguments : 인수
### data 
- Data set with data cleansed
### target_name
-  dependent variable.(=target column). example) target_name="Species".
### kfold 
- kfold count(number of kfold). default is 10.
### class 
- "binary" and "multi". default is "binary".
### seed 
- set.seed(value). default is 0775.
### confusionMatrix 
- If confusionMatrix is True, print confusionMatrix.
- If confusionMatrix is FALSE, print accuracy, recall, precision, and F1 socre. 
- default is FALSE.


