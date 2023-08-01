//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

contract Registry {
    address public houseowner;
    address public tenant;
    string[] public infoArray_T;
    string[] public infoArray_A;
    string[] public infoArray_B;
    mapping(uint256 => string) public keyNameMap_T;
    mapping(uint256 => string) public keyNameMap_A;
    mapping(uint256 => string) public keyNameMap_B;

    constructor() {
 infoArray_T.push("1135010500307400000");
 infoArray_T.push("20230801");
 infoArray_T.push("apart");
 infoArray_T.push("1111");
 infoArray_T.push("aparthaha");
 infoArray_T.push("land");
 infoArray_T.push("33");
 infoArray_T.push("1234");
 infoArray_T.push("owner");
 infoArray_T.push("11");
 infoArray_T.push("move");


 infoArray_A.push("moving");
 infoArray_A.push("20230801");
 infoArray_A.push("nothing");


 infoArray_B.push("moving");
 infoArray_B.push("20230801");
 infoArray_B.push("moving");
 infoArray_B.push("nothing");
   
        
        keyNameMap_T[0] = "uniqueNum";
        keyNameMap_T[1] = "receiptDate1";
        keyNameMap_T[2] = "congregateBuilding";
        keyNameMap_T[3] = "locationNum";
        keyNameMap_T[4] = "buildingStatement";
        keyNameMap_T[5] = "landCategory";
        keyNameMap_T[6] = "area";
        keyNameMap_T[7] = "buildingNum";
        keyNameMap_T[8] = "typesOfLandRights";
        keyNameMap_T[9] = "landRightsRatio";
        keyNameMap_T[10] = "registrationCauseAndOtherMatters";
  

        keyNameMap_A[0] = "registrationPurpose1";
        keyNameMap_A[1] = "receiptDate2";
        keyNameMap_A[2] = "rightsHoldersAndOtherMatters1";

        keyNameMap_B[0] = "registrationPurpose2";
        keyNameMap_B[1] = "receiptDate3";
        keyNameMap_B[2] = "registrationCause";
        keyNameMap_B[3] = "rightsHoldersAndOtherMatters2";
    }
    
    function getstores_T() public view returns (string[] memory) {
        return infoArray_T;
    }

    function getstores_A() public view returns (string[] memory) {
        return infoArray_A;
    }

    function getstores_B() public view returns (string[] memory) {
        return infoArray_B;
    }

    function getstore_T(uint256 index) public view returns (string memory){
        return infoArray_T[index];
    }

    function getstore_A(uint256 index) public view returns (string memory){
        return infoArray_A[index];
    }

    function getstore_B(uint256 index) public view returns (string memory){
        return infoArray_B[index];
    }
}