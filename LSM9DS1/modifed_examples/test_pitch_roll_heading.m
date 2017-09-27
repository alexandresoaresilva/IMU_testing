clear all; close all; clc

if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
end

s = serial('COM4'); %assigns the object s to serial port

set(s, 'FlowControl', 'none'); set(s, 'BaudRate', 115200); set(s, 'Parity', 'none'); set(s, 'DataBits', 8); set(s, 'StopBit', 1);
%set(s, 'Status', 'open');
%fopen(s)
clc; x=0; fopen(s)

attitude = {'pitch: ', 'roll: ','heading: '};
%   //0 = pitch
%   //1 = roll
%   //2 = heading
j=1;


while(1)
attitude{j};
serialString=fscanf(s);
finalLine = [attitude{j} serialString];
fprintf(finalLine,'%s')
d=str2double(serialString);
pause(.5);
    if j < 3
        j = j + 1;
    else
        j = 1;
    end
end