function realScalarNumberTest( realNumber )
%REALSCALARNUMBERTEST Summary of this function goes here
%   Detailed explanation goes here
assert(isnumeric(realNumber), 'Inputs aren''t numeric');
assert(~iscell(realNumber) ,'Input value can''t be a cell')
[roX, columnX] = size(realNumber);
assert(roX == 1 && columnX == 1, 'Input value can''t be marix')
assert(imag(realNumber) == 0, 'One of your input is complex number');
end

