classdef CDF< handle
%CDF    CDF computation engine for the measure package
%   H = comm.internal.CDF creates a System object H, that computes a
%   cumulative distribution function (CDF).
%
%   H = comm.internal.CDF(Name,Value) creates a CDF object H, with the
%   specified property Name set to the specified Value. You can specify
%   additional name-value pair arguments in any order as
%   (Name1,Value1,...,NameN,ValueN).
%
%   Step method syntax:
%
%   [CDFY,CDFX] = step(H,X) updates running histograms for each input
%   channel in the double precision data type matrix, X, and computes CDF
%   curves using the CDF object, H. Outputs CDFY and CDFX are updated y-axis
%   and x-axis CDF points for the real, double precision input data X. CDFY
%   and CDFX are matrices with each column containing CDF points for each
%   input channel.
%
%   CDF methods:
%
%   step     - Compute CDF (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create CDF object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of CDF object
%
%   CDF properties:
%
%   UpperLimit - Upper limit value of histogram bins
%   LowerLimit - Lower limit value of histogram bins
%   BinSize    - Size of histogram bins
%
%   See also comm.CCDF

 
%   Copyright 2008-2012 The MathWorks, Inc.

    methods
        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function resetImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
            % Get pre-calculated cdfx. 
        end

        function validateInputsImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %pBinEdges
        %   Store histogram bins. This is a matrix with the ith column containing
        %   a histogram bin vector for the ith input channel.
        pBinEdges;

        %pCDFX
        %   Matrix with each column containing X-axis CDF points for each input
        %   channel.
        pCDFX;

        %pDataHist
        %   Store persistent histogram data. This is a matrix with the ith column
        %   containing histogram data for the ith input channel.
        pDataHist;

    end
end
