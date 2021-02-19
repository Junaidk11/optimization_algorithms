%% clear workspace and commandline
clc 

%% Problem Numbers
% Problem 2.a is denoted as 1
% Problem 2.b is denoted as 2
% Problem 3 is denoted as 3 
global problemNumber;
problemNumber = 1;  % For different problems, just changed this number here

%% Starting points for Each Problem 
if problemNumber == 1
    xold = [4;4]; 
elseif problemNumber == 2
    xold = [6/5;5/4]; 
elseif problemNumber == 3
    xold = [-1;-1;-1]; 
end 

gold = grad(xold); % Gradient at this point;
Bold = eye(length(xold)); 

%% Steepest Descent performed for first iteration
f_alpha = @(alpha) myfunc(xold - alpha*Bold*gold); 
[fmin,alpha_best] = golden_section_method(f_alpha,1e-6,0, 50); % Use golden method to minimise f(alpha)
xnew = xold - alpha_best*Bold*gold;
gnew = grad(xnew);

% Print results to check steepest descent works
fprintf('----------FIRST ITERATION ----------- \n');
fprintf('------ Steepest Descent Results ------- \n');

fprintf('Best alpha is:  alpha0 = %d \n', alpha_best);
disp('Minimum point found is: ');
disp(xnew);
fprintf('Function evaluation at the optimum point is: %d \n', myfunc(xnew));
disp('Gradient vector at this point is: ');
disp(gnew); 
fprintf('------ End of Steepest Descent Results ------- \n\n\n');


fprintf('------ BFGS Algorithm Results ------- \n');
fprintf('------ FIRST ITERATION Results -------- \n');

% Define stopping criteria parameters for BFGS
e = alpha_best*Bold*gold;
e_desired = 1e-4;  % Need to find best stopping criteria

%% BFGS starts here
% xnew = is your x0 -> Therefore, xold = xnew at start of BFGS, 
% gnew is your g0 -> Therefore, gold = gnew at start of  BFGS,
% Bold is your B0, started with Identity, at the end of the iteration, you updated Bold with Bnew 
k = 0;
while(vectorMag(e)>e_desired)  %% Stopping criteria
    % BFGS algorithm goes here
    
    %% Update starting point of BFGS with results from steepest descent method 
    xold = xnew; 
    gold = gnew; 
    
    %% Using 1-D optimization: Golden Section Method to find best alpha
    f_alpha = @(alpha) myfunc(xold - alpha*Bold*gold); 
    [fmin,alpha_best] = golden_section_method(f_alpha,1e-6,0, 50); % Use golden method to minimise f(alpha)
    if k==0
        fprintf('BFGS First Iteration best alpha is: alpha1 = %d \n',alpha_best);
    end
    
    %% Update solution with best alpha 
    xnew = xold - alpha_best*Bold*gold;
    if k==0
        disp('BFGS First Iteration solution is: x1 ='); 
        disp(xnew); 
        disp(' ');
        fprintf('Function evaluation is: f(x1) = %d \n', myfunc(xnew));
    end
    %% Calculate gradient vector at new solution 
    gnew = grad(xnew);
    
    %% Compute new approximate Hessian Matrix 
     gchange = gnew - gold; 
     xchange = xnew - xold; 
     Bnew  = Bold + (1 + (gchange'*Bold*gchange)/(xchange'*gchange) )*((xchange*xchange')/(xchange'*gchange)) - ((Bold*gchange*xchange' + xchange*gchange'*Bold)/(xchange'*gchange));
     if k==0      
        disp('BFGS First Iteration [B] is: B1 =');
        disp(Bnew);
        fprintf('\n------ End of FIRST ITERATION Results -------- \n');
        
    end
     %% Update old appropriate Hessian Matrix 
     Bold = Bnew; 
     %%  Update current tolerance
     e = alpha_best*Bold*gold; 
     %% Next Iteration 
     k=k+1; 
     
end

%% Printing BFGS Algorithm Results

disp('------ Final BFGS Algorithm Results -------');
disp('BFGS algorithm optimum point is: ');
disp(xnew);
fprintf('Function evaluation at the optimum point is: %d \n', myfunc(xnew));
