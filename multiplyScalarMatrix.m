function  result  = multiplyScalarMatrix( scalar, matrix, rowMatrix, columnMatrix )
%multiplyScalarMatrix Takes 4 parameters scalar, matrix, rowMatrix and
%columnMatric
for i = 1:rowMatrix
    for j = 1:columnMatrix
        result(i,j) = scalar .* matrix(i,j);
    end
end


end

