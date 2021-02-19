function df = grad(x)
global problemNumber; 
%% define the function gradient here
if problemNumber == 1     % For Problem 2.a
    dfdx = 2*x(1) - x(2) -4;
    dfdy = 2*x(2) - x(1) - 1;
    df = [dfdx;dfdy];
elseif problemNumber == 2 % For Problem 2.b
    dfdx = 2*x(1) - 2 + 4*x(1)^3 - 2*x(2)*x(1);
    dfdy = 2*x(2) - 2*x(1)^2; 
    df = [dfdx; dfdy];
elseif problemNumber == 3 % For Problem 3
    dfdx = 2*x(3) + sin(x(3)) + 10*x(1) - 2*x(2); 
    dfdy = 26*x(2) + 6*x(3) - 2*x(1); 
    dfdz = x(1)*cos(x(3)) + 2*x(1) + 6*x(2) + 2*x(3); 
    df = [dfdx; dfdy; dfdz];
end 

end