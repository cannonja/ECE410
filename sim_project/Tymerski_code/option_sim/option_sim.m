clear 
close all
format compact
format bank

[d.o, d.h, d.l, d.c, d.v, dt, dn, ds, d.d] = read_data('SPY_2015.csv');
spy_first_date = d.d(1)
spy_last_date = d.d(end)

[vix.o, vix.h, vix.l, vix.c, vix.v, vidt, vidn, vids, vix.d] = read_data('VIX_2015.csv');
vix_first_date = vix.d(1)
vix_last_date = vix.d(end)

frii = find(weekday(dt) == 6);  % find all Fridays
% dt(frii)  % check

% missing:
%  2000-04-21   use Thursday 2000-04-20
%  2003-04-18   use Thursday 2003-04-17
%  2008-03-21   use Thursday 2008-03-20
%  2014-04-18   use Thursday 2014-04-17

miss(1,1) = find(d.d >= 20000420, 1);
miss(2,1) = find(d.d >= 20030417, 1);
miss(3,1) = find(d.d >= 20080320, 1);
miss(4,1) = find(d.d >= 20140417, 1);

frii = sort([frii; miss]);

% find the indicies for the third Friday of the month
nn = [];
formatIn = 'yyyymmdd';
for n=1:length(frii)
    [yy,mm,dd] = datevec(ds(frii(n),:), formatIn);
    % dd = str2num(ds(frii(n),[7 8]));
    if dd>=15 && dd<22
        nn = [nn, n]; % nn has the indicies for the third Friday of the month
    end
end

% find the indicies for the first day of the month
kk = [];
[~,m1,~] = datevec(ds(1,:),formatIn); % get first month
% formatIn = 'yyyymmdd';
for k=2:length(ds)
    [~,m,~] = datevec(ds(k,:),formatIn);
    if m~=m1
        kk = [kk, k]; % kk are the indicies for the first day of the month
        m1 = m;
    end
end

% size(kk) %  kk are the indicies for the first day of the month
% ds(kk,:) %  check 

tm = [];
pft = [];
days_held = [];
r = 0.02;   % risk free rate
disp('# Month_1   Strike  Value_in   Date_out_f  Date_out     Value_out  Prft  Days_held')
for k=1:length(nn)-1

    din = datenum(ds(kk(k),:),formatIn);
    % din = datenum(dt(kk(k),:),'yyyy-mm-dd');
    dout = datenum(ds(frii(nn(k+1)),:),formatIn);
    % dout= datenum(dt(frii(nn(k+1)),:),'yyyy-mm-dd');
      
    S0 = d.c(kk(k));
    K0 = round(d.c(kk(k)));  % strike selected 
    sigma0 = vix.c(kk(k))/100;
    %  date0 = dt(kk(k),:);
    %  days0 = daysact(din, dout); % Matlab provided function
    days0 = daysAct_RPT(din, dout);
    time0 = days0/360;
        
    straddle0 = straddle(S0, K0, r, sigma0, time0); % straddle at entry
    
    for k0 = kk(k)+1:kk(k)+days0
        S_r = d.c(k0);
        sigma_r = vix.c(k0)/100;
        date_r = dt(k0,:);
        %  din_r = datenum(dt(k0,:),'yyyy-mm-dd');
        din_r = datenum(ds(k0,:),formatIn);
        %  days_r = daysact(din_r, dout);
        days_r = daysAct_RPT(din_r, dout);
        time_r = days_r/360;
        
        straddle_r = straddle(S_r, K0, r, sigma_r, time_r); % updated straddle value
        
        %  reason1 = straddle_r <= 0.50*straddle0;
        reason = days_r <= 1;
        if reason             
            days_held = [days_held; days0-days_r];           
            pft = [pft;straddle0 - straddle_r];
            tm = [tm; size(tm,1), str2num(ds(kk(k),:)), K0, straddle0, ...
                str2num(ds(frii(nn(k+1)),:)), str2num(ds(k0,:)), ...
                straddle_r, pft(end), days_held(end)];
%             disp('# Month_1   Strike  Value_in    Date_out_f   Date_out     Value_out  Prft  Days_held')
            fprintf(1,'%d:\t%s\t%d\t%8.2f\t%s\t%s\t%7.2f\t%7.2f\t\t%d\n', ...
                size(tm,1),ds(kk(k),:),K0,straddle0,ds(frii(nn(k+1)),:), ...
                ds(k0,:),straddle_r,pft(end),days_held(end));
            
            break
        end
    end
end

disp('*****************   END   **************')

trade_entry_dates = tm(:,2);
eqt = trade_stats(pft, days_held, trade_entry_dates);
plot(eqt);
