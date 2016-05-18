

function call_strike=hull_call_mod(S, r, sigma, time, delta)


%--------------------------------------------------------------------------
%
% DESCRIPTION:
%
% European put option using Black-Scholes' formula
%
%
% Reference:
%
% John Hull, "Options, Futures and other Derivative Securities",
% Prentice-Hall, second edition, 1993.
%
%--------------------------------------------------------------------------
%
% INPUTS:
%
%   S:      spot price
%   K:      strike price
%   r:      interest rate
%   sigma:  volatility
%   time:   time to maturity
%
%--------------------------------------------------------------------------
%
% OUTPUT:
%
% call_price: price of a call option
%
%--------------------------------------------------------------------------
%
% Author:  Paolo Z., February 2012
%
%--------------------------------------------------------------------------


time_sqrt = sqrt(time);
% 
% d1 = (log(S/K)+r*time)/(sigma*time_sqrt)+0.5*sigma*time_sqrt;
% d2 = d1-(sigma*time_sqrt);
% 
% call_price  = S*normcdf(d1)-K*exp(-r*time)*normcdf(d2);



%%%% Modifications
%%%% delta = normcdf(d1) -> therefore, d1 = norminv(delta);
%%%% Substitute for d1 in original equation and solve for K
call_strike = S / exp((norminv(delta,0,1) - 0.5*sigma*time_sqrt) * sigma * time_sqrt - r * time);
