% Accounting that force is a periodic function with period = 720deg or 360deg 
function perAlpha = forcePeriod(realAlpha, period)

if realAlpha > period
    perAlpha = realAlpha - period;
elseif realAlpha <= 0
    perAlpha = realAlpha + period;
else
    perAlpha = realAlpha;
end

end