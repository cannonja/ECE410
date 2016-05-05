%%Task 1 -- need to ask about how to get deltas without solving for them

%{
S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [180:5:220];
list = [];

for i = strikes
    [~, ~, cd, ~] = blackscholes(S, i, rf, DTE/365, IV);
    list = [list cd];
end

strikes = transpose(strikes);
list = transpose(list);

T = table(strikes, list);
T

[strikes list]
%}


%%%Task 2
%{
K = 200;
S = [170:230];
DTE = [45 30 15 0];
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

%data(:,1)
%transpose(S)
%data(:,1)
figure
p = plot(S, data(:,1), S, data(:,2), S, data(:,3), S, data(:,4));
title('Option Value vs. Underlying')
xlabel('Underlying Price')
ylabel('Option Value')
legend(p, '45 DTE', '30 DTE', '15 DTE', '0 DTE')
%pause
%}




