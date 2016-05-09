%%%%%Script that tests the modified blackscholes function

S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [180:1:220];
deltas = [];
cvalues = [];
cvalues_mod = [];
strikes_mod = [];
cv_check = [];
s_check = [];

for i = strikes
    [cp, ~, cd, ~] = blackscholes(S, i, rf, DTE/365, IV);
    [cp_mod, s_mod] = blackscholes_modified(S, rf, DTE/365, IV, cd);
    deltas = [deltas; cd];
    cvalues = [cvalues; cp];
    cvalues_mod = [cvalues_mod; cp_mod];
    strikes_mod = [strikes_mod; s_mod];
    cv_check = [cv_check; cp == cp_mod];
    s_check = [s_check; i == s_mod];
end


[cv_check cvalues cvalues_mod]
[s_check transpose(strikes) strikes_mod]

table(transpose(strikes), deltas , cvalues, cvalues_mod, 'VariableNames', {'Strikes', 'Deltas', 'Price', 'Price2'})