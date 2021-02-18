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

% Define stopping criteria parameters for BFGS

% BFGS starts here
while(%% Stopping criteria)
    % BFGS algorithm goes here
end

