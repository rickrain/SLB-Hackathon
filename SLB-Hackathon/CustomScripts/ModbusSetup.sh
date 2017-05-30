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
