function c = getconstructor(this, stype)
%GETCONSTRUCTOR Get the constructor.

%   Copyright 2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/04/02 00:55:50 $

if nargin < 2
    stype = get(this, 'SpecificationType');
end

switch lower(stype)
    case 'fst,fp,ast,ap'
        %#function fspecs.hpisincmin
        c = 'fspecs.hpisincmin';
    case 'n,fc,ast,ap'
        %#function fspecs.hpisinccutoffwatten
        c = 'fspecs.hpisinccutoffwatten';
    case 'n,fp,ast,ap',
        %#function fspecs.hpisincpassastop
        c = 'fspecs.hpisincpassastop';
    case 'n,fst,fp'
        %#function fspecs.hpisinc
        c = 'fspecs.hpisinc';
    case 'n,fst,ast,ap',
        %#function fspecs.hpisincstopapass
        c = 'fspecs.hpisincstopapass';
end

% [EOF]
