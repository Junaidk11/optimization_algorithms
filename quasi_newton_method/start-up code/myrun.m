% Starting point
xold = [4;4]; % Starting point
gold = grad(xold); % Gradient at this point;
Bold = eye(length(xold));

% Steepest Descent performed for first iteration
f_alpha = @(alpha) myfunc(xold - alpha*Bold*gold); 
[fmin,alpha_best] = golden_section_method(f_alpha,1e-6,0, 50); % Use golden method to minimise f(alpha)
xnew = xold - alpha_best*Bold*gold;
gnew = grad(xnew);

% Print results to check steepest descent works
fprintf('Steepest Descent Results: \n');

fprintf('Minimum value found is: f(x1)= %d found at location x1 = %d \n',myfunc(xnew), xnew);
fprintf(' x----------x---------x----------x \n');
fprintf('First Iteration best alpha is:  alpha0 = %d \n', alpha_best);
fprintf('First Iteration solution gradient vector is: g1 = %d', gnew);
fprintf(' x----------x---------x----------x \n');
fprintf('End of Steepest Descent Results. \n');

% Define stopping criteria parameters for BFGS
e = alpha_best*dold; 
e_desired = 1e-4;  % Need to find best stopping criteria


% BFGS starts here
% xnew = is your x0 -> Therefore, xold = xnew at start of BFGS, 
% gnew is your g0 -> Therefore, gold = gnew at start of  BFGS,
% Bold is your B0, started with Identity, at the end of the iteration, you updated Bold with Bnew 
k = 0;
while( abs(e)>e_desired)  %% Stopping criteria
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
        disp('function evaluation is: f(x1) = %d \n', myfunc(xnew));
    end
    %% Calculate gradient vector at new solution 
    gnew = grad(xnew);
    
    %% Compute new approximate Hessian Matrix 
     gchange = gnew - gold; 
     xchange = xnew - xold; 
     Bnew  = Bold + (1 + (gchange'*Bold*gchange)/(xchange'*gchange) )*(xchange*xchange'/ xchange'*gchange) - ((xchange'*gchange*Bold + Bold*gchange*xchange')/(xchange'*gchange));
     if k==0
        fprintf('BFGS First Iteration [B] is: B1 = %d \n',xnew, myfunc(xnew));
    end
     %% Update old appropriate Hessian Matrix 
     Bold = Bnew; 
     %% Next Iteration 
     k=k+1; 
     
end


fprintf('BFGS Algorithm Results: \n');
disp('BFGS algorithm optimum point is: ');
disp(xnew);
fprintf('Function evaluation at the optimum point is: %d \n', myfunc(xnew));
