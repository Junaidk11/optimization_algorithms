function g = constraint_func(x)
% Constrain function evaluated based on Penalty Scheme.
    z = -10*x(1)-3*x(2) + 25;
    if z>0
        g = z;
    elseif z<=0
        g =0;
    end
end

