function [callprice, strike_call, putprice, strike_put] = blackscholes_modified(stockprice, riskfree, time, volatility, cdelta, pdelta)
%%% This function is a modified version of the original
%%% It's purpose is to take deltas and return the strikes associated with
%%% them.


%%% Lines from original blackscholes function

%d1 = (log(stockprice/strike)+(riskfree+.5*volatility^2)*time)/(volatility*sqrt(time));
%callprice = stockprice*0.5*erfc(-d1/sqrt(2))-strike*exp(-riskfree*time)*0.5*erfc(-d2/sqrt(2));
%putprice = strike*exp(-riskfree*time)*0.5*erfc(d2/sqrt(2))-stockprice*0.5*erfc(d1/sqrt(2));
%calldelta = 0.5*erfc(-d1/sqrt(2));
%putdelta = calldelta - 1;



%%% Modifications
%%% First, solve for d1 for both calls and puts in terms of the respective
%%% deltas, then derive d2 in the usual way.
%%% Second, substitute for d1 in original d1 equation by Dr. Tymerski (line 4)
%%% Third, solve for strike - the result is the same for calls and puts,
%%% however, substitute the put d1 in for the put strike formula.
%%% Finally, substitute strike into pricing equations (lines 5 and 6)

d1_call = -erfcinv(cdelta/0.5) * sqrt(2);
d2_call = d1_call - volatility*sqrt(time);
d1_put = -erfcinv(2*pdelta + 2) * sqrt(2);
d2_put = d1_put - volatility*sqrt(time);

strike_call = stockprice / exp(d1_call*volatility*sqrt(time)-(riskfree+.5*volatility^2)*time);
callprice = stockprice*cdelta-strike_call*exp(-riskfree*time)*0.5*erfc(-d2_call/sqrt(2));
strike_put = stockprice / exp(d1_put*volatility -(riskfree+.5*volatility^2)*sqrt(time));
putprice = strike_put*exp(-riskfree*time)*0.5*erfc(d2_put/sqrt(2))-stockprice*0.5*erfc(d1_put/sqrt(2));