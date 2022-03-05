# MSci-Project
Mathematical modelling of blood flow in vascular networks in health and disease

In this repository we investigate the blood flow in a cylindrical blood vessel and in a microvascular network, where the flow is assumed to be firstly Newtonian, and secondly, yield stress fluid.

1. Blood flow in a single channel - Newtonian
2. Blood flow in a single channel - non-Newtonian (Bingham fluid)
3. Blood flow in a microvascular network - Newtonian
4. Blood flow in a microvascular network - non-Newtonian (Bingham fluid)

In this folder, we have ????????????????? MATLAB files, all handling different aspects of the enitre project:





data.py -The preprocessing of the dataset and a correlation heatmap function for data analysis of the dataset
modelconstruct.py - Contains 2 functions, one for the general train-test splitting of the dataset and another for the standardisation of the dataset
metrics.py - Has 5 functions setting out the 5 metrics that are explored in this project (Accuracy, confusion matrix, precision, recall and F1 Score), with some functions used again further down the line to calculate another metric (e.g precision and recall for F1 score)
SoftmaxRegression.py, LDA.py, Knn.py and RandomForest.py - These contain the construction of the models investigated in this project in their respective files, they ran with their optimal hyperparameters
plots.py - Holds 4 functions for hyperparameter analysis of 2 models (Random Forest and KNN) and their error functions which are then plotted
main.py - Takes all the above together to provide a succinct overview of the project, runs all the models and displays their respective analysis graphs discussed in the Group Report. Ran upon a command line command stated below in this file.
Note there is a plots folder too, which contains all the plots created upon running the code (these plots mainly come from the plot.py and main.py files).


python main.py MobilePricingUpdated.csv
Reproducing the results
For the duration of the running of the code (the main file command), it takes roughly around 3 minutes and 30 seconds, depending on your machine. Randomness was used in this project, mainly for Random Forest, which used the parameter random_state, the random seed of 42 was used to ensure reproducible results.
