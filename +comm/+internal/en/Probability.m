classdef Probability< handle
%PROBABILITY Probability computation engine for the measure package
%   H = comm.internal.Probability creates a probability System object H.
%   This object computes probability from a given CDF curve and a specified
%   percentile value.
%
%   H = comm.internal.Probability(Name,Value) creates a probability System
%   object H, with the specified property Name set to the specified Value.
%
%   Step method syntax:
%
%   PROB = step(H,CCDFy,CCDFx,PTILE) obtains probability points PROB for
%   given percentile values specified in the PTILE input using the
%   probability System object, H. Input CCDFy must be a double precision
%   data type matrix with the ith column containing the y-axis points of the
%   CDF curve (probability values) for the ith input channel. Input CDFx
%   must be a double precision data type matrix with the ith column
%   containing the x-axis points of the CDF curve for the ith input channel.
%   Input PTILE must contain double precision data type percentile values
%   for which probability points will be obtained. PTILE can be a scalar or
%   a vector with as many elements as the current number of input channels.
%   If PTILE is a scalar, probability points for all input channels are
%   obtained for the same percentile value. If PTILE is a vector, then the
%   ith probability point is obtained with respect to the ith percentile
%   value in PTILE. Output PROB is a column vector with a number of
%   probability points equal to the number of input channels. For the ith
%   channel, there is a probability PROB(i) that the signal being analyzed
%   (through a CDF curve) will take a value lower (if ProbabilityCalculation
%   = 'Lower tail') or higher (if ProbabilityCalculation = 'Higher tail')
%   than PTILE(i).
%
%   Probability methods:
%
%   step     - Compute probability (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Probability object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Probability object
%
%   Probability properties:
%
%   ProbabilityCalculation - Probability calculation 
%
%   See also comm.CCDF

 
%   Copyright 2008-2012 The MathWorks, Inc.

    methods
        function stepImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
end
