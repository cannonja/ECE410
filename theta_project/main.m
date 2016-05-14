
%%%%%%%Task 1
%{
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


%{
%%%%%%%Task 3, 4, 5, and 6
S = 200;
DTE = 45:-0.1:.01;
IV = 0.18;
rf = 0.03;
deltas = [0.5 0.3 0.1];
ys = [];

for  del = deltas
    y1 = [];
    [init_price, K] = blackscholes_modified(S, rf, DTE(1)/365, IV, del);

    for i = DTE
        [callprice, ~, ~, ~] = blackscholes(S, K, rf, i/365, IV);
        y1 = [y1; callprice];
    end

    figure
    p = plot(DTE, y1);
    set(gca, 'xdir', 'reverse');
    s1 = 'Option Value Over Time (Delta = ';
    t = strcat(s1, num2str(del), ')');
    title(t);
    xlabel('DTE');
    ylabel('Option Value');
    ys = [ys y1];
end

figure
p = plot(DTE, ys);
set(gca, 'xdir', 'reverse');
title('Option Value Over Time');
xlabel('DTE');
ylabel('Option Value');
legend(p, 'Delta = 0.5', 'Delta = 0.3', 'Delta = 0.1');
%}



