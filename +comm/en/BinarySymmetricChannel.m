classdef BinarySymmetricChannel< handle
%BinarySymmetricChannel Introduce binary errors
%   H = comm.BinarySymmetricChannel creates a binary symmetric channel
%   System object, H. This object introduces binary errors to the input
%   signal with a prescribed probability.
%
%   H = comm.BinarySymmetricChannel(Name,Value) creates a binary symmetric
%   channel object, H, with the specified property Name set to the specified
%   Value. You can specify additional name-value pair arguments in any order
%   as (Name1,Value1,...,NameN,ValueN).
%
%   The binary symmetric channel object uses the default MATLAB random
%   stream. Reset the default stream for repeatable simulations. Type 'help
%   RandStream' for more information.
%
%   Step method syntax:
%
%   Y = step(H,X) adds binary errors to the input signal X and returns the
%   modified signal, Y. The input signal can be a vector or matrix with
%   numeric, logical, or fixed-point (fi objects) data type elements. The
%   step method output, Y, has the same dimensions as the input, X. If X
%   input contains a non-binary value, V, the object considers it to be 1
%   when abs(V) > 0. This syntax applies when you set the
%   ErrorVectorOutputPort property to false.
%
%   [Y,ERR] = step(H,X) returns the error signal vector, ERR. A value of 1
%   at the ith element of ERR indicates that an error was introduced at the
%   ith element of X. The outputs, Y and ERR, have the same dimensions as
%   the input, X. This syntax applies when you set the ErrorVectorOutputPort
%   property to true.
%
%   BinarySymmetricChannel methods:
%
%   step     - Introduce binary errors to input signal (see above)
%   release  - Allow property value and input characteristics changes
%   clone    - Create binary symmetric channel object with same property 
%              values
%   isLocked - Locked status (logical)
%
%   BinarySymmetricChannel properties:
%
%   ErrorProbability      - Probability of binary error
%   ErrorVectorOutputPort - Enable error vector output
%   OutputDataType        - Data type of output
%
%   % Example: 
%   %   Add binary errors with a probability of 0.2 to a binary input signal
%
%   H = comm.BinarySymmetricChannel('ErrorProbability',0.2);
%   data = randi([0 1], 10, 1);
%   [noisyData, err] = step(H, data);
%   [data noisyData err]
%
%   See also comm.AWGNChannel.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=BinarySymmetricChannel
            %BinarySymmetricChannel Introduce binary errors
            %   H = comm.BinarySymmetricChannel creates a binary symmetric channel
            %   System object, H. This object introduces binary errors to the input
            %   signal with a prescribed probability.
            %
            %   H = comm.BinarySymmetricChannel(Name,Value) creates a binary symmetric
            %   channel object, H, with the specified property Name set to the specified
            %   Value. You can specify additional name-value pair arguments in any order
            %   as (Name1,Value1,...,NameN,ValueN).
            %
            %   The binary symmetric channel object uses the default MATLAB random
            %   stream. Reset the default stream for repeatable simulations. Type 'help
            %   RandStream' for more information.
            %
            %   Step method syntax:
            %
            %   Y = step(H,X) adds binary errors to the input signal X and returns the
            %   modified signal, Y. The input signal can be a vector or matrix with
            %   numeric, logical, or fixed-point (fi objects) data type elements. The
            %   step method output, Y, has the same dimensions as the input, X. If X
            %   input contains a non-binary value, V, the object considers it to be 1
            %   when abs(V) > 0. This syntax applies when you set the
            %   ErrorVectorOutputPort property to false.
            %
            %   [Y,ERR] = step(H,X) returns the error signal vector, ERR. A value of 1
            %   at the ith element of ERR indicates that an error was introduced at the
            %   ith element of X. The outputs, Y and ERR, have the same dimensions as
            %   the input, X. This syntax applies when you set the ErrorVectorOutputPort
            %   property to true.
            %
            %   BinarySymmetricChannel methods:
            %
            %   step     - Introduce binary errors to input signal (see above)
            %   release  - Allow property value and input characteristics changes
            %   clone    - Create binary symmetric channel object with same property 
            %              values
            %   isLocked - Locked status (logical)
            %
            %   BinarySymmetricChannel properties:
            %
            %   ErrorProbability      - Probability of binary error
            %   ErrorVectorOutputPort - Enable error vector output
            %   OutputDataType        - Data type of output
            %
            %   % Example: 
            %   %   Add binary errors with a probability of 0.2 to a binary input signal
            %
            %   H = comm.BinarySymmetricChannel('ErrorProbability',0.2);
            %   data = randi([0 1], 10, 1);
            %   [noisyData, err] = step(H, data);
            %   [data noisyData err]
            %
            %   See also comm.AWGNChannel.
        end

        function getNumOutputsImpl(in) %#ok<MANU>
        end

        function isInputComplexityLockedImpl(in) %#ok<MANU>
        end

        function isInputSizeLockedImpl(in) %#ok<MANU>
        end

        function isOutputComplexityLockedImpl(in) %#ok<MANU>
        end

        function loadObjectImpl(in) %#ok<MANU>
        end

        function saveObjectImpl(in) %#ok<MANU>
        end

        function setupImpl(in) %#ok<MANU>
        end

        function stepImpl(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
    properties
        %ErrorProbability Probability of binary error
        %   Specify the probability of a binary error as a scalar with a value
        %   between 0 and 1. The default is 0.05.
        ErrorProbability;

        %ErrorVectorOutputPort Enable error vector output
        %   If you set this property to true, the step method outputs an error
        %   signal, ERR. This error signal is a vector that indicates where errors
        %   were introduced in the input signal, X. A value of 1 at the ith
        %   element of ERR indicates that an error was introduced at the ith
        %   element of X. Set the property to false if you do not want the ERR
        %   vector at the output of the step method. The default is true.
        ErrorVectorOutputPort;

        %OutputDataType Data type of output
        %   Specify output data type as one of 'double' | 'logical'. The default
        %   is 'double'.
        OutputDataType;

    end
end
