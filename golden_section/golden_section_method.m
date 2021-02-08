function [] = golden_section_method(initial_lower, initial_upper, tolerance_desired,iteration_desired)
global fcount;

fcount = 0; 
x1 = initial_lower; %initial lower bound
x4 = initial_upper; %initial upper bound

e = 1; 
%e_desired = 1e-4; % Desired tolerance
e_desired = tolerance_desired;

n = 0; %current iteration 

iteration_limit = iteration_desired;

k = 2/(1+sqrt(5)); % golden ratio

%% Initial Interval 
interval = x4-x1;
%% Get two points in the 'initial interval'
x2 = x4-k*interval; % closer to the upper bound - not really but helps visualize
x3 = x1+k*interval; % closer to the lower bound - not really but helps visualize

temp1 = myfunc(x2);
temp2 = myfunc(x3);

while (e>e_desired && n < iteration_limit)
    
    % % YOUR CODE GOES HERE  
    %% Evaluate function at two points in the 'interval'       
    %n=n+1;  % Using interval[1] as initial interval to test with different initial intervals   
    %% Check function evaluations to update interval    
    if temp1<=temp2
        %interval(n+1,1) = x3 - x1; % Interval for next iteration 
        interval = x3-x1;
        x4 = x3; % Upper bound shifted to the left
        x1 = x1; % Lower bound not changed -> Redundant statement,  could skip.
        
        % New points to check in the new interval for next iteration             
        %x2 = x4 - k*interval(n+1,1);
        x2 = x4 - k*interval;        
        x3 = x2;        
        temp2 = temp1; 
        temp1 = myfunc(x2);
    else       
        x1 = x2; % Lower Bound shifted to the right
        x4 = x4; % Upper bound not changed -> redundant statement, could skip
        %interval(n+1,1) = x4 - x1; % update interval for next iteration
        interval = x4-x1;
        % New points to check in the new interval for the next iteration
        x2 = x3; 
        %x3 = x1 + k*interval(n+1,1); 
        x3 = x1 + k*interval; 
        temp1 = temp2; 
        temp2 = myfunc(x3);       
    end    
    
    %% Calculate new Tolerance   
    e = abs(x4-x1);
    %% Check algorithm stop conditions
    if e<e_desired
        break;        
    else
        n=n+1;           
    end
    
end

if (n == iteration_limit)
    disp('No solution found');
    disp('ERROR: iterations reached max');
else 
    fprintf('Minimum value found is %d found at location x = %d \n',myfunc(x1), x1)
    fprintf('Number of iterations is %d and function calls is %d \n',n, fcount)
end


end