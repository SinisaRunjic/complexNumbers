classdef ComplexNumber
    properties
        realValue
        imaginaryValue
    end
    properties (Dependent)
        modulus
        argument %% in rad it goes from [-pi/2, pi/2)
    end
    methods
        function cmpxNum = ComplexNumber(realValue,imaginarimaginaryValue)
            %% Constructor
            if(nargin == 1)
                error('Input one more input argument')
            end
            if(nargin>0)
                assert(isnumeric(realValue) && isnumeric(imaginarimaginaryValue), 'one of your inputs aren''t numeric');
                assert(~iscell(realValue) || ~iscell(imaginarimaginaryValue) ,'input value can''t be a cell')
                assert(imag(realValue) == 0 && imag(imaginarimaginaryValue) == 0, 'At least one of your input is complex number');
                [roX, columnX] = size(realValue);
                [roY, columnY] = size(imaginarimaginaryValue);
                assert(roY == 1 && columnX == 1 && roX == 1 && columnY == 1, 'input value can''t be marix')
                cmpxNum.realValue = realValue;
                cmpxNum.imaginaryValue = imaginarimaginaryValue;
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
            argument =  cmpxNum.argument;
        end
        function cmpxNum = inverse(cmpxNum1)
            cmpxNum = ComplexNumber(1,0)./cmpxNum1;
        end
    end
    %% function overload operators
    methods
        %% cmpxNum1 + cmpxNum2
        function cmpxNum = plus(cmpxNum1,cmpxNum2)
            cmpxNum = ComplexNumber;
            cmpxNum.realValue = cmpxNum1.realValue + cmpxNum2.realValue;
            cmpxNum.imaginaryValue = cmpxNum1.imaginaryValue + cmpxNum2.imaginaryValue;
        end
        %% cmpxNum1 - cmpxNum2
        function cmpxNum = minus(cmpxNum1,cmpxNum2)
            cmpxNum = ComplexNumber;
            cmpxNum.realValue = cmpxNum1.realValue - cmpxNum2.realValue;
            cmpxNum.imaginaryValue = cmpxNum1.imaginaryValue - cmpxNum2.imaginaryValue;
        end
        %% cmpxNum1 .* cmpxNum2
        function cmpxNum = times(cmpxNum1,cmpxNum2)
            cmpxNum = ComplexNumber;
            cmpxNum.realValue = cmpxNum1.realValue*cmpxNum2.realValue - cmpxNum1.imaginaryValue*cmpxNum2.imaginaryValue;
            cmpxNum.imaginaryValue = cmpxNum1.realValue*cmpxNum2.imaginaryValue + cmpxNum1.realValue*cmpxNum2.imaginaryValue;
        end
        %% cmpxNum1 ./ cmpxNum2
        function cmpxNum = rdivide(cmpxNum1, cmpxNum2)
            cmpxNum = ComplexNumber;
            divisor = cmpxNum2.realValue * cmpxNum2.realValue + cmpxNum2.imaginaryValue * cmpxNum2.imaginaryValue;
            assert(divisor >0, 'Can''t devide if secound input have real and imaginary value 0 ')
            cmpxNum.realValue = (cmpxNum1.realValue*cmpxNum2.realValue + cmpxNum1.imaginaryValue * cmpxNum2.imaginaryValue)/divisor;
            cmpxNum.imaginaryValue = (cmpxNum1.imaginaryValue*cmpxNum2.realValue - cmpxNum1.realValue * cmpxNum2.imaginaryValue)/divisor;
            
        end
        %% cmpxNum1 .\ cmpxNum2
        function cmpxNum = ldivide(cmpxNum1, cmpxNum2)
            cmpxNum = rdivide(cmpxNum2,cmpxNum1); %%cmpxNum = cmpxNum2./cmpxNum1;
        end
        %% -cmpxNum
        function cmpxNum = uminus(cmpxNum)
            cmpxNum.realValue = -cmpxNum.realValue;
            cmpxNum.imaginaryValue = -cmpxNum.imaginaryValue;
        end
        %% cmpxNum'
        function cmpxNum = ctranspose(cmpxNum)
            cmpxNum.imaginaryValue = -cmpxNum.imaginaryValue;
        end
        %% cmpxNum1 == cmpxNum2
        function result = eq(cmpxNum1, cmpxNum2)
            result = false;
            if(cmpxNum1.realValue == cmpxNum2.realValue && cmpxNum1.imaginaryValue == cmpxNum2.imaginaryValue)
                result = true;
            end
        end
        %% cmpxNum1 ~= cmpxNum2
        function result = ne(cmpxNum1, cmpxNum2)
            result = ~(cmpxNum1 == cmpxNum2);
        end
    end
end

