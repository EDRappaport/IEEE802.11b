function data = generate(hWin)
%Generate(hWin) Generates the Taylor Window.
%
%   sigwin.taylorwin is not recommended.
%   Use <a href="matlab:help taylorwin">taylorwin</a> instead.

%   Copyright 2008-2012 The MathWorks, Inc.

data = taylorwin(hWin.Length, hWin.Nbar, -hWin.SidelobeLevel);


