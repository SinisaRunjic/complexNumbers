function matrixResult = matrixPowerOnRealNumber( matrix, realNumber )
%MATRIXPOWERONREALNUMBER Summary of this function goes here
%   Detailed explanation goes here
matrixResult = matrix;
for i=1:realNumber-1
    matrixResult = matrixResult*matrixResult;
end
end

