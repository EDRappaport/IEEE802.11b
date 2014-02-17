function psd(this,varargin)
%PSD  Overloaded PSD method to produce a meaningful error message.

%   Author(s): P. Pacheco
%   Copyright 1988-2003 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $  $Date: 2010/12/06 00:12:00 $

error(message('signal:spectrum:music:psd:NotSupported', get( classhandle( this ), 'name' )));


