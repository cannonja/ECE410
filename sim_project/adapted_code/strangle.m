function strangle_price = strangle(S, Kc, Kp, r, sigma, time)
call_price = bs_european_call(S, Kc, r, sigma, time);
put_price = bs_european_put(S, Kp, r, sigma, time);
strangle_price = call_price + put_price;