clear all; close all; clc

if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
end

DECLINATION = 6.167;
DECLINATION = deg2rad(DECLINATION);%convert to radians

s = serial('COM4'); %assigns the object s to serial port

set(s, 'FlowControl', 'none'); set(s, 'BaudRate', 115200); set(s, 'Parity', 'none'); set(s, 'DataBits', 8); set(s, 'StopBit', 1);
%set(s, 'Status', 'open');
%fopen(s)
clc; x=0; fopen(s)

% printGyro();  // Print "G: gx, gy, gz"
% printAccel(); // Print "A: ax, ay, az"
% printMag();   // Print "M: mx, my, mz"
    
%sensors = {'gyro: ', 'accel: ','mag: '};
magnetometer = {'mag_x: ', 'mag_y: ','mag_z: '};
%   //0 = pitch
%   //1 = roll
%   //2 = heading
j=1;


while(1)
%sensors{j};
serialString=fscanf(s);
finalLine = [magnetometer{j} serialString];
fprintf(finalLine,'%s')
%magArray(j)=str2double(serialString);
    if j < 3
        magArray(j)=fscanf(s,'%f')
        j = j + 1;
    else
        j = 1;
        heading = headingFunct(magArray,DECLINATION);
        fprintf('heading: %f\n',heading);
        fprintf('\n----------------------------\n','%s')
    end
    pause(.5);
end

function heading = headingFunct(magArray,declination)

    if magArray(2) == 0
        if magArray(1) < 0 
            heading = pi;
        else
            heading = 0;
        end
    else
        heading = atan2(magArray(1),magArray(2))
    end
  
    heading = declination*heading;
    
%   if heading > pi 
%       heading = heading - (2 * pi);
%   elseif heading < -pi 
%       heading = heading  + (2 * pi);
%   elseif heading < 0
%       heading = heading + (2 * pi);
%   end
  
    
   heading = rad2deg(heading);
end