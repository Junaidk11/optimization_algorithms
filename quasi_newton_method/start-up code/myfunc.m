function f = myfunc(x)

%% Problem 2.a
f = x(1)^2 + x(2)^2 -x(1)*x(2) - 4*x(1) - x(2);

%% Problem 2.b 
f = (1-x(1))^2 + (-x(1)^2 + x(2))^2;

%% Problem 3
f = (x(1) + 3*x(2) + x(3))^2 + 4*(x(1)-x(2))^2 + x(1)*sin(x(3)); 

end