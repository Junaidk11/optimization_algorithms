function golden_section_method
global fcount;
fcount = 0; 
x1 = 0; %initial lower bound
x4 = 0.7; %initial upper bound


e = 1; 
e_desired = 1e-4; % Desired tolerance

n = 0; %current iteration 
iteration_limit = 100; %iteration limit

k = 2/(1+sqrt(5)); 

while (e>e_desired && n < iteration_limit)
    
    % % YOUR CODE GOES HERE
    
    n = n+1;
end

if (n == iteration_limit)
    disp('No solution found');
    disp('ERROR: iterations reached max');
else
    fprintf('Minimum value found is %d found at location x = %d \n',myfunc(x1), x1)
    fprintf('Number of iterations is %d and function calls is %d \n',n, fcount)
end
end