classdef ComplexNumber
    properties
        realValue
        imaginaryValue
    end
    properties (Dependent)
        modulus %% it is always larger than 0
        argument %% in rad it goes from [-pi/2, pi/2)
    end
    methods
        function cmpxNum = ComplexNumber(realValueOrModulus,imaginaryValueOrArgument,coordinates)
            %% Constructor
            % if you pass 2 inputs or 3 inputs where coordinates is 'Cartesian' then you write in class
            % realValue and imaginaryValue, if you pass 3 inputs and
            % coordinates as 'polar' then it converts polar coordinates
            % it to cartesian coordinates and writes in class
            % realValueOrModulus if it is modulus it needs to be larger
            % or equal than 0
            % imaginarimaginaryValueOrArgument if it is argument it needs
            % to be in rad
            %% test inputs
            if(nargin>0)
                if(nargin >= 4)
                   error('Too many input arguments') 
                end
                if(nargin == 3)
                    if(~strcmp(coordinates,'polar') && ~strcmp(coordinates,'Cartesian'))
                        error('coordinates input needs to be ''Cartesian'' or ''polar''')
                    end
                end
                if(nargin == 2)
                    coordinates = 'Cartesian';
                end
                if(nargin == 1)
                    error('Input one more input argument')
                end
                realScalarNumberTest(realValueOrModulus)
                realScalarNumberTest(imaginaryValueOrArgument)
                %% write in class
                if(strcmp(coordinates,'polar'))
                    assert(realValueOrModulus>=0, 'Input "realValueOrModulus" is smaller than 0 while using polar coordinates');
                    cmpxNum = cmpxNum.convertPolarToCartesian(realValueOrModulus,imaginaryValueOrArgument);
                else
                    cmpxNum.realValue = realValueOrModulus;
                    cmpxNum.imaginaryValue = imaginaryValueOrArgument;
                end
            end
        end
        function modulus = get.modulus(cmpxNum)
            modulus = sqrt(cmpxNum.realValue.*cmpxNum.realValue + cmpxNum.imaginaryValue.*cmpxNum.imaginaryValue);
        end
        function cmpxNum = set.modulus(cmpxNum,~)
            error('You cannot set modulus property');
        end
        function argument = get.argument(cmpxNum)
            argument = atan2(cmpxNum.imaginaryValue,cmpxNum.realValue);
        end
        function cmpxNum = set.argument(cmpxNum,~)
            error('You can''t set argument property');
        end
        function [modulus,argument] = getPolarCoordinates(cmpxNum)
            modulus = cmpxNum.modulus;
            argument = cmpxNum.argument;
        end
        function cmpxNum = inverse(cmpxNum1)
            %% cmpxNum = adjungateMatrix(cmpxNum1)/determinant(cmpxNum1)
            determinant = matrixDet(cmpxNum1);
            assert(abs(determinant.modulus) > 10^(-7),'Can''t find inverse matrix if determinant is 0')
            cmpxNum = adjungateMatrix(cmpxNum1).*determinant.power(-1);
        end
        function plotComplexNumber(cmpxNum)
            [row, column] = size(cmpxNum);
            %% Cartesian coordinate system
            hold on
            figure(1)
            title('Complex numbers')
            for i=1:row
                for j = 1:column
                    plot(cmpxNum(i,j).realValue,cmpxNum(i,j).imaginaryValue,'+','Color',[0.2 0.6 0.8])
                end
            end
            hold off
        end
    end
    %% function overload operators
    methods
        %% cmpxNum1 + cmpxNum2
        function cmpxNum = plus(cmpxNum1,cmpxNum2)
            [row, column] = matrixesSizeTest(cmpxNum1,cmpxNum2);
            cmpxNum = zerosComplexNumber(row, column);
            for i = 1 :row
                for j = 1 : column
                    cmpxNum(i,j).realValue = cmpxNum1(i,j).realValue + cmpxNum2(i,j).realValue;
                    cmpxNum(i,j).imaginaryValue = cmpxNum1(i,j).imaginaryValue + cmpxNum2(i,j).imaginaryValue;
                end
            end
        end
        %% cmpxNum1 - cmpxNum2
        function cmpxNum = minus(cmpxNum1,cmpxNum2)
            % cmpxNum1 - cmpxNum2
            cmpxNum = cmpxNum1 + (-cmpxNum2);
        end
        %% cmpxNum1 .* cmpxNum2
        function cmpxNum = times(cmpxNum1,cmpxNum2)
            % cmpxNum1 .* cmpxNum2
            [rowCmpxNum1, columnCmpxNum1]= size(cmpxNum1);
            [rowCmpxNum2, columnCmpxNum2]= size(cmpxNum2);
            %% if one of them is scalar
            if((rowCmpxNum1 == 1 && columnCmpxNum1 == 1) || (rowCmpxNum2 == 1 && columnCmpxNum2 == 1))
                if(rowCmpxNum1 == 1 && columnCmpxNum1 == 1 && (rowCmpxNum2 ~= 1 || columnCmpxNum2 ~= 1))
                    cmpxNum = multiplyScalarMatrix(cmpxNum1,cmpxNum2,rowCmpxNum2,columnCmpxNum2);
                    return
                end
                if(rowCmpxNum2 == 1 && columnCmpxNum2 == 1 && rowCmpxNum1 ~= 1 || columnCmpxNum1 ~= 1)
                    cmpxNum = multiplyScalarMatrix(cmpxNum2,cmpxNum1,rowCmpxNum1,columnCmpxNum1);
                    return
                end
            end
            %% via polar coordinates
            if(rowCmpxNum1 == rowCmpxNum2 && columnCmpxNum1 == columnCmpxNum2)
                cmpxNum = zerosComplexNumber(rowCmpxNum1,columnCmpxNum1);
                for i=1:rowCmpxNum1
                    for j=1:columnCmpxNum1
                        cmpxNum(i,j) = ComplexNumber(cmpxNum1(i,j).modulus.*cmpxNum2(i,j).modulus,cmpxNum1(i,j).argument + cmpxNum2(i,j).argument,'polar');
                    end
                end
                return
            end
            error('There is dimension problem with inputs');
        end
        %% cmpxNum1 * cmpxNum2
        function cmpxNum = mtimes(cmpxNum1,cmpxNum2)
            % cmpxNum1 * cmpxNum2
            [rowCmpxNum1, columnCmpxNum1]= size(cmpxNum1);
            [rowCmpxNum2, columnCmpxNum2]= size(cmpxNum2);
            if((rowCmpxNum1 == 1 && columnCmpxNum1 == 1) || (rowCmpxNum2 == 1 && columnCmpxNum2 == 1))
                if(rowCmpxNum1 == 1 && columnCmpxNum1 == 1 && (rowCmpxNum2 ~= 1 && columnCmpxNum2 ~= 1))
                    cmpxNum = multiplyScalarMatrix(cmpxNum1,cmpxNum2,rowCmpxNum2,columnCmpxNum2);
                    return
                end
                if(rowCmpxNum2 == 1 && columnCmpxNum2 == 1 && rowCmpxNum1 ~= 1 && columnCmpxNum1 ~= 1)
                    cmpxNum = multiplyScalarMatrix(cmpxNum2,cmpxNum1,rowCmpxNum1,columnCmpxNum1);
                    return
                end
            end
            if(columnCmpxNum1 == rowCmpxNum2)
                cmpxNum = zerosComplexNumber(rowCmpxNum1,columnCmpxNum2);
                for i=1:rowCmpxNum1
                    for k = 1:columnCmpxNum2
                        for j = 1: columnCmpxNum1
                            cmpxNum(i,k) = cmpxNum(i,k) +  cmpxNum1(i,j) .* cmpxNum2(j,k);
                        end
                    end
                end
                return
            end
            error('There is dimension problem with inputs');
        end
        %% cmpxNum1 /complexNum == cmpxNum * (cmpxNum2)^(-1)
        function cmpxNum = mrdivide(cmpxNum1, cmpxNum2)
            % cmpxNum1 /complexNum == cmpxNum * (cmpxNum2)^(-1)
            cmpxNum = cmpxNum1 * cmpxNum2.inverse();
        end
        %% cmpxNum1 ./ cmpxNum2 == cmpxNum1 .* cmpxNum2^(-1)
        function cmpxNum = rdivide(cmpxNum1, cmpxNum2)
            % cmpxNum1 ./ cmpxNum2 == cmpxNum1 .* cmpxNum2^(-1)
            cmpxNum = cmpxNum1 .* cmpxNum2.inverse();
        end
        %% cmpxNum1 .\ cmpxNum2 == cmpxNum1^(-1) .* cmpxNum2
        function cmpxNum = ldivide(cmpxNum1, cmpxNum2)
            % cmpxNum1 .\ cmpxNum2 == cmpxNum1^(-1) .* cmpxNum2
            cmpxNum = cmpxNum1.inverse() .* cmpxNum2;
        end
        %% power(a,b)
        function cmpxNum = power(cmpxNum, realNumber)
            % a.^b b needs to be real number
            realScalarNumberTest(realNumber);
            [rowCmpxNum, columnCmpxNum] = size(cmpxNum);
            for i = 1:rowCmpxNum
                for j = 1:columnCmpxNum
                    cmpxNum(i,j) = cmpxNum(i,j).convertPolarToCartesian(cmpxNum(i,j).modulus .^ realNumber,cmpxNum(i,j).argument .* realNumber);
                end
            end
        end
        %% mpower(A,b)
        function cmpxNum = mpower(cmpxNum, realNumber)
            % A^b b needs to be real number
            realScalarNumberTest(realNumber);
            if(realNumber>0)
                cmpxNum = matrixPowerOnRealNumber(cmpxNum, realNumber);
                return
            end
            if(realNumber<0)
                cmpxNum = matrixPowerOnRealNumber(cmpxNum.inverse(), abs(realNumber));
                return
            end
            if(realNumber == 0)
                [rowCmpxNum, columnCmpxNum] = size(cmpxNum);
                cmpxNum = onesComplexNumber(rowCmpxNum,columnCmpxNum);
                return
            end
        end
        %% -cmpxNum
        function cmpxNum = uminus(cmpxNum)
            % -cmpxNum
            [row, column] = size(cmpxNum);
            for i=1:row
                for j=1:column
                    cmpxNum(i,j).realValue = -cmpxNum(i,j).realValue;
                    cmpxNum(i,j).imaginaryValue = -cmpxNum(i,j).imaginaryValue;
                end
            end
        end
        %% cmpxNum'
        function cmpxNum = ctranspose(cmpxNum1)
            % cmpxNum'
            [row, column] = size(cmpxNum1);
            for i = 1:row
                for j=1:column
                    cmpxNum(j,i) = ComplexNumber(cmpxNum1(i,j).modulus, -cmpxNum1(i,j).argument, 'polar') ;
                end
            end
        end
        function cmpxNum = transpose(cmpxNum1)
            % cmpxNum'
            [row, column] = size(cmpxNum1);
            for i = 1:row
                for j=1:column
                    cmpxNum(j,i) = cmpxNum1(i,j);
                end
            end
        end
        %% cmpxNum1 == cmpxNum2
        function result = eq(cmpxNum1, cmpxNum2)
            % cmpxNum1 == cmpxNum2
            [row, column] = matrixesSizeTest(cmpxNum1,cmpxNum2);
            result = false;
            for i = 1:row
                for j = 1:column
                    if(cmpxNum1(i,j).realValue ~= cmpxNum2(i,j).realValue || cmpxNum1(i,j).imaginaryValue ~= cmpxNum2(i,j).imaginaryValue)
                        return
                    end
                end
            end
            result = true;
        end
        %% cmpxNum1 ~= cmpxNum2
        function result = ne(cmpxNum1, cmpxNum2)
            % cmpxNum1 ~= cmpxNum2
            result = ~(cmpxNum1 == cmpxNum2);
        end
    end
    methods (Access = private)
        %% function that transfers polar koordinates to Cartesian
        function cmpxNum = convertPolarToCartesian(~,modulus,argument)
            %function that transfers polar koordinates to Cartesian
            cmpxNum = ComplexNumber(modulus * cos(argument),modulus * sin(argument));
        end
    end
end