function [callprice, strike] = blackscholes_delta(stockprice, riskfree, time, volatility, delta)
%d1 = (log(stockprice/strike)+(riskfree+.5*volatility^2)*time)/(volatility*sqrt(time));
strike = stockprice / exp(-erfcinv(delta/0.5)*sqrt(2)*volatility*sqrt(time)-(riskfree+.5*volatility^2)*time);
d1 = -erfcinv(delta/0.5) * sqrt(2);

d2 = d1 - volatility*sqrt(time);
%callprice = stockprice*0.5*erfc(-d1/sqrt(2))-strike*exp(-riskfree*time)*0.5*erfc(-d2/sqrt(2));
callprice = stockprice*delta-strike*exp(-riskfree*time)*0.5*erfc(-d2/sqrt(2));
%putprice = strike*exp(-riskfree*time)*0.5*erfc(d2/sqrt(2))-stockprice*0.5*erfc(d1/sqrt(2));
%calldelta = 0.5*erfc(-d1/sqrt(2));
%putdelta = calldelta - 1;