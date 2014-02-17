classdef IntegerRSEncoder< handle
%IntegerRSEncoder Integer Reed-Solomon encoder engine for the
%comm.RSEncoder public System object. 
%   H = comm.internal.IntegerRSEncoder returns an integer Reed-Solomon
%   (RS) encoder, H, that performs RS encoding.
%
%   Step syntax:
%
%   Y = step(H, X) encodes integer input data, X, and returns the encoded
%   data in Y.
%
%   IntegerRSEncoder methods:
%
%   step - See above description for use of this method
%
%   IntegerRSEncoder properties:
%
%   CodewordLength             - Codeword length
%   MessageLength              - Message length
%   PuncturePatternSourceIndex - Index of the puncture pattern source
%   PuncturePattern            - Puncture pattern vector
%   EncoderParameters          - Encoder parameters
%
%   Copyright 2009-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $ $Date: 2012/06/13 08:49:45 $

 %   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=IntegerRSEncoder
            %IntegerRSEncoder Integer Reed-Solomon encoder engine for the
            %comm.RSEncoder public System object. 
            %   H = comm.internal.IntegerRSEncoder returns an integer Reed-Solomon
            %   (RS) encoder, H, that performs RS encoding.
            %
            %   Step syntax:
            %
            %   Y = step(H, X) encodes integer input data, X, and returns the encoded
            %   data in Y.
            %
            %   IntegerRSEncoder methods:
            %
            %   step - See above description for use of this method
            %
            %   IntegerRSEncoder properties:
            %
            %   CodewordLength             - Codeword length
            %   MessageLength              - Message length
            %   PuncturePatternSourceIndex - Index of the puncture pattern source
            %   PuncturePattern            - Puncture pattern vector
            %   EncoderParameters          - Encoder parameters
            %
            %   Copyright 2009-2012 The MathWorks, Inc.
            %   $Revision: 1.1.6.6 $ $Date: 2012/06/13 08:49:45 $
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
end
