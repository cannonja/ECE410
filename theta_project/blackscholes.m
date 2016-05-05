function [callprice,putprice,calldelta,putdelta]=blackscholes(stockprice, strike, riskfree, time, volatility)
d1 = (log(stockprice/strike)+(riskfree+.5*volatility^2)*time)/(volatility*sqrt(time));
d2 = d1 - volatility*sqrt(time);
callprice = stockprice*0.5*erfc(-d1/sqrt(2))-strike*exp(-riskfree*time)*0.5*erfc(-d2/sqrt(2));
putprice = strike*exp(-riskfree*time)*0.5*erfc(d2/sqrt(2))-stockprice*0.5*erfc(d1/sqrt(2));
calldelta = 0.5*erfc(-d1/sqrt(2));
putdelta = calldelta - 1;