function [h,delta,result] = cremez(M, edges, filt_str, varargin)
%CREMEZ Complex and nonlinear phase equiripple FIR filter design.
%   CREMEZ is obsolete.  CREMEZ still works but may be removed in the future.
%   Use CFIRPM instead.
%
%   See also CFIRPM.

%   Authors: L. Karam, J. McClellan
%   Revised: October 1996, D. Orofino
%
%   Copyright 1988-2004 The MathWorks, Inc.
%   $Revision: 1.7.4.5 $  $Date: 2010/12/06 00:01:33 $

% NOTE: This algorithm is equivalent to Remez for real B
%       when the filter specs are exactly linear phase.

if nargin<3, error(message('signal:cremez:Nargchk')); end

[h,delta,result] = cfirpm(M, edges, filt_str, varargin{:});

% [EOF]
