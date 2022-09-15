function determinant = matrixDet( matrix )
%matrixDet calculates matrix determinant
%   matrixDet uses Laplace expansion to determen determinant of matrix
    %% test number of input arguments
    [matrixRow,matrixColumn, matrixLayer] = size(matrix);
    determinant = determinanta(matrix, matrixColumn);
end