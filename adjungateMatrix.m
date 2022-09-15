function adjugateMatrix  = adjungateMatrix( matrix )
%inversMatrix calclate adjugate matrix 
   %% test number of input arguments
    assert(nargin>0,'Provide input argument');
    [matrixRow,matrixColumn, matrixLayer] = size(matrix);
    %% calculation
    adjugateMatrix = onesComplexNumber(matrixRow,matrixColumn);
    minusOne = ComplexNumber(-1,0);
    if(matrixRow > 1)
        for i = 1:matrixRow
            for j = 1:matrixColumn
                adjugateMatrix(i,j) = minusOne.power(j+i)*matrixDet(matrix([1:i-1 i+1:end],[1:j-1 j+1:end]));
            end
        end
    end
    adjugateMatrix = adjugateMatrix.';
end