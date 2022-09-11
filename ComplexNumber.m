classdef ComplexNumber
    properties
        xValue
        yValue
    end
    properties (Dependent)
        modulus
        argument %% in rad
    end
    methods
        function cmpxNum = ComplexNumber(realPart,imaginaryPart)
            %% constructor
            if(nargin == 1)
                error('Input one more input argument')
            end
            if(nargin>0)
                assert(isnumeric(realPart) && isnumeric(imaginaryPart), 'one of your inputs aren''t numeric');
                assert(~iscell(realPart) && ~iscell(imaginaryPart) ,'input value can''t be a cell')
                [roX, columnX] = size(realPart);
                [roY, columnY] = size(imaginaryPart);
                assert(roY == 1 && columnX == 1 && roX == 1 && columnY == 1, 'input value can''t be marix')
                cmpxNum.xValue = realPart;
                cmpxNum.yValue = imaginaryPart;
            end
        end
        function modulus = get.modulus(cmpxNum)
            modulus = sqrt(cmpxNum.xValue*cmpxNum.xValue + cmpxNum.yValue*cmpxNum.yValue);
        end
        function cmpxNum = set.modulus(cmpxNum,~)
            error('You cannot set Modulus property');
        end
        function argument = get.argument(cmpxNum)
            argument = atan2(cmpxNum.yValue,cmpxNum.xValue);
        end
        function cmpxNum = set.argument(cmpxNum,~)
            error('You can''t set Argument property');
        end
        function [modulus,argument] = getPolarCoordinates(cmpxNum)
            modulus = cmpxNum.modulus;
            argument =  cmpxNum.argument;
        end
    end
    methods
        %% function overload
        function cmpxNum = plus(cmpxNum1,cmpxNum2)
            %% cmpxNum1 + cmpxNum2
            cmpxNum.xValue = cmpxNum1.xValue + cmpxNum2.xValue;
            cmpxNum.yValue = cmpxNum1.yValue + cmpxNum2.yValue;
        end
        function cmpxNum = minus(cmpxNum1,cmpxNum2)
            %% cmpxNum1 - cmpxNum2
            cmpxNum.xValue = cmpxNum1.xValue - cmpxNum2.xValue;
            cmpxNum.yValue = cmpxNum1.yValue - cmpxNum2.yValue;
        end
        function cmpxNum = times(cmpxNum1,cmpxNum2)
            %% cmpxNum1 .* cmpxNum2
            cmpxNum.xValue = cmpxNum1.xValue*cmpxNum2.xValue - cmpxNum1.yValue*cmpxNum2.yValue;
            cmpxNum.yValue = cmpxNum1.xValue*cmpxNum2.yValue + cmpxNum1.xValue*cmpxNum2.yValue;
        end
        function cmpxNum = uminus(cmpxNum)
            %% -cmpxNum
            cmpxNum.xValue = -cmpxNum.xValue;
            cmpxNum.yValue = -cmpxNum.yValue;
        end
        function cmpxNum = ctranspose(cmpxNum)
            %% cmpxNum'
            cmpxNum.yValue = -cmpxNum.yValue;
        end
    end
end

