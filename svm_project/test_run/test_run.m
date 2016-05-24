[op, hi, lo, cl, vo, dt, dn, ds, d] = read_data('SP500_RPT.csv');
%data = zeros(3263, 9);
%data = read_data('SP500_RPT.csv');

data = [op, hi, lo, cl, vo, dt, dn, ds, d];

size(data);
