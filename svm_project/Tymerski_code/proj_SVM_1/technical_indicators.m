function [ indicators ] = technical_indicators(stk)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Calculate Technicals

I1 = TA_RSI(stk.c, 14);
[bBandsHigh, bBandsMid, bBandsLow] = TA_BBANDS(stk.c,9,2,2);
I2 = (stk.c - bBandsHigh)./bBandsHigh;  
I3 = (stk.c - bBandsLow)./bBandsLow;
[stochK, stochD] = TA_STOCHF(stk.h,stk.l,stk.c, 14, 3);% 14,3
I4 = stochK;
I5 = stochD;
I6 = [nan; diff(stochK)];
I7 = [nan; diff(stochD)];  
I8 = [nan; diff(stk.c)./stk.c(1:end-1)];
I9 = (stk.c - stk.l)./(stk.h-stk.l); % similar to StochRSI
PMAs = TA_SMA(stk.c,10);
PMAl = TA_SMA(stk.c,21);
I10 = [nan; diff(PMAs)./PMAs(1:end-1)];
I11 = [nan; diff(PMAl)./PMAl(1:end-1)];
I12 = [nan; (PMAs(2:end)-PMAl(1:end-1))./PMAl(1:end-1)];
I13 = (stk.c - PMAl)./PMAl;
I14 = (stk.c - TA_MIN(stk.c,5))./TA_MIN(stk.c,5);
I15 = (stk.c - TA_MAX(stk.c,5))./TA_MAX(stk.c,5);
I16 = (((TA_SMA(stk.c,5) - TA_SMA(stk.c,12)) ./ TA_SMA(stk.c,12))); % MA
I17 = [nan(12,1); (stk.c(13:end) - stk.c(1:end-12)) ./ stk.c(1:end-12)];  % MOM
I18 = TA_KAMA(stk.c,12);    % Kaufman Adaptive Moving Average  KAMA
I19 = ConnorsRSI(stk.c,6,3,85);    % ConnorsRSI    CRSI   % 6,3,85 -> 64.18%
I20 = TA_MFI(stk.h,stk.l,stk.c,stk.v);    % Money Flow Index    MFI
I21 = TA_BOP(stk.o,stk.h,stk.l,stk.c);    % Balance of Power    BOP
I22 = TA_WILLR(stk.h,stk.l,stk.c,14);    % Williams %R    willr
I23 = TA_ULTOSC(stk.h,stk.l,stk.c,7,14,28);    % Ultimate Oscillator Index    ultosc
I24 = TA_ROC(stk.c,5);    % Rate-of-Change  ROC
I25 = TA_ATR(stk.h,stk.l,stk.c,14);    % Average True Range ATR
I26 = TA_NATR(stk.h,stk.l,stk.c,14);   % Normalize Average True Range  NATR
I27 = TA_STDDEV(stk.c,7);    % Standard Deviation    stddev
I28 = TA_OBV(stk.c,stk.v);  % On Balance Volume OBV
I29 = TA_PPO(stk.c,9,26,2); % Percentage Price Oscillator PPO
I30 = TA_MEDPRICE(stk.h,stk.l);    % Median Price  MEDPRICE
I31 = TA_EMA(stk.c,4); % Exponential Moving Average    EMA
I32 = TA_TEMA(stk.c,10);   % Triple Exponential Moving Average TEMA
I33 = TA_ADX(stk.h,stk.l,stk.c,14); % Average Directional Movement Index ADX
I34 = TA_CMO(stk.c,10); % Chande Momentum Oscillator    CMO
I35 = TA_CCI(stk.h,stk.l,stk.c,20); % Commodity Channel Index   CCI
[outFastK,outFastD] = TA_STOCHRSI(stk.c,120,120,3,1);   % StochRSI  I36 & I37
I36 = outFastK;
I37 = outFastD;
VMAs = TA_SMA(stk.v,10);
VMAl = TA_SMA(stk.v,21);
% MINp = TA_MIN(stk.c,6);
% MAXp = TA_MAX(stk.c,6);
MINv = TA_MIN(stk.v,6);
MAXv = TA_MAX(stk.v,6);
I38 = [nan;diff(stk.v)./(stk.v(1:end-1))];
I39 = [nan;diff(VMAs)./VMAs(1:end-1)];
I40 = [nan;diff(VMAl)./VMAl(1:end-1)];
I41= [nan;(VMAs(2:end) - (VMAl(1:end-1)))./VMAl(1:end-1)];
I42 = (stk.v - VMAl)./VMAl;
I43 = (stk.v - MINv)./MINv;
I44 = (stk.v - MAXv)./MAXv;

indicators=[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17,...
    I18,I19,I20,I21,I22,I23,I24,I25,I26,I27,I28,I29,I30,I31,I32,I33,...
    I34,I35,I36,I37,I38,I39,I40,I41,I42,I43,I44];

end

