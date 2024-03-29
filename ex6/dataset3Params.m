function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

ranges = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];

errors = zeros(length(ranges) ^ 2, 3);
error_number = 0;

for i = 1:length(ranges)
	c_range = ranges(i);

	for j = 1:length(ranges)
		error_number += 1;
		sigma_range = ranges(j);

		model = svmTrain(X, y, c_range, @(x1, x2) gaussianKernel(x1, x2, sigma_range));
		predictions = svmPredict(model, Xval);
		prediction_error = mean(double(predictions ~= yval));
				
	errors(error_number, :) = [prediction_error, c_range, sigma_range];
	end
end

[error, index] = min(errors);

C = errors(index(1), 2);
sigma = errors(index(1), 3);



% =========================================================================

end
