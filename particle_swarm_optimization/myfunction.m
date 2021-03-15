function z = myfunction(x)

    global problemNumber;
    
    if problemNumber==1
        z = x(1)^2 + x(2)^2 -x(1)*x(2) - 4*x(1) - x(2);
    elseif problemNumber==2
        z = (1-x(1))^2 + (-x(1)^2 + x(2))^2;
    end
    
end

