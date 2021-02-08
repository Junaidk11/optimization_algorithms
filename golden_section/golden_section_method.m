function golden_section_method
global fcount;
fcount = 0; 
x1 = 0; %initial lower bound
x4 = 0.7; %initial upper bound

e = 1; 
e_desired = 1e-4; % Desired tolerance

n = 0; %current iteration 
iteration_limit = 100; %iteration limit

k = 2/(1+sqrt(5)); % golden ratio

interval = zeros(iteration_limit+1,1); %Keep track of interval size 
interval(1,1) = x4 - x1;  % Calculate initial interval size

%% Get two points in the 'initial interval'
x2 = x4-k*interval(n+1,1); % closer to the upper bound - not really but helps visualize
x3 = x1+k*interval(n+1,1); % closer to the lower bound - not really but helps visualize
temp1 = myfunc(x2);
temp2 = myfunc(x3);

while (e>e_desired && n < iteration_limit)
    
    % % YOUR CODE GOES HERE  
    
    %% Evaluate function at two points in the 'interval'       
    n=n+1;  % Using interval[1] as initial interval to test with different initial intervals
    %% Check function evaluations to update interval    
    if temp1<=temp2
        interval(n+1,1) = x3 - x1; % Interval for next iteration       
        x4 = x3; % Upper bound shifted to the left
        x1 = x1; % Lower bound not changed -> Redundant statement,  could skip.
        
        % New points to check in the new interval for next iteration       
        x2 = x4 - k*interval(n+1,1);
        x3 = x2;        
        temp2 = temp1; 
        temp1 = myfunc(x2);
    else       
        x1 = x2; % Lower Bound shifted to the right
        x4 = x4; % Upper bound not changed -> redundant statement, could skip
        interval(n+1,1) = x4 - x1; % update interval for next iteration
        
        % New points to check in the new interval for the next iteration
        x2 = x3; 
        x3 = x1 + k*interval(n+1,1); 
        temp1 = temp2; 
        temp2 = myfunc(x3);       
    end
    %% Calculate new Tolerance
    e = abs(x4-x1); 
    if e<e_desired
        break;        
    else
        continue;      
    end
       
end

if (n-1 == iteration_limit)
    disp('No solution found');
    disp('ERROR: iterations reached max');
else
    fprintf('Minimum value found is %d found at location x = %d \n',myfunc(x1), x1)
    fprintf('Number of iterations is %d and function calls is %d \n',n-1, fcount)
end
end