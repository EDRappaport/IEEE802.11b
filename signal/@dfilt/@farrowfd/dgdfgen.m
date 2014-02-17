function DGDF = dgdfgen(Hd,hTar,doMapCoeffsToPorts)
%DGDFGEN generate the dg_dfilt structure from a specified filter structure
%Hd.

%   Author(s): Honglei Chen
%   Copyright 1988-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2009/07/14 04:02:04 $


DGDF=fddggen(Hd.filterquantizer,Hd,hTar.coeffnames,doMapCoeffsToPorts,hTar.privStates);

