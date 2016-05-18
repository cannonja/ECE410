function straddle_price = straddle(S, K, r, sigma, time)
call_price = bs_european_call(S, K, r, sigma, time);
put_price = bs_european_put(S, K, r, sigma, time);
straddle_price = call_price + put_price;