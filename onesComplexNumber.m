function cmpxNum = onesComplexNumber( row, column )
%ONESCOMPLEXNUMBER Summary of this function goes here
%   Detailed explanation goes here
for i = 1:row
    for j=1:column
        cmpxNum(i,j) = ComplexNumber(1,0);
    end
end
end

