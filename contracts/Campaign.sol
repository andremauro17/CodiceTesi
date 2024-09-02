// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;



contract Campaign {
    string nome;
    int256 lat;
    int256 lng;
   
    struct device{
        address addressDevice;
        int256 rank;
        bool status;

    }

    device[] public devices;
    device[] public deviceTop;

    constructor(string memory nomeC, int256 latC, int256 lngC) {
        nome = nomeC;
        lat = latC;
        lng = lngC;
    }

    function AddDevice(address addressD,int256 rankD,bool statusD) public{
        device memory newDevice = device({
        addressDevice: addressD,
        rank: rankD,
        status : statusD
    });

    devices.push(newDevice);
    OrdinaDevice();
    }

    function OrdinaDevice() public {
        for(uint256 i = 0;i<devices.length -1;i++){
            for(uint256 j = 0;j<devices.length - i-1;j++){
                if(devices[j].rank < devices[j+1].rank ){
                    device memory temp = devices[j];
                    devices[j] = devices[j+1];
                    devices[j+1] = temp;
                }
            }
        }



    }

    

    function AddDeviceTop() public{
        if(devices.length <= 10) {
            for(uint256 i = 0;i<devices.length;i++){
                deviceTop.push(devices[i]);
            }
        } else{
            for(uint256 i = 0;i<10;i++){
                if(devices[i].status == true){
                    deviceTop.push(devices[i]);
                }
            }
            if(deviceTop.length == 0){
                uint256 resto = devices.length < 20 ? devices.length - 10 : 10;
                for(uint256 j = 0;j<resto;j++){
                    deviceTop.push(devices[10 + j]);
                }
            }
        }
    }

    function getDeviceCount() public view returns (uint256) {
        return devices.length;
    }

    function getDeviceTopCount() public view returns (uint256) {
        return deviceTop.length;
    }

    function getDevice() public view returns (device[] memory){
        return devices;
    }

    function getDeviceTop() public view returns (device[] memory){
        return deviceTop;
    }

    function setStatus() public {
        for(uint256 i = 0;i<10;i++){
            devices[i].status = false;
        }
    }

}