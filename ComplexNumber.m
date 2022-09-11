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
            %% constructor
            if(nargin == 1)
                error('Input one more input argument')
            end
            if(nargin>0)
                assert(isnumeric(realValue) && isnumeric(imaginarimaginaryValue), 'one of your inputs aren''t numeric');
                assert(~iscell(realValue) || ~iscell(imaginarimaginaryValue) ,'input value can''t be a cell')
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
    end
    methods
        %% function overload operators
        function cmpxNum = plus(cmpxNum1,cmpxNum2)
            %% cmpxNum1 + cmpxNum2
            cmpxNum = ComplexNumber;
            cmpxNum.realValue = cmpxNum1.realValue + cmpxNum2.realValue;
            cmpxNum.imaginaryValue = cmpxNum1.imaginaryValue + cmpxNum2.imaginaryValue;
        end
        function cmpxNum = minus(cmpxNum1,cmpxNum2)
            %% cmpxNum1 - cmpxNum2
            cmpxNum = ComplexNumber;
            cmpxNum.realValue = cmpxNum1.realValue - cmpxNum2.realValue;
            cmpxNum.imaginaryValue = cmpxNum1.imaginaryValue - cmpxNum2.imaginaryValue;
        end
        function cmpxNum = times(cmpxNum1,cmpxNum2)
            %% cmpxNum1 .* cmpxNum2
            cmpxNum = ComplexNumber;
            cmpxNum.realValue = cmpxNum1.realValue*cmpxNum2.realValue - cmpxNum1.imaginaryValue*cmpxNum2.imaginaryValue;
            cmpxNum.imaginaryValue = cmpxNum1.realValue*cmpxNum2.imaginaryValue + cmpxNum1.realValue*cmpxNum2.imaginaryValue;
        end
        function cmpxNum = uminus(cmpxNum)
            %% -cmpxNum
            cmpxNum.realValue = -cmpxNum.realValue;
            cmpxNum.imaginaryValue = -cmpxNum.imaginaryValue;
        end
        function cmpxNum = ctranspose(cmpxNum)
            %% cmpxNum'
            cmpxNum.imaginaryValue = -cmpxNum.imaginaryValue;
        end
    end
end

