function y = myfunc(x)
global fcount
% Choose function
% y = x*cos(pi*x^2);
 y = 4*x^2 - 12*x + 9;
% y = 3*x^5 - 7*x^3 -54*x +21;

fcount = fcount + 1;
end