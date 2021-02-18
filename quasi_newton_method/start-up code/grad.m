function df = grad(x)
% define the function gradient here
dfdx = 2*x(1) - x(2) -4;
dfdy = 2*x(2) - x(1) - 1;

df = [dfdx;dfdy];
end