classdef ConstellationBase< handle
%ConstellationBase Base class for Modulation objects to calculate 
% and view the constellation

     
%   Copyright 2012 The MathWorks, Inc.

    methods
        function out=ConstellationBase
            %ConstellationBase Base class for Modulation objects to calculate 
            % and view the constellation
        end

        function constellation(in) %#ok<MANU>
            %CONSTELLATION  Calculate the ideal signal constellation
            %
            %   y = constellation(OBJ) returns the numerical values of the constellation.
            %
            %   constellation(OBJ) generates a constellation plot.
            %
        end

    end
    methods (Abstract)
    end
end
