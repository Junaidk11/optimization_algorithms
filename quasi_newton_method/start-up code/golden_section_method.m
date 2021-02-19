function [fx_min,x] = golden_section_method(func,tolerance,lb, ub)
% Your golden section method code goes here
% Your golden section method code goes here

%% Search Interval 
x_lower = lb; %initial lower bound
x_upper = ub; %initial upper bound

%% Tolerances
e = abs(x_upper-x_lower); % Current iteration tolerance 
e_desired = tolerance; 

%% Iterations - no iterations limit
% n = 0; %current iteration 
% iteration_limit = 100; 

%% Golden Ratio
k = 2/(1+sqrt(5));

%% Initial Interval 
interval = x_upper-x_lower;

%% Select two points in the 'initial interval'

x1 = x_upper - k*interval;
x2 = x_lower + k*interval;

fval_x1 = func(x1);
fval_x2 = func(x2);

while (e>e_desired)
    
    % % YOUR CODE GOES HERE  
    %% Evaluate function at two points in the 'interval'       
    %n=n+1;  
    %% Check function evaluations to update interval    
    if fval_x1<=fval_x2              
        x_upper = x2; % Upper bound shifted to the left
        %x1 = x1; % Lower bound not changed -> Redundant statement, could skip.       
        x2 = x1;        
        interval = x_upper-x_lower; % Interval for next iteration 
        x1 = x_upper - k*interval;  
        
        % New points to check in the new interval for next iteration                                           
        fval_x2 = fval_x1;
        fval_x1 = func(x1);
    else       
        x_lower = x1; % Lower Bound shifted to the right
        %x4 = x4; % Upper bound not changed -> redundant statement, could skip 
        x1 = x2; 
        interval = x_upper-x_lower;% update interval for next iteration
        x2 = x_lower + k*interval; 
        
        % New points to check in the new interval for the next iteration                    
        fval_x1 = fval_x2; 
        fval_x2 = func(x2);           
    end     
    %% Calculate new Tolerance   
    e = abs(x_upper-x_lower);      
end

if(fval_x1<fval_x2) 
    %fprintf('Minimum value found is %d found at location x = %d \n',fval_x1, x1)    
    fx_min = fval_x1; 
    x = x1;
elseif (fval_x1 >fval_x2)
    %fprintf('Minimum value found is %d found at location x = %d \n',fval_x2, x2)
    fx_min = fval_x2; 
    x = x2;
end

end