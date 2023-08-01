//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

contract BuildingRegistry {
    address public houseowner;
    address public tenant;
    string[] public buildingArray;
    mapping(uint256 => string) public keyNameMap;

    constructor() {
 buildingArray.push("1135010500307400000");
    buildingArray.push("2022072780578331");
    buildingArray.push("85, Dongil-ro 227-gil, Nowon-gu, Seoul, Republic of Korea"); // 상계주공아파트 209동
    buildingArray.push("85, Dongil-ro 227-gil, Nowon-gu, Seoul, Republic of Korea");
    buildingArray.push("740");
    buildingArray.push("85, Dongil-ro 227-gil, Nowon-gu, Seoul, Republic of Korea");
    buildingArray.push("partOfExclusiveOwnership");
    buildingArray.push("commonsector");
    buildingArray.push("Gil-dong");
    buildingArray.push("0000001111111");
    buildingArray.push("Nowon-gu,Seoul");
    buildingArray.push("20120416");
    buildingArray.push("change");
    buildingArray.push("true");
        
        keyNameMap[0] = "uniqueNum";
        keyNameMap[1] = "receiptNum";
        keyNameMap[2] = "buildingAndUnitName";
        keyNameMap[3] = "location";
        keyNameMap[4] = "landLotNum";
        keyNameMap[5] = "roadNameAddress";
        keyNameMap[6] = "partOfExclusiveOwnership";
        keyNameMap[7] = "commonSector";
        keyNameMap[8] = "houseowner";
        keyNameMap[9] = "residentRegisterationNum";
        keyNameMap[10] = "buildingAddress";
        keyNameMap[11] = "changeDate";
        keyNameMap[12] = "changeCause";
        keyNameMap[13] = "isVerified";


    }
    
    function getstores() public view returns (string[] memory) {
        return buildingArray;
    }

    function getstore(uint256 index) public view returns (string memory){
        return buildingArray[index];
    }
}

