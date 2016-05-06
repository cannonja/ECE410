%%Task 1 -- need to ask about how to get deltas without solving for them


S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [180:5:220];
data = [];

for i = strikes
    [~, ~, cd, ~] = blackscholes(S, i, rf, DTE/365, IV);
    data = [data; i cd];
end

digits(3);
double(data);
data


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



