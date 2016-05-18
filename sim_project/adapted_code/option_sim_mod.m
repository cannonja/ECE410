clear 
close all
format compact
format bank

%%%%%%%%%%%%%%%%%%%%% Start data scrubbing %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[d.o, d.h, d.l, d.c, d.v, dt, dn, ds, d.d] = read_data('SPY_2016.csv');
spy_first_date = d.d(1)
spy_last_date = d.d(end)

[vix.o, vix.h, vix.l, vix.c, vix.v, vidt, vidn, vids, vix.d] = read_data('VIX_2016.csv');
vix_first_date = vix.d(1)
vix_last_date = vix.d(end)

ofst = find(spy_first_date == vix.d)-1;   %  find first index for VIX 

% data check
% check that after the offset all dates for SPY and VIX align
dts = [];
for n = 1:length(d.d)
   if (d.d(n) ~= vix.d(n+ofst)) % vix starts earlier therefore we offset it
       dts = [dts;d.d(n)] % first date out of alignment
       disp('Error: time series for SPY and VIX are not aligned with each other')
       keyboard;
   end
end

frii = find(weekday(dt) == 6);  % find all Fridays
% dt(frii)  % check

% find the indicies for the third Friday of the month
dts = [];
formatIn = 'yyyymmdd';
for n=1:length(frii)-1    
    din = datenum(dt(frii(n),:),'yyyy-mm-dd');
    dout= datenum(dt(frii(n+1),:),'yyyy-mm-dd');
    days = daysAct_RPT(din, dout);
    if days > 7 
        [~,~,dd] = datevec(ds(frii(n),:), formatIn);
        if dd>=8 && dd<=14   % here if missing third Friday
            dts = [dts;dt(frii(n),:)]; % need to add the Thursday after this date
        end
    end
end
dts % these are the second Fridays of the month before the missing third Friday of the month


% add in the Thursday before missing Friday
formatOut = 'yyyymmdd';
ads = datestr(dts,formatOut);% change format to 'yyyymmdd' char array(string)
ad = str2num(ads); % change string to number
for n = 1:size(ad,1)
    miss(n,1) = find(d.d >= (ad(n)+6), 1); % adding 6 brings to the following Thursday
end

[~,~,dd] = datevec(ds, formatIn);
nn = find((weekday(dt) == 6) & (dd>=15) & (dd<=21));
nfrii = sort([nn; miss]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% missing:
%  2000-04-21   use Thursday 2000-04-20
%  2003-04-18   use Thursday 2003-04-17
%  2008-03-21   use Thursday 2008-03-20
%  2014-04-18   use Thursday 2014-04-17
% 
% miss(1,1) = find(d.d >= 20000420, 1);
% miss(2,1) = find(d.d >= 20030417, 1);
% miss(3,1) = find(d.d >= 20080320, 1);
% miss(4,1) = find(d.d >= 20140417, 1);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% find the indices for the first day of the month
[~,~,dd] = datevec(ds,formatIn);
kk = find([0;diff(dd)] < 0); % kk are indicies for first day of the month

%%%%%%%%%%%%%%%%%%%% End data scrubbing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tm = [];
pft = [];
days_held = [];
r = 0.02;   % risk free rate
disp('# Month_1   Strike  Value_in   Date_out_f  Date_out     Value_out  Prft  Days_held')
for k=1:length(nfrii)-1  % nfrii has indices for the 3rd Friday of the month
    %%%First for loop enters position
    %%%Second for loop iterates through the days until exit

    din = datenum(ds(kk(k),:),formatIn); % formatIn = 'yyyymmdd';
     dout = datenum(ds(nfrii(k+1),:),formatIn);
      
    S0 = d.c(kk(k));    
    sigma0 = vix.c(kk(k)+ofst)/100;     
    days0 = daysAct_RPT(din, dout);
    time0 = days0/360;
    
    %% Select strikes
    K0 = round(d.c(kk(k)));  % strike selected
    delta_call = 0.9;
    delta_put = -0.9;
    [~, Kc, ~, Kp] = blackscholes_modified(S0, r, sigma0, time0, delta_call, delta_put);
    Kc = round(Kc);  %Round strikes
    Kp = round(Kp);
    %% End strike selection
        
    strangle0 = strangle(S0, Kc, Kp, r, sigma0, time0); % strangle at entry
    
    for k0 = kk(k)+1:kk(k)+days0
        S_r = d.c(k0);
        sigma_r = vix.c(k0+ofst)/100;  
        date_r = dt(k0,:);
        din_r = datenum(ds(k0,:),formatIn);
        days_r = daysAct_RPT(din_r, dout);
        time_r = days_r/360;
        
        strangle_r = strangle(S_r, Kc, Kp, r, sigma_r, time_r); % updated strangle value
   
        reason2 = strangle_r >= 1.9*strangle0;
        reason1 = strangle_r <= 0.25*strangle0;
        reason = days_r <= 1;
        if reason     
%          if reason || reason2     
%          if reason || reason1 || reason2  
            days_held = [days_held; days0-days_r];           
            pft = [pft;strangle0 - strangle_r];
            tm = [tm; size(tm,1), str2num(ds(kk(k),:)), K0, strangle0, ...
                 str2num(ds(nfrii(k+1),:)), str2num(ds(k0,:)), ...
                 strangle_r, pft(end), days_held(end)];           
            fprintf(1,'%d:\t%s\t%d\t%8.2f\t%s\t%s\t%7.2f\t%7.2f\t\t%d\n', ...
                size(tm,1),ds(kk(k),:),K0,strangle0,ds(nfrii(k+1),:), ...
                ds(k0,:),strangle_r,pft(end),days_held(end));       
            break
        end
    end
end

disp('*****************   END   **************')

trade_entry_dates = tm(:,2);
eqt = trade_stats(pft, days_held, trade_entry_dates);
plot(eqt);
