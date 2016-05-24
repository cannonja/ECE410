function ret = modRSISeries( series, period )
%   ret = modRSISeries( series, period )

ret = zeros(length(series), 1);

change = [0;diff(series)];
ind = change < 0;
gains = change;
gains(ind) = 0;
ind = change > 0;
losses = -change;
losses(ind) = 0;  

m = 0:period-2;

for n = period+1:length(series) 
    g = sum(gains(n-m));
    l = sum(losses(n-m));
    c = g + l;
    
    if c == 0
        ret(n) = 0;
    else
        ret(n) = ((100 * g/c) - 50) * sqrt(period-1);
    end
end




