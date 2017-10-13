a=arduino();
IMU = i2cdev(a,'0x70'); %1ST imu IN SC/SD0

writeRegister(a,register,dataIn,precision) %ex: writeRegister(dev,20,10,'uint16')

out = readRegister(dev,register,precision) %value = readRegister(dev,20,'uint16')

