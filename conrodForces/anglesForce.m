function conrodAngle = anglesForce(alpha_ex)
conrodForcesDict;

alpha_ex = alpha_ex - 1;

if (alpha_ex >= 0 && alpha_ex < 180) || (alpha_ex >= 360 && alpha_ex < 540)
    % Crankshaft in I or II quaters
    if alpha_ex >= 360
        alpha_ex = alpha_ex - 360;
    end
    if alpha_ex <= crankshaftAngle
        direction_1 = -1;         direction_2 = 1;
        alpha_ex1   = alpha_ex;   alpha_ex2   = crankshaftAngle - alpha_ex;
    else
        direction_1 = -1;         direction_2 = -1;
        alpha_ex1   = alpha_ex;   alpha_ex2   = alpha_ex - crankshaftAngle;
    end
    
else
    % Crankshaft in III or IV quaters
    if alpha_ex >= 360
        alpha_ex = alpha_ex - 360;
    end
    
    if (alpha_ex - 180) < crankshaftAngle
        direction_1 = 1;                direction_2 = -1;
        alpha_ex1   = 360 - alpha_ex;   alpha_ex2   = alpha_ex - crankshaftAngle;
    else
        direction_1 = 1; direction_2 = 1;
        alpha_ex1   = 360 - alpha_ex;   alpha_ex2   = 360 - (alpha_ex - crankshaftAngle);  
    end
    
end
    beta_1 = asind(lambda*sind( alpha_ex1 )); beta_2 = asind(lambda*sind( alpha_ex2 ));
    
    conrodAngle = [direction_1*(alpha_ex1 + beta_1);...
                   direction_2*(alpha_ex2 + beta_2)];
end