function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
%% my solution Part1
% adding coloumn's of 1's

%X=[ones(m,1),X];

%z2  = X * ( Theta1' );
%a2 = [ones(m, 1) sigmoid(z2)];

%z3 = a2 * ( Theta2' );
%a3 = sigmoid(z3);


%fprintf('size is \n');

% to represt y interms of binary
% example 5 =[0 0 0 0 1 0 0 0 0 0]
%for i = 1:m

 %   t(i,:)= ( y(i) == (1:num_labels));
    
%end
%y=t;
%size(-y' * log(a3)); 


%%J=  1 / m *  sum( sum( ( -y .* log(a3) - (1-y).* log(1-a3) ) ) )   ;

% the above sode is same as below but I have made it to maintain
% consistency i.e first to add up the all the k dimension vector  than all m examples
% coz sum funcn in matlab adds row wise in a matrix i.e downwards
%again when done sum it adds the sum of the rows i.e right wards

%J=  1 / m *  sum( sum( ( -y' .* log(a3') - (1-y').* log(1-a3') ) ) )   ;

%%
%Better solution interms of understanding

T = X';
T = [ones(1, m); T];
z2 = Theta1 * T;
a2 = [ones(1, size(z2, 2)); sigmoid(z2)];
z3 = Theta2 * a2;
a3 = sigmoid(z3);

for i = 1:m

    t(i,:)= ( y(i) == (1:num_labels));
    
end
y=t';
J = 1 / m * sum(sum(-y .* log(a3) - (1 - y) .* log(1 - a3)));

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%


delta3  =   a3 - y;
temp=(Theta2' * delta3);
%size(temp)
%size( temp(2:end,:))
%size(sigmoidGradient(z2))
delta2   =   temp(2:end,:) .*  sigmoidGradient(z2); % You may use sigmoidGradiant fumction here.
%delta2   =   ((Theta2' * delta3)(:,2:end) ).* sigmoidGradient(z2);

Delta2 = delta3 * a2';%accumaltion is done by vector multiplication
Theta2_grad = 1 / m * Delta2;

Delta1 = delta2 * T';
Theta1_grad = 1 / m * Delta1;


% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%




%exclude the bias parameter
TempTheta1=Theta1;
TempTheta2=Theta2;
TempTheta1(:,1)=0;
TempTheta2(:,1)=0;
%J from unregularised cost
J = J + ( lambda/(2*m) )*( sum(sum(TempTheta1 .^2 )) + sum(sum(TempTheta2 .^2 )) );

Theta1_grad = Theta1_grad + lambda / m * TempTheta1;
Theta2_grad = Theta2_grad + lambda / m * TempTheta2;


% -------------------------------------------------------------

%% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
