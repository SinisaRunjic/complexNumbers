classdef ComplexNumberClassTest < matlab.unittest.TestCase
    %ComplexNumberClassTest is test class for ComplexNumber class
    %
    properties (TestParameter) %% parameters that will be used in test methods
        complexNumber = struct('complexNumber1',struct('realPart',3,'imaginaryPart',3,'modulus',3*sqrt(2),'argument',pi/4),...
            'complexNumber2',struct('realPart',3,'imaginaryPart',-3,'modulus',3*sqrt(2),'argument',-pi/4),...
            'complexNumber3',struct('realPart',-3,'imaginaryPart',3,'modulus',3*sqrt(2),'argument',3*pi/4),...
            'complexNumber4',struct('realPart',-3,'imaginaryPart',-3,'modulus',3*sqrt(2),'argument',-3*pi/4));
        %% variables design or verify errors
        complexNumberRealPartVector = struct('complexNumber1',struct('realPart',[3,3],'imaginaryPart',3));
        complexNumberImaginaryPartVector = struct('complexNumber1',struct('realPart',3,'imaginaryPart',[3, 3]));
        complexNumberRealPartEmpty = struct('complexNumber1',struct('realPart',[],'imaginaryPart',3));
        complexNumberImaginaryPartEmpty = struct('complexNumber1',struct('realPart',3,'imaginaryPart',[]));
        complexNumberRealPartCell = struct('complexNumber1',struct('realPart',{{3}},'imaginaryPart',3));
        complexNumberImaginaryPartCell = struct('complexNumber1',struct('realPart',3,'imaginaryPart',{{3}}));
        complexNumberRealPartString = struct('complexNumber1',struct('realPart','3','imaginaryPart',3));
        complexNumberImaginaryPartString = struct('complexNumber1',struct('realPart',3,'imaginaryPart','3'));
    end
    properties
        calculationError
    end
    methods(TestClassSetup) %% runs when test class is about to close
        function setupOnce(testCase)
            format long
            testCase.calculationError = 10^(-12);
        end
    end
    methods(TestClassTeardown) %% runs when test class is about to close
        function teardownOnce(testCase)
            format short
        end
    end
    %% test values
    methods (Test, ParameterCombination = 'sequential')
        function testConstructor(testCase, complexNumber)
            actualSolution = ComplexNumber(complexNumber.realPart, complexNumber.imaginaryPart);
            expectedRealSolution = complexNumber.realPart;
            expectedImaginaryPart = complexNumber.imaginaryPart;
            verifyLessThan(testCase,max(abs([actualSolution.realValue - expectedRealSolution, actualSolution.imaginaryValue - expectedImaginaryPart])),testCase.calculationError, 'Constrct is wrong');
        end
        function testModulus(testCase, complexNumber)
            actualSolution = ComplexNumber(complexNumber.realPart, complexNumber.imaginaryPart).modulus;
            expectedSolution = complexNumber.modulus;
            verifyLessThan(testCase,abs(actualSolution - expectedSolution),testCase.calculationError, 'Modulus is wrong');
        end
        function testArgument(testCase, complexNumber)
            actualSoltion = ComplexNumber(complexNumber.realPart, complexNumber.imaginaryPart).argument;
            expectedSolution = complexNumber.argument;
            verifyLessThan(testCase,abs(actualSoltion - expectedSolution),testCase.calculationError, 'Argument is wrong');
        end
        %% tests for OVERORD OPERATORS
        function testPlus(testCase, complexNumber)
            actualSolution = ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart) + ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart);
            expectedRealSoltion = complexNumber.realPart + complexNumber.realPart;
            expectedImaginarySoltion = complexNumber.imaginaryPart + complexNumber.imaginaryPart;
            verifyLessThan(testCase,max(abs([actualSolution.realValue - expectedRealSoltion, actualSolution.imaginaryValue - expectedImaginarySoltion])),testCase.calculationError, 'Overload operator + (plus) is wrong');
        end
        function testMinus(testCase, complexNumber)
            actualSolution = ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart) + ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart);
            expectedRealSoltion = complexNumber.realPart + complexNumber.realPart;
            expectedImaginarySoltion = complexNumber.imaginaryPart + complexNumber.imaginaryPart;
            verifyLessThan(testCase,max(abs([actualSolution.realValue - expectedRealSoltion, actualSolution.imaginaryValue - expectedImaginarySoltion])),testCase.calculationError, 'Overload operator - (minus) is wrong');
        end
        function testTimes(testCase, complexNumber)
            actualSolution = ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart) .* ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart);
            expectedSoltion = (complexNumber.realPart + complexNumber.imaginaryPart*1i)*(complexNumber.realPart + complexNumber.imaginaryPart*1i);
            verifyLessThan(testCase,max(abs([actualSolution.realValue - real(expectedSoltion), actualSolution.imaginaryValue - imag(expectedSoltion)])),testCase.calculationError, 'Overload operator .* (times) is wrong');
        end
        function testUminus(testCase, complexNumber)
            actualSolution = -ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart);
            expectedSoltion = -(complexNumber.realPart + complexNumber.imaginaryPart*1i);
            verifyLessThan(testCase,max(abs([actualSolution.realValue - real(expectedSoltion), actualSolution.imaginaryValue - imag(expectedSoltion)])),testCase.calculationError, 'Overload operator -a (uminus) is wrong');
        end
        function testCtranspose(testCase, complexNumber)
            actualSolution = ComplexNumber(complexNumber.realPart,complexNumber.imaginaryPart)';
            expectedSoltion = (complexNumber.realPart - complexNumber.imaginaryPart*1i);
            verifyLessThan(testCase,max(abs([actualSolution.realValue - real(expectedSoltion), actualSolution.imaginaryValue - imag(expectedSoltion)])),testCase.calculationError, 'Overload operator a'' (ctranspose) is wrong');
        end
    end
    %% test for errors
    methods (Test)
        function testComplexNumberRealPartVector(testCase, complexNumberRealPartVector)
            verifyError(testCase,@() ComplexNumber(complexNumberRealPartVector.realPart,complexNumberRealPartVector.imaginaryPart),?MException, 'Can''t have complex number if real number is vector')
        end
        function testComplexNumberImaginaryPartVector(testCase, complexNumberImaginaryPartVector)
            verifyError(testCase,@() ComplexNumber(complexNumberImaginaryPartVector.realPart,complexNumberImaginaryPartVector.imaginaryPart),?MException, 'Can''t have complex number if real number is vector')
        end
        function testComplexNumberRealPartEmpty(testCase, complexNumberRealPartEmpty)
            verifyError(testCase,@() ComplexNumber(complexNumberRealPartEmpty.realPart,complexNumberRealPartEmpty.imaginaryPart),?MException, 'Can''t have complex number if real number is []')
        end
        function testComplexNumberImaginaryPartEmpty(testCase, complexNumberImaginaryPartEmpty)
            verifyError(testCase,@() ComplexNumber(complexNumberImaginaryPartEmpty.realPart,complexNumberImaginaryPartEmpty.imaginaryPart),?MException, 'Can''t have complex number if imaginary number is []')
        end
        function testComplexNumberRealPartCell(testCase, complexNumberRealPartCell)
            verifyError(testCase,@() ComplexNumber(complexNumberRealPartCell.realPart,complexNumberRealPartCell.imaginaryPart),?MException, 'Can''t have complex number if real value is cell')
        end
        function testComplexNumberImaginaryPartCell(testCase, complexNumberImaginaryPartCell)
            verifyError(testCase,@() ComplexNumber(complexNumberImaginaryPartCell.realPart,complexNumberImaginaryPartCell.imaginaryPart),?MException, 'Can''t have complex number if imaginary value is {}')
        end
        function testComplexNumberRealPartString(testCase, complexNumberRealPartString)
            verifyError(testCase,@() ComplexNumber(complexNumberRealPartString.realPart,complexNumberRealPartString.imaginaryPart),?MException, 'Can''t have complex number if imaginary value is string')
        end
        function testComplexNumberImaginaryPartString(testCase, complexNumberImaginaryPartString)
            verifyError(testCase,@() ComplexNumber(complexNumberImaginaryPartString.realPart,complexNumberImaginaryPartString.imaginaryPart),?MException, 'Can''t have complex number if imaginary value is string')
        end
    end
end

