function NumDays = daysAct( StartDate, EndDate )
%daysact Actual number of days between dates
%  Given two dates in serial date numbers or date strings, calculate the
%  actual number of days between them
%
%  NumDays = daysact(StartDate, EndDate)
%
% Inputs:
%  StartDate (required) - The starting date in serial date number or date
%  string format
%  EndDate (optional) - The ending date in serial date number or date
%  string format.  Defaults to the MATLAB base date (1-Jan-0000 AD)

%  Author(s): B. Blunk 02/11/05 bblunk@unlnotes.unl.edu

if(nargin < 1)
    error('You must specify StartDate')
end

if(nargin < 2)
    EndDate = 0;
end

if ((size(StartDate,1) ~= 0) & (size(EndDate,1) ~=0) & (size(EndDate,1) ~= size(StartDate,1)))
    error('StartDate and EndDate must be of same size or scalar')
end

NumDays = datenum(datevec(EndDate)) - datenum(datevec(StartDate));
