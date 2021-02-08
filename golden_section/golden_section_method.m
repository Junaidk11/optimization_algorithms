function golden_section_method(initial_lower, initial_upper, tolerance_desired,iteration_desired)
figure;
hold on;
%% Number of Function evaluation 
global fcount;
fcount = 0; 

%% Search Interval 
x1 = initial_lower; %initial lower bound
x4 = initial_upper; %initial upper bound

%% Tolerances
e = abs(x4-x1); % Current iteration tolerance 
e_desired = tolerance_desired; 

%% Iterations
n = 0; %current iteration 
iteration_limit = iteration_desired; 

%% Golden Ratio
k = 2/(1+sqrt(5));

%% Initial Interval 
interval = x4-x1;

%% Select two points in the 'initial interval'
x2 = x4-k*interval; % closer to the upper bound - not really but helps visualize
x3 = x1+k*interval; % closer to the lower bound - not really but helps visualize
temp1 = myfunc(x2);
temp2 = myfunc(x3);

% plotting x
plot(x1,myfunc(x1),'go');
plot(x2,temp1,'rx');     
plot(x3,temp2,'bx');
plot(x4,myfunc(x4),'go');

while (e>e_desired && n < iteration_limit)
    
    % % YOUR CODE GOES HERE  
    %% Evaluate function at two points in the 'interval'       
    n=n+1;  
    %% Check function evaluations to update interval    
    if temp1<=temp2              
        x4 = x3; % Upper bound shifted to the left
        %x1 = x1; % Lower bound not changed -> Redundant statement,  could skip.       
        x3 = x2;        
        interval = x4-x1; % Interval for next iteration 
        x2 = x4 - k*interval;  
        
        % New points to check in the new interval for next iteration                                           
        temp1 = myfunc(x2);
        temp2 = myfunc(x3);
        
        %plot new point
        plot(x2,temp1,'rx');
    else       
        x1 = x2; % Lower Bound shifted to the right
        %x4 = x4; % Upper bound not changed -> redundant statement, could skip 
        x2 = x3; 
        interval = x4-x1;% update interval for next iteration
        x3 = x1 + k*interval; 
        
        % New points to check in the new interval for the next iteration                    
        temp1 = myfunc(x2); 
        temp2 = myfunc(x3);
        
        %plot new point
        plot(x3,temp2,'bx');
    end    
    
    %% Calculate new Tolerance   
    e = abs(x4-x1);
    %% Check algorithm stop conditions
    n=n+1;           
end

if (n == iteration_limit)
    disp('No solution found');
    disp('ERROR: iterations reached max');
else 
    
    if(temp1<temp2) 
        
        fprintf('Minimum value found is %d found at location x = %d \n',temp1, x2)
        fprintf('Number of iterations is %d and function calls is %d \n',n, fcount)
    else
        fprintf('Minimum value found is %d found at location x = %d \n',temp2, x3)
        fprintf('Number of iterations is %d and function calls is %d \n',n, fcount)
    end
    
end


end