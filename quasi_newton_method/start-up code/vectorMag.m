function [magnitude] = vectorMag(v)
  %% Calculate magnitude of the vector v
    sv = v.* v;       %   the vector with elements as square of v's elements
    dp = sum(sv);     %   sum of squares -- the dot product
    magnitude = sqrt(dp);   % magnitude
end

