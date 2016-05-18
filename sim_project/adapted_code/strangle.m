function strangle_price = strangle(S, K, r, sigma, time)
call_price = bs_european_call(S, K, r, sigma, time);
put_price = bs_european_put(S, K, r, sigma, time);
strangle_price = call_price + put_price;