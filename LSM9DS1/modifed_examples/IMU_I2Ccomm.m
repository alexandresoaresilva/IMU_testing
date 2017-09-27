%script to control IMU from Matlab
clc, clear;

%use arduinosetup() function for uploading libraries to Arduino
a=arduino();
I2Caddress = scanI2CBus(a)
IMUmagnet = i2cdev(a,I2Caddress{1});
IMUaccelGyro = i2cdev(a,I2Caddress{2});

%figure out