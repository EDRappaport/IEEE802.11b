classdef Percentile< handle
%PERCENTILE Percentile computation engine for the measure package
%   H = comm.internal.Percentile creates a percentile System object H, that
%   computes percentile from a given CDF curve and a specified probability
%   value.
%
%   H = comm.internal.Percentile(Name,Value) creates a percentile System
%   object H, with the specified property Name set to the specified Value.
%
%   Step method syntax:
%
%   PTILE = step(H,CCDFy,CCDFx,PROB) obtains percentile points PTILE for
%   probability values specified in input PROB (probabilities expressed in
%   percentages) using the percentile System object, H. Input CCDFy must be
%   a double precision data type matrix with the ith column containing the
%   y-axis points of the CDF curve (probability values) for the ith input
%   channel. Input CDFx must be a double precision data type matrix with the
%   ith column containing the x-axis points of the CDF curve for the ith
%   input channel. Input PROB must contain double precision data type
%   probability values for which percentile points will be obtained. PROB
%   can be a scalar or a vector with as many elements as the current number
%   of input channels. If PROB is a scalar, percentile points for all input
%   channels are obtained for the same probability value. If PROB is a
%   vector, then the ith percentile point is obtained with respect to the
%   ith probability value in PROB. Output PTILE is a column vector with a
%   number of percentile points equal to the number of input channels. For
%   the ith channel, there is a probability PROB(i) that the signal being
%   analyzed (through a CDF curve) will take a value lower (if
%   ProbabilityCalculation = 'Lower tail') or higher (if
%   ProbabilityCalculation = 'Higher tail') than PTILE(i).
%
%   Percentile methods:
%
%   step     - Compute percentile (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create Percentile object with same property values
%   isLocked - Locked status (logical)
%   reset    - Reset states of Percentile object
%
%   Percentile properties:
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
