%FCFWRITE  フィルタ係数ファイルを書き込み
%
%   FCFWRITE(H) は、フィルタ係数の ASCII-ファイルを書き込みます。H は、
%   single のフィルタオブジェクト、またはオブジェクトのベクトルになります。
%   ダイアログボックスがファイル名を入力するために表示されます。デフォルトの
%   ファイル名は、'untitled.fcf ' です。
%
%   Filter Design Toolbox がインストールされている場合、FCFWRITE(H) は、
%   マルチレートフィルタオブジェクト MFILT と適応フィルタオブジェクト 
%   ADAPTFILT に対するフィルタ係数ファイルを書き込むために使用することが
%   できます。
%
%   FCFWRITE(H,FILENAME) は、ファイルを現在の作業ディレクトリで FILENAME を
%   呼び出すディスクファイルに書き込みます。
%
%   FCFWRITE(...,FMT) は、FMT の書式で係数を書き込みます。有効な FMT 値は、
%   16 進数に対して 'hex'、10 進数に対して 'dec'、バイナリ表現に対して 
%   'bin' です。
%
%   まだ拡張子がない場合、拡張子 '.fcf ' が FILENAME に追加されます。
%
%   参考 DFILT/INFO, DFILT.


%   Copyright 1988-2007 The MathWorks, Inc.
