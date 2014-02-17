classdef IntegerRSDecoder< handle
%IntegerRSDecoder Integer Reed-Solomon decoder engine for the
%comm.RSDecoder public System object 
%   H = comm.internal.IntegerRSDecoder returns an integer Reed-Solomon
%   (RS) decoder, H, that performs RS decoding.
%
%   Step method syntax:
%
%   [Y ERR] = step(H, X) decodes the encoded integer data, X, into the
%   output vector integer Y and returns the number of corrected errors in
%   output vector ERR. This syntax is applicable when the
%   NumCorrectedErrorsOutputPort property is true.
%
%   Y = step(H, X) decodes the encoded data, X, into the output vector Y.
%   This syntax is applicable when the NumCorrectedErrorsOutputPort property
%   is false.
%
%   Y = step(H, X, ERASURES, ...) decodes the data, omitting the input
%   samples specified by the erasure binary column vector, ERASURES. The
%   elements in ERASURES must be of data type double or logical. This syntax
%   is applicable when the ErasuresInputPort property is set to true.
%
%   IntegerRSDecoder methods:
%
%   step - See above description for use of this method
%
%   IntegerRSDecoder properties:
%
%   CodewordLength               - Codeword length
%   MessageLength                - Message length
%   PuncturePatternSourceIndex   - Index of the puncture pattern source
%   PuncturePattern              - Puncture pattern vector
%   ErasuresInputPort            - Enable erasures input
%   NumCorrectedErrorsOutputPort - Output the number of corrected errors
%   DecoderParameters            - Decoder parameters
%
%   See also comm.RSDecoder.

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=IntegerRSDecoder
            %IntegerRSDecoder Integer Reed-Solomon decoder engine for the
            %comm.RSDecoder public System object 
            %   H = comm.internal.IntegerRSDecoder returns an integer Reed-Solomon
            %   (RS) decoder, H, that performs RS decoding.
            %
            %   Step method syntax:
            %
            %   [Y ERR] = step(H, X) decodes the encoded integer data, X, into the
            %   output vector integer Y and returns the number of corrected errors in
            %   output vector ERR. This syntax is applicable when the
            %   NumCorrectedErrorsOutputPort property is true.
            %
            %   Y = step(H, X) decodes the encoded data, X, into the output vector Y.
            %   This syntax is applicable when the NumCorrectedErrorsOutputPort property
            %   is false.
            %
            %   Y = step(H, X, ERASURES, ...) decodes the data, omitting the input
            %   samples specified by the erasure binary column vector, ERASURES. The
            %   elements in ERASURES must be of data type double or logical. This syntax
            %   is applicable when the ErasuresInputPort property is set to true.
            %
            %   IntegerRSDecoder methods:
            %
            %   step - See above description for use of this method
            %
            %   IntegerRSDecoder properties:
            %
            %   CodewordLength               - Codeword length
            %   MessageLength                - Message length
            %   PuncturePatternSourceIndex   - Index of the puncture pattern source
            %   PuncturePattern              - Puncture pattern vector
            %   ErasuresInputPort            - Enable erasures input
            %   NumCorrectedErrorsOutputPort - Output the number of corrected errors
            %   DecoderParameters            - Decoder parameters
            %
            %   See also comm.RSDecoder.
        end

        function setPortDataTypeConnections(in) %#ok<MANU>
        end

    end
    methods (Abstract)
    end
end
