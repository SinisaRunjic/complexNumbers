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
            % if you pass 2 inputs or 3 inputs where coordinates is 'cartesian' then you write in class
            % realValue and imaginaryValue, if you pass 3 inputs and
            % coordinates as 'polar' then it converts polar coordinates
            % it to cartesian coordinates and writes in class
            % realValueOrModulus if it is modulus it needs to be larger
            % or equal than 0
            % imaginarimaginaryValueOrArgument if it is argument it needs
            % to be in rad
            %% test inputs
            if(nargin>0)
                if(nargin == 3)
                    if(strcmp(coordinates,'polar') || strcmp(coordinates,'Cartesian'))
                    else
                        error('coordinates input needs to be ''Cartesian'' or ''polar''')
                    end
                end
                if(nargin == 2)
                    coordinates = 'Cartesian';
                end
                if(nargin == 1)
                    error('Input one more input argument')
                end
                assert(isnumeric(realValueOrModulus) && isnumeric(imaginaryValueOrArgument), 'one of your inputs aren''t numeric');
                assert(~iscell(realValueOrModulus) || ~iscell(imaginaryValueOrArgument) ,'Input value can''t be a cell')
                [roX, columnX] = size(realValueOrModulus);
                [roY, columnY] = size(imaginaryValueOrArgument);
                assert(roY == 1 && columnX == 1 && roX == 1 && columnY == 1, 'Input value can''t be marix')
                assert(imag(realValueOrModulus) == 0 && imag(imaginaryValueOrArgument) == 0, 'At least one of your input is complex number');
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
            modulus = sqrt(cmpxNum.realValue*cmpxNum.realValue + cmpxNum.imaginaryValue*cmpxNum.imaginaryValue);
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
            %% cmpxNum = 1/cmpxNum1
            cmpxNum = ComplexNumber(1,0)./cmpxNum1;
        end
        function plotComplexNumber(cmpxNum)
            [row, column] = size(cmpxNum);
            %% Cartesian coordinate system
            hold on
            figure(1)
            for i=1:row
                for j = 1:column
                    plot(cmpxNum(i,j).realValue,cmpxNum(i,j).imaginaryValue,'+','Color',[0.2 0.6 0.8],'DisplayName','Cartesian coordinates')
                    %% Polar coordinates
                end
            end
        end
    end
    %% function overload operators
    methods
        %% cmpxNum1 + cmpxNum2
        function cmpxNum = plus(cmpxNum1,cmpxNum2)
            % cmpxNum1 + cmpxNum2
            [rowCmpxNum1, columnCmpxNum1] = size(cmpxNum1);
            [rowCmpxNum2, columnCmpxNum2] = size(cmpxNum2);
            assert(rowCmpxNum1 == rowCmpxNum2 && columnCmpxNum1 == columnCmpxNum2, 'Size of matrix aren''t same')
            cmpxNum = zerosComplexNumber(rowCmpxNum1, columnCmpxNum1);
            for i = 1 :rowCmpxNum1
                for j = 1 : columnCmpxNum1
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
            %% via polar coordinates
            cmpxNum = ComplexNumber(cmpxNum1.modulus.*cmpxNum2.modulus,cmpxNum1.argument + cmpxNum2.argument,'polar');
            %% via Cartesian
            %cmpxNum.realValue = cmpxNum1.realValue*cmpxNum2.realValue - cmpxNum1.imaginaryValue*cmpxNum2.imaginaryValue;
            %cmpxNum.imaginaryValue = cmpxNum1.realValue*cmpxNum2.imaginaryValue + cmpxNum1.realValue*cmpxNum2.imaginaryValue;
        end
        %% cmpxNum1 ./ cmpxNum2
        function cmpxNum = rdivide(cmpxNum1, cmpxNum2)
            % cmpxNum1 ./ cmpxNum2
            assert(cmpxNum2.modulus >0, 'Can''t devide if secound input have real and imaginary value 0 ')
            %% via polar coordinates
            cmpxNum = ComplexNumber(cmpxNum1.modulus./cmpxNum2.modulus,cmpxNum1.argument-cmpxNum2.argument,'polar');
            %% via Cartesian
            %divisor = cmpxNum2.realValue * cmpxNum2.realValue + cmpxNum2.imaginaryValue * cmpxNum2.imaginaryValue;
            %assert(divisor >0, 'Can''t devide if secound input have real and imaginary value 0 ')
            %cmpxNum.realValue = (cmpxNum1.realValue*cmpxNum2.realValue + cmpxNum1.imaginaryValue * cmpxNum2.imaginaryValue)/divisor;
            %cmpxNum.imaginaryValue = (cmpxNum1.imaginaryValue*cmpxNum2.realValue - cmpxNum1.realValue * cmpxNum2.imaginaryValue)/divisor;
        end
        %% cmpxNum1 .\ cmpxNum2
        function cmpxNum = ldivide(cmpxNum1, cmpxNum2)
            % cmpxNum1 .\ cmpxNum2
            cmpxNum = rdivide(cmpxNum2,cmpxNum1); %%cmpxNum = cmpxNum2./cmpxNum1;
        end
        %% power(a,b)
        function cmpxNum = power(cmpxNum, realNumber)
            % a.^b b needs to be real number
            assert(isnumeric(realNumber), 'Inputs aren''t numeric');
            assert(~iscell(realNumber) ,'Input value can''t be a cell')
            [roX, columnX] = size(realNumber);
            assert(roX == 1 && columnX == 1, 'Input value can''t be marix')
            assert(imag(realNumber) == 0, 'One of your input is complex number');
            [rowCmpxNum, columnCmpxNum] = size(cmpxNum);
            for i = 1:rowCmpxNum
                for j = 1:columnCmpxNum
                    cmpxNum(i,j) = cmpxNum(i,j).convertPolarToCartesian(cmpxNum(i,j).modulus .^ realNumber,cmpxNum(i,j).argument .* realNumber);
                end
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
        function cmpxNum = ctranspose(cmpxNum)
            % cmpxNum'
            [row, column] = size(cmpxNum);
            for i = 1:row
                for j=1:column
                    cmpxNum(i,j).imaginaryValue = -cmpxNum(i,j).imaginaryValue;
                end
            end
        end
        %% cmpxNum1 == cmpxNum2
        function result = eq(cmpxNum1, cmpxNum2)
            % cmpxNum1 == cmpxNum2
            result = false;
            if(cmpxNum1.realValue == cmpxNum2.realValue && cmpxNum1.imaginaryValue == cmpxNum2.imaginaryValue)
                result = true;
            end
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
            % realValue = modulus * cos(argument)
            % imaginaryValue = modulus * sin(argument)
            cmpxNum = ComplexNumber(modulus * cos(argument),modulus * sin(argument));
        end
    end
end