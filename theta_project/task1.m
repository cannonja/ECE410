%%%%%Tested modified blackscholes
%{
S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [180:1:220];
deltas = [];
cvalues = [];
cvalues2 = [];
strikes2 = [];
pcheck = [];
scheck = [];

for i = strikes
    [cp, ~, cd, ~] = blackscholes(S, i, rf, DTE/365, IV);
    [cp2, s_mod] = blackscholes_delta(S, rf, DTE/365, IV, cd);
    deltas = [deltas; cd];
    cvalues = [cvalues; cp];
    cvalues2 = [cvalues2; cp2];
    strikes2 = [strikes2; s_mod];
    pcheck = [pcheck; cp == cp2];
    scheck = [scheck; i == s_mod];
end


[pcheck cvalues cvalues2]
[scheck transpose(strikes) strikes2]

%table(transpose(strikes), deltas , cvalues, cvalues2, 'VariableNames', {'Strikes', 'Deltas', 'Price', 'Price2'})
%}

%%%%%%%Task 1
%{
S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [];
deltas = 0.9:-0.1:0.1;

for i = deltas
    [~, strike] = blackscholes_delta(S, rf, DTE/365, IV, i);
    strikes = [strikes; round(strike)];
end

table(transpose(deltas), strikes, 'VariableNames', {'Delta', 'Strike'})


%%%Task 2

K = 200;
S = [170:230];
DTE = [45 30 15 .0001];
IV = 0.18;
rf = 0.03;
data = [];

for i = [1:length(DTE)]
    line = [];
    for j = S
        [callprice, ~, ~, ~] = blackscholes(j, K, rf, DTE(i)/365, IV);
        line = [line callprice];
    end
    data = [data transpose(line)];
end

figure
p = plot(S, data);
title('The Effect of Time Decay on Option Value');
xlabel('Underlying Price');
ylabel('Option Value');
legend(p, '45 DTE', '30 DTE', '15 DTE', '0 DTE');
%pause



%%%%%%%Task 3 alone

K = 200;
S = 200;
DTE = [45:-0.1:0.1 .01];
IV = 0.18;
rf = 0.03;
y1 = [];

for i = DTE
    [callprice, ~, ~, ~] = blackscholes(S, K, rf, i/365, IV);
    y1 = [y1; callprice];
end

figure
p = plot(DTE, y1);
set(gca, 'xdir', 'reverse');
title('Option Value Over Time');
xlabel('DTE');
ylabel('Option Value');


%%%%%%%Task 3, 4, 5, and 6
S = 200;
DTE = [45:-0.1:0.1 .01];
IV = 0.18;
rf = 0.03;
deltas = [0.3 0.1]
ys = y1;

for i = deltas
    y = [];
    for j = DTE
        [~, strike] = blackscholes_delta(S, rf, j/365, IV, i);
        [callprice, ~, ~, ~] = blackscholes(S, strike, rf, j/365, IV);
        y = [y; callprice];
    end
    ys = [ys y];
end

figure
p = plot(DTE, ys);
set(gca, 'xdir', 'reverse');
title('Option Value Over Time');
xlabel('DTE');
ylabel('Option Value');
legend(p, 'K = 200', 'Delta = 0.3', 'Delta = 0.1');
%}





