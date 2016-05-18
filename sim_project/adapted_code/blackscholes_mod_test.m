deltas = [0.0:0.05:1.0];
S = 200;
rf = 0.03;
DTE = 45;
IV = 0.3;
data = [];

for i = deltas
    [Cp, Kc, Pp, Kp] = blackscholes_modified(S, rf, DTE/360, IV, i, -i);
    data = [data; [Cp, Kc, Pp, Kp]];
end

T = table(data(:,1), data(:,2), data(:,3), data(:,4), 'VariableName',...
        {'CallP', 'CallK', 'PutP', 'PutK'});

disp('-----------blackscholes_modified results-------------');
T

%%% Use strikes from above to generate prices and compare

hull_data = [];
for i = 1:length(data(:,2))
    cp = bs_european_call(S, data(i,2), rf, IV, DTE/360);
    pp = bs_european_put(S, data(i,4), rf, IV, DTE/360);
    hull_data = [hull_data; [cp, pp]];
end

T2 = table(data(:,1), hull_data(:,1), data(:,3), hull_data(:,2),...
        'VariableName', {'Mod_call', 'Hull_call', 'Mod_put', 'Hull_put'});

disp('------------------Comparison---------------------------');
T2
