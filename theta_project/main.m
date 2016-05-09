%{
%%%%%%%Task 1

S = 200;
DTE = 45;
IV = 0.18;
rf = 0.03;

strikes = [];
deltas = 0.9:-0.1:0.1;

for i = deltas
    [~, strike] = blackscholes_modified(S, rf, DTE/365, IV, i);
    strikes = [strikes; round(strike)];
end

uitable('Data', [transpose(deltas) strikes], 'ColumnName', {'Delta', 'Strike'})
%}

%{
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
%}


%%%%%%%Task 3, 4, 5, and 6
%{
K = 200;
S = 200;
DTE = [45:-0.1:0.1 .01];
IV = 0.18;
rf = 0.03;
deltas = [0.3 0.1];
y1 = [];

for i = DTE
    [callprice, ~, ~, ~] = blackscholes(S, K, rf, i/365, IV);
    y1 = [y1; callprice];
end

figure
p = plot(DTE, y1);
set(gca, 'xdir', 'reverse');
title('Option Value Over Time (K = 200)');
xlabel('DTE');
ylabel('Option Value');

ydelta = [];
for i = deltas
    y2 = [];
    for j = DTE
        [callprice, ~] = blackscholes_modified(S, rf, j/365, IV, i);
        y2 = [y2; callprice];
    end
    figure
    p = plot(DTE, y2);
    set(gca, 'xdir', 'reverse');
    s1 = 'Option Value Over Time (Delta = ';
    t = strcat(s1, num2str(i), ')');
    title(t);
    xlabel('DTE');
    ylabel('Option Value');
    ydelta = [ydelta y2];
end

ys = [y1 ydelta];
figure
p = plot(DTE, ys);
set(gca, 'xdir', 'reverse');
title('Option Value Over Time');
xlabel('DTE');
ylabel('Option Value');
legend(p, 'K = 200', 'Delta = 0.3', 'Delta = 0.1');
%}

%{
%%%%%%%Task 7
S = 200;
IV = 0.18;
rf = 0.03;
deltas = [0.3 0.1];
days = [];

DTE = 45;
[callprice, ~, ~, ~] = blackscholes(S, S, rf, DTE/365, IV);
exit = 0.5 * callprice;
while callprice > exit
    [callprice, ~, ~, ~] = blackscholes(S, S, rf, DTE/365, IV);
    DTE = DTE - 1;
end
days = [days; (45 - DTE)];

for i = deltas
    DTE = 45;
    [callprice, ~] = blackscholes_modified(S, rf, DTE/365, IV, i);
    exit = 0.5 * callprice;
    while callprice > exit
        [callprice, ~] = blackscholes_modified(S, rf, DTE/365, IV, i);
        DTE = DTE - 1;
    end
    days = [days; (45 - DTE)];
end

deltas = [0.5 deltas];
uitable('Data', [transpose(deltas) days], 'ColumnName', {'Delta', 'Days to 50%'})
%}




