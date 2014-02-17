function this = multibandarbgrpdelay(varargin)
%MULTIBANDARBGRPDELAY Construct a MULTIBANDARBGRPDELAY object.

%   Copyright 2010 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2010/12/27 01:21:03 $

this = fspecs.multibandarbgrpdelay;
this.B1Frequencies = 0.0:0.01:0.3;
this.B2Frequencies = 0.8:0.01:1;
this.B1GroupDelay = 9.41-[...
  0.2682    0.2686    0.2698    0.2718    0.2746    0.2784    0.2831...
  0.2888    0.2957    0.3039    0.3135    0.3247    0.3379    0.3532...
  0.3713    0.3925    0.4177    0.4477    0.4839    0.5279    0.5823...
  0.6505    0.7378    0.8522    1.0063    1.2210    1.5333    2.0117...
  2.7937    4.1766    6.8314];

this.B2GroupDelay = 9.41-[...
  9.4026    4.9336    3.0242    2.0786    1.5488    1.2233    1.0091...
  0.8606    0.7533    0.6734    0.6125    0.5652    0.5281    0.4988...
  0.4757    0.4575    0.4436    0.4332    0.4261    0.4219    0.4206];

respstr = 'Multi-Band Arbitrary Group Delay';
fstart = 1;
fstop = 1;
nargsnoFs = 2;
fsconstructor(this,respstr,fstart,fstop,nargsnoFs,varargin{:});
% [EOF]
