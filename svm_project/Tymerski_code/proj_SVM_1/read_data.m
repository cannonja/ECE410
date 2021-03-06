function [op, hi, lo, cl, vo, dt, dn, ds, d] = read_data( filename )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%fid = fopen('SP500_RPT.csv');  
fid = fopen(filename);  
% ^GSPC data from Yahoo
C = textscan(fid, '%s%f%f%f%f%f%f','Delimiter',',','Headerlines',1);
fclose(fid);

dt = C{1}(end:-1:1);  
% format is 'yyyy-mm-dd', e.g. '2013-11-29' cell
formatIn = 'yyyy-mm-dd';
dn = datenum(dt,formatIn);
formatOut = 'yyyymmdd';
ds = datestr(dn,formatOut);  
% change format to 'yyyymmdd' char array (string)
d = str2num(ds);  
% change string to number
    
op = C{2}(end:-1:1);
hi = C{3}(end:-1:1);
lo = C{4}(end:-1:1);
%c = C{5}(end:-1:1);
cl = C{7}(end:-1:1);   
vo = C{6}(end:-1:1);


end

