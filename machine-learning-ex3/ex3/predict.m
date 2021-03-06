function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%
% Add ones to the X data matrix
X = [ones(m, 1) X];


% hypothesis for 2nd layer(1st hidden layer)
hypothesisA2=sigmoid( X * ( Theta1' ));

% Add ones to the hypothesisA2 data matrix as bias
hypothesisA2=[ones(m, 1) hypothesisA2];

%hypothesis for output layer
final_hypothesis=sigmoid( hypothesisA2 * ( Theta2' ));

[m,index]=max(final_hypothesis,[],2);
p=index;


%% a second solution for reference
%T = X';
%T = [ones(1, m); T];
%z2 = Theta1 * T;
%a2 = [ones(1, size(z2, 2)); sigmoid(z2)];
%z3 = Theta2 * a2;
%a3 = sigmoid(z3);
%[X, Y] = max(a3);
%p = Y';

% =========================================================================


end
