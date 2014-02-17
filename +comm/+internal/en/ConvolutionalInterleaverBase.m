classdef ConvolutionalInterleaverBase< handle
%ConvolutionalInterleaverBase Base class for convolutional interleavers
%
%   See also comm.ConvolutionalInterleaver, comm.ConvolutionalDeinterleaver. 

 
%   Copyright 2009-2012 The MathWorks, Inc.

    methods
        function out=ConvolutionalInterleaverBase
            %ConvolutionalInterleaverBase Base class for convolutional interleavers
            %
            %   See also comm.ConvolutionalInterleaver, comm.ConvolutionalDeinterleaver. 
        end

    end
    methods (Abstract)
    end
    properties
        %NumRegisters  Number of internal shift registers
        %   Specify the number of internal shift registers as a scalar, positive
        %   integer. The default is 6.
        NumRegisters;

        %pIsInterleaver Private property to distinguish interleaver/deinterleaver
        pIsInterleaver;

    end
end
