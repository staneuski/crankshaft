% Accounting that T force is a periodic function
function Tp = T_period(T, i)

if i > 721
   i = i - 721;
end

if i <= 0
   i = i+721;
end

Tp = T(i);
end