function df = grad(x)
global problemNumber; 
%% define the function gradient here

if problemNumber == 1     % For Problem 2.a
    dfdx = 2*x(1) - x(2) -4;
    dfdy = 2*x(2) - x(1) - 1;
    df = [dfdx;dfdy];
elseif problemNumber == 2 % For Problem 2.b

elseif problemNumber == 3 % For Problem 3

end 

end