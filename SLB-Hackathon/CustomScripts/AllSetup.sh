cd ~

# upgrate the repository and upgrade the existing components
sudo apt-get update -y
sudo apt-get upgrade -y

# configure CMAKE
sudo apt-get install -y build-essential
wget https://cmake.org/files/v3.8/cmake-3.8.0.tar.gz
tar xf cmake-3.8.0.tar.gz
cd cmake-3.8.0
./configure
make


# setup the required environment variables
echo "PATH=$PATH:~/cmake-3.8.0/bin" | sudo tee --append /etc/environment
echo "export NODE_INCLUDE=~/repos/azure-iot-gateway-sdk/build_nodejs/dist/inc" | sudo tee --append /etc/environment
echo "export NODE_LIB=~/repos/azure-iot-gateway-sdk/build_nodejs/dist/lib" | sudo tee --append /etc/environment
source /etc/environment

# setup the required build tools
sudo apt-get install -y curl libcurl4-openssl-dev git libssl-dev uuid-dev valgrind libglib2.0-dev libtool autoconf

# setup NODE.JS
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash
sudo apt-get install -y nodejs

# clone the gateway repository
cd ~
mkdir repos
cd repos
git clone https://github.com/Azure/azure-iot-gateway-sdk.git

# build the gateway core 
cd ~/repos/azure-iot-gateway-sdk/tools
./build_nodejs.sh
./build.sh --enable-nodejs-binding

########################################
# ModbusSetup
########################################
source ~/.profile

cd ~/repos
git clone https://github.com/Azure/iot-gateway-modbus.git
cd iot-gateway-modbus/modules

cp -R ~/repos/iot-gateway-modbus/modules/modbus_read ~/repos/azure-iot-gateway-sdk/modules/modbus_read/
cp -R ~/repos/iot-gateway-modbus/samples/modbus_sample ~/repos/azure-iot-gateway-sdk/samples/modbus_sample/

echo "add_subdirectory(modbus_read)" >> ~/repos/azure-iot-gateway-sdk/modules/CMakeLists.txt
echo "add_subdirectory(modbus_sample)" >> ~/repos/azure-iot-gateway-sdk/samples/CMakeLists.txt

cd ~/repos/azure-iot-gateway-sdk/tools
./build.sh --enable-nodejs-binding

exit 0




