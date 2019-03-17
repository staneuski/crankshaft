% Calculates characteristic of stress: amplitude (sigma_a) or midle (sigma_m)

function stress = stressCycle(stress_max, stress_min, index)

if index == 'a' % calculating amplitude of stress
    stress = abs(stress_max - stress_min)/2;
elseif index == 'm' % calculating midle of stress
    stress = abs(stress_max + stress_min)/2;
end

end

