function x = ConnorsRSI(c,d,e,m)

x = (TA_RSI(c,d) + TA_RSI(streak(c),e) + PercentRank(c,m))/3;


function rank = PercentRank(c, lookback)

rank = zeros(length(c),1);
oneDayReturns = [nan; (diff(c) ./ c(1:end-1))];

for n = lookback+1:length(c)
    rank(n) = 100*sum(oneDayReturns(n) > oneDayReturns(n-lookback:n))/lookback;
end


function streak = streak(c)

streak = zeros(length(c),1);
for n = 1:length(c)-1
    k = c(n+1) - c(n);
    if k == 0
        streak(n+1) = 0;
    else
        if k > 0
            if streak(n) >= 0
                streak(n+1) = streak(n) + 1;
            else
                streak(n+1) = 1;
            end
        else
            if streak(n) <= 0
                streak(n+1) = streak(n) - 1;
            else
                streak(n+1) = -1;
            end
        end
    end
end


% function lookback = PercentRank(c,m)
% 
% % one_day_return = zeros(length(c),1);
% lookback = zeros(length(c),1);
% % for n = 1:length(c)-1
% %     one_day_return(n+1) = (c(n+1) - c(n))/c(n+1);
% % end
% 
% one_day_return = [nan; (diff(c) ./ c(1:end-1))];
% 
% for n = m+1:length(c)
%     lookback(n) = 100*sum(one_day_return(n) > one_day_return(n-m:n))/m;
% end

% for n = 1:length(c)-m
%     k = 0;
%     for l = 1:m
%         if one_day_return(n+100) > one_day_return(n+l-1)
%             k = k + 1;
%         end
%         lookback(n+100) = k;
%     end
% end
    

% function streak = trend(c)
% 
% streak = zeros(length(c),1);
% for n = 1:length(c)-1
%     k = c(n+1) - c(n);
%     if k == 0
%         streak(n+1) = 0;
%     else
%         if k > 0
%             if streak(n) >= 0
%                 streak(n+1) = streak(n) + 1;
%             else
%                 streak(n+1) = 1;
%             end
%         else
%             if streak(n) <= 0
%                 streak(n+1) = streak(n) - 1;
%             else
%                 streak(n+1) = -1;
%             end
%         end
%     end
% end
