function determinant = matrixDet( matrix )
%matrixDet calculates matrix determinant
%   matrixDet uses Laplace expansion to determen determinant of matrix
    %% test number of input arguments
    [matrixRow,matrixColumn] = size(matrix);
    %% test if matrix is square
    assert(matrixRow == matrixColumn,'Matrix isn''t square');
    determinant = determinanta(matrix, matrixColumn);
end