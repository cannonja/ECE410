

function put_strike=hull_put_mod(S, r, sigma, time, delta)


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
%   K:      exercise price
%   r:      interest rate
%   sigma:  volatility
%   time:   time to maturity
%
%--------------------------------------------------------------------------
%
% OUTPUT:
%
% put_price: price of a put option
%
%--------------------------------------------------------------------------
%
% Author:  Paolo Z., February 2012
%
%--------------------------------------------------------------------------


% d1=(log(S/K)+(r+sigma^2/2)*time)/(sigma*sqrt(time));
% d2=d1-sigma*sqrt(time);
% 
% put_price=K*exp(-r*time)*normcdf(-d2)-S*normcdf(-d1);

%%%% Modifications
%%%% delta = normcdf(d1) - 1 -> therefore, d1 = norminv(delta + 1);
%%%% Substitute for d1 in original equation and solve for K
put_strike = S / exp(norminv(delta + 1,0,1)*sigma*sqrt(time) - (r + 0.5*sigma^2)*time);
