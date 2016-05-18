function eqt = trade_stats(pft, days_held, trade_entry_dates)
% Inputs:  
%   pft - vector of trade profits for each trade
%   days_held - vector of days in trade
%   trade_entry_dates - vector of entry dates for each trade
%                    date format is 'yyyymmdd' represented as double
% Output:
%   eqt: vector of equity curve values
%
pft = 100*pft;
num_of_trades = size(pft,1)
total_gain = sum(pft(pft>0))
total_loss = sum(pft(pft<0))
ratio_gain_losses = -total_gain/total_loss 
ave_trade = mean(pft)
num_winning_trades = sum(pft>0)
ave_winning_trade = mean(pft(pft>0))
num_losing_trades = sum(pft<0)
ave_losing_trade = mean(pft(pft<0))
ratio_ave_win_ave_loss = -ave_winning_trade/ave_losing_trade 
max_winning_trade = max(pft)
max_losing_trade = min(pft)

ave_days_held = mean(days_held)
ave_days_held_for_winning_trades = mean(days_held(pft>0))
ave_days_held_for_losing_trades = mean(days_held(pft<0))

probability = sum(pft>0)/num_of_trades
prof = sum(pft)

init_capital = 10000;
eqt = cumsum(pft)+init_capital;


% max drawdown
dd = zeros(length(eqt)-1,3);
for k=1:length(eqt)-1
   [pmax, i] = max(eqt(1:k+1)); 
   [pmin, j] = min(eqt(i:k+1));
   
   dd(k,:) = [(pmax - pmin), i, i+j-1];
end
[maxdd, k] = max(dd(:,1));
mx = eqt(dd(k,2)); % dd(k,2) is the index where the max occures
mn = eqt(dd(k,3)); % dd(k,3) is the index where the min occures
maxdd

% maxdd_per_cent = (mx-mn)/mx *100
maxdd_per_cent = maxdd/mx *100
drawdown_starts_at_trade = [dd(k,2),   mx]
start_date_of_drawdown = trade_entry_dates(dd(k,2))
drawdown_end_at_trade = [dd(k,3),   mn]
end_date_of_drawdown = trade_entry_dates(dd(k,3))
