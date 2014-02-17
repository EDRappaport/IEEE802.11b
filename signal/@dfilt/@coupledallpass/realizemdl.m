function realizemdl(H,varargin)
%REALIZEMDL Filter realization (Simulink diagram).
%     REALIZEMDL(Hd) automatically generates architecture model of filter
%     Hd in a Simulink subsystem block using individual sum, gain, and
%     delay blocks, according to user-defined specifications.
%
%     REALIZEMDL(Hd, PARAMETER1, VALUE1, PARAMETER2, VALUE2, ...) generates
%     the model with parameter/value pairs.
%
%     See also DFILT/REALIZEMDL

%   Copyright 2009 The MathWorks, Inc.
%   $Revision: 1.1.6.8 $  $Date: 2009/05/23 08:14:14 $

super_realizemdl_composite(H,varargin{:});

% [EOF]
