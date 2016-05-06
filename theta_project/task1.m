%%Tested modified blackscholes
%{
S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [180:1:220];
deltas = [];
cvalues = [];
cvalues2 = [];
equal = [];

for i = strikes
    [cp, ~, cd, ~] = blackscholes(S, i, rf, DTE/365, IV);
    cp2 = blackscholes_delta(S, i, rf, DTE/365, IV, cd);
    deltas = [deltas; cd];
    cvalues = [cvalues; cp];
    cvalues2 = [cvalues2; cp2];
    equal = [equal; cp == cp2];
end

all(equal)
%table(transpose(strikes), deltas , cvalues, cvalues2, 'VariableNames', {'Strikes', 'Deltas', 'Price', 'Price2'})
%}

%%Task 1

S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [180:1:220];
deltas = [];
cvalues = [];
cvalues2 = [];
equal = [];

for i = strikes
    [cp, ~, cd, ~] = blackscholes(S, i, rf, DTE/365, IV);
    cp2 = blackscholes_delta(S, i, rf, DTE/365, IV, cd);
    deltas = [deltas; cd];
    cvalues = [cvalues; cp];
    cvalues2 = [cvalues2; cp2];
    equal = [equal; cp == cp2];
end







%%%Task 2
%{
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
%}


%%%Task 3
%{
K = 200;
S = 200;
DTE = [45:-0.1:0.1 .01];
IV = 0.18;
rf = 0.03;
y = [];


for i = DTE
    [callprice, ~, ~, ~] = blackscholes(S, K, rf, i/365, IV);
    y = [y; callprice];
end


figure
p = plot(DTE, y);
set(gca, 'xdir', 'reverse');
title('Option Value Over Time');
xlabel('DTE');
ylabel('Option Value');
%}



