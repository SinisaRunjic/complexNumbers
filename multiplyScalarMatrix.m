function  result  = multiplyScalarMatrix( scalar, matrix, rowMatrix, columnMatrix )
%MULTIPLYSCALARMATRIX Summary of this function goes here
%   Detailed explanation goes here
for i = 1:rowMatrix
    for j = 1:columnMatrix
        result(i,j) = scalar .* matrix(i,j);
    end
end


end

