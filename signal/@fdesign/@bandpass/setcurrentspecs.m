function newspecs = setcurrentspecs(this, newspecs)
%SETCURRENTSPECS Pre-Set function for the current specs.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:55:24 $

% Check out DSP System Toolbox license if necessary
checkoutfdtbxlicense(this);

% This should be private.
oldspecs = get(this, 'CurrentSpecs');

% Remove the properties of the old specs object.
rmprops(this, oldspecs);

if isempty(newspecs)
    return;
end

syncspecs(this, newspecs);

% Add the properties of the new specs object.
addprops(this, newspecs);

% Install a listener on the privConstraints property to create dynamic
% properties for the ripple and attenuation specs in constrained designs.
l = handle.listener(newspecs, newspecs.findprop('privConstraints'), ...
    'PropertyPostSet', @constraint_listener);
set(l, 'CallbackTarget', this);
set(this, 'ConstraintListener', l);

% --------------------------------------------------
function constraint_listener(this, eventData)

hfspecs = get(eventData, 'AffectedObject');
send(this, 'FaceChanging');
%Remove all ripple specs
rmprops(this,'Astop1','Astop2','Apass');

%Add only required ripple specs
propNames = {};
if hfspecs.Stopband1Constrained
  propNames{end+1} = 'Astop1';
end
if hfspecs.Stopband2Constrained
  propNames{end+1} = 'Astop2';
end
if hfspecs.PassbandConstrained
  propNames{end+1} = 'Apass';
end  

if ~isempty(propNames)
  addprops(this, hfspecs,propNames{:});
end
send(this, 'FaceChanged');


% [EOF]