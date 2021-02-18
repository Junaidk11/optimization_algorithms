f = @(x)(x^3+4*x^2-3*x-6) ;
[fmin,x] = golden_section_method(f,1e-6,0, 50)

% solution should be xmin = 0.3333 and fmin=-6.5185