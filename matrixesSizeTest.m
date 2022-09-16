function [ row, column ] = matrixesSizeTest( matrix1, matrix2 )
%MATRIXESS Summary of this function goes here
%   Detailed explanation goes here
[rowMatrix1, columnMatrix1] = size(matrix1);
[rowMatrix2, columnMatrix2] = size(matrix2);
if(rowMatrix1 == rowMatrix2 && columnMatrix1 == columnMatrix2)
   row =  rowMatrix1;
   column = columnMatrix1;
   return
end
error ('size of matrix aren''t same');
end

