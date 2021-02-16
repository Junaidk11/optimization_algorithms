function golden_section_method(initial_lower, initial_upper, tolerance_desired,iteration_desired)
%% Number of Function evaluation 

% Include to visualise how window changes with each iteration
% figure; hold on; 

global fcount;
fcount = 0; 
%% Search Interval 
x_lower = initial_lower; %initial lower bound
x_upper = initial_upper; %initial upper bound

%% Tolerances
e = abs(x_upper-x_lower); % Current iteration tolerance 
e_desired = tolerance_desired; 

%% Iterations
n = 0; %current iteration 
iteration_limit = iteration_desired; 

%% Golden Ratio
k = 2/(1+sqrt(5));

%% Initial Interval 
interval = x_upper-x_lower;

%% Select two points in the 'initial interval'

x1 = x_upper - k*interval;
x2 = x_lower + k*interval;

fval_x1 = myfunc(x1);
fval_x2 = myfunc(x2);

% plotting x
% Comment the following - only included for visuals
% because: Each call to myfunc increments fcount.
% plot(x_lower, myfunc(x_lower),'gd');
% plot(x_upper, myfunc(x_upper),'gd');
% plot(x1, fval_x1, 'rx');
% plot(x2, fval_x2, 'bo');

while (e>e_desired && n < iteration_limit)
    
    % % YOUR CODE GOES HERE  
    %% Evaluate function at two points in the 'interval'       
    n=n+1;  
    %% Check function evaluations to update interval    
    if fval_x1<=fval_x2              
        x_upper = x2; % Upper bound shifted to the left
        %x1 = x1; % Lower bound not changed -> Redundant statement, could skip.       
        x2 = x1;        
        interval = x_upper-x_lower; % Interval for next iteration 
        x1 = x_upper - k*interval;  
        
        % New points to check in the new interval for next iteration                                           
        fval_x2 = fval_x1;
        fval_x1 = myfunc(x1);
        
        %plot new point
        plot(x1,fval_x1,'rx');
    else       
        x_lower = x1; % Lower Bound shifted to the right
        %x4 = x4; % Upper bound not changed -> redundant statement, could skip 
        x1 = x2; 
        interval = x_upper-x_lower;% update interval for next iteration
        x2 = x_lower + k*interval; 
        
        % New points to check in the new interval for the next iteration                    
        fval_x1 = fval_x2; 
        fval_x2 = myfunc(x2);
        
        %plot new point
        plot(x2,fval_x2,'bo');       
    end    
    
     %%  Plot updated Interval
     % Comment the following - only included for visuals
     % because: Each call to myfunc increments fcount.
     % plot(x_lower, myfunc(x_lower),'gd');
     % plot(x_upper, myfunc(x_upper),'gd');   
    %% Calculate new Tolerance   
    e = abs(x_upper-x_lower);      
end


if (n == iteration_limit)
    disp('No solution found');
    disp('ERROR: iterations reached max');
else 
    
    if(fval_x1<fval_x2) 
        fprintf('Minimum value found is %d found at location x = %d \n',fval_x1, x1)
        fprintf('Number of iterations is %d and function calls is %d \n',n, fcount)
    elseif (fval_x1 >fval_x2)
        fprintf('Minimum value found is %d found at location x = %d \n',fval_x2, x2)
        fprintf('Number of iterations is %d and function calls is %d \n',n, fcount)
    else
        % Either one of x1 and x2, as they're both giving the same point -
        % Won't reach this clause. Placed it for the sake of completeness.
        fprintf('Minimum value found is %d found at location x = %d \n',fval_x2, x2)
        fprintf('Number of iterations is %d and function calls is %d \n',n, fcount)
    end
    
end


end