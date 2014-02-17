classdef MatrixHelicalScanInterleaverBase< handle
%MatrixHelicalScanInterleaverBase Base class for matrix helical scan
%interleavers

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=MatrixHelicalScanInterleaverBase
            %MatrixHelicalScanInterleaverBase Base class for matrix helical scan
            %interleavers
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %NumColumns Number of permutation matrix columns 
        %   Specify the number of columns in the permutation matrix as a scalar,
        %   positive integer. The default is 64.
        NumColumns;

        %NumRows  Number of permutation matrix rows 
        %   Specify the number of rows in the permutation matrix as a scalar,
        %   positive integer. The default is 64.
        NumRows;

        %StepSize Slope of diagonals
        %   Specify slope as a scalar integer between 0 and the value you specify
        %   in the NumRows property. The slope value is the amount by which the
        %   row index increases as the column index increases by 1. When you set
        %   the value of this property to 0, the object does not interleave and
        %   the output matches the input. The default is 1.
        StepSize;

        %pIsDeinterleaver Private property to distinguish interleaver/deinterleaver
        pIsDeinterleaver;

    end
end
