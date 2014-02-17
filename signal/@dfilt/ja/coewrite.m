%COEWRITE  XILINX CORE Generator(tm) 係数 (.COE) ファイルを書き込み
%
%   COEWRITE(Hd) は、XILINX CORE Generator に読み込むことのできる XILINX 
%   Distributed Arithmetic FIR フィルタ係数の .COE ファイルを書き込みます。
%   係数は、固定小数点 DFILT フィルタオブジェクト Hd から抽出されます。
%   ダイアログボックスがファイル名を入力するために表示されます。デフォルトの
%   ファイル名は、'untitled.coe' です。
%
%   COEWRITE(Hd,RADIX) は、FIR フィルタ係数を指定するために使われる基数 
%   (数ベース) を示します。有効な RADIX 値は、2, 10, 16 (デフォルト) です。
%
%   COEWRITE(...,FILENAME) は、XILINX .COE ファイルを FILENAME を呼び出す
%   ディスクファイルに書き込みます。
%
%   まだ拡張子がない場合、拡張子 '.coe' が FILENAME に追加されます。
%
%   例:
%   b = firceqrip(30,0.4,[0.05 0.03]);
%   Hd = dfilt.dffir(b);
%   Hd.arithmetic = 'fixed'; % Fixed-Point Designer が必要
%   coewrite(Hd,10,'mycoefile');
%
%   参考 COEREAD.


%   Copyright 1988-2007 The MathWorks, Inc.
