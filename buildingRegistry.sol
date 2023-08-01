//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

contract BuildingRegistry {
    address public houseowner;
    address public tenant;
    mapping(address => bool) public authorizedTenants;

    struct Building {
        uint256 uniqueNum;
        uint256 receiptNum;
        string buildingAndUnitName;
        string location;
        uint256 landLotNum;
        string roadNameAddress;
        string partOfExclusiveOwnership;
        // string commonSector;
        // address houseowner;
        // uint256 residentRegisterationNum;
        // string buildingAddress;
        // uint256 changeDate;
        // string changeCause;
        // bool isVerified;
    }

    Building public buildingData;

    
  
    modifier onlyOwner() {
        require(msg.sender == houseowner, "Only the owner can access this.");
        _;
    }

    modifier onlyAuthorized() {
        require(
            msg.sender == houseowner || authorizedTenants[msg.sender],
            "Only the owner or authorized tenant can access this."
        );
        _;
    }

    constructor(
        uint256 _uniqueNum,
        uint256 _receiptNum,
        string memory _buildingAndUnitName,
        string memory _location,
        uint256 _landLotNum,
        string memory _roadNameAddress,
        string memory _partOfExclusiveOwnership
        // string memory _commonSector,
        // address _houseowner,
        // uint256 _residentRegisterationNum,
        // string memory _buildingAddress,
        // uint256 _changeDate,
        // string memory _changeCause,
        // bool _isVerified
    ) {
        houseowner = msg.sender;
        // tenant=msg.sender;
        authorizedTenants[msg.sender] = true;
        buildingData=Building(
         _uniqueNum,
         _receiptNum,
        _buildingAndUnitName,
        _location,
        _landLotNum,
        _roadNameAddress,
        _partOfExclusiveOwnership
        // _commonSector,
        // _houseowner,
        // _residentRegisterationNum,
        // _buildingAddress,
        //  _changeDate,
        // _changeCause,
        // _isVerified  
        );
    }

    function getUniqueNum() public view returns (uint256) {
        return buildingData.uniqueNum;
    }

    function getReceiptNum() public view returns (uint256) {
        return buildingData.receiptNum;
    }

    function getBuildingAndUnitName() public view returns (string memory) {
        return buildingData.buildingAndUnitName;
    }

    function getLocation() public view returns (string memory) {
        return buildingData.location;
    }

    function getLandLotNum() public view returns (uint256) {
        return buildingData.landLotNum;
    }

    function getRoadNameAddress() public view returns (string memory) {
        return buildingData.roadNameAddress;
    }

    function getPartOfExclusiveOwnership() public view returns (string memory) {
        return buildingData.partOfExclusiveOwnership;
    }

    // function getCommonSector() public view returns (string memory) {
    //     return buildingData.commonSector;
    // }

    // function getHouseowner() public view returns (address) {
    //     return buildingData.houseowner;
    // }

    // function getResidentRegisterationNum() public view returns (uint256) {
    //     return buildingData.residentRegisterationNum;
    // }

    // function getBuildingAddress() public view returns (string memory) {
    //     return buildingData.buildingAddress;
    // }

    // function getChangeDate() public view returns (uint256) {
    //     return buildingData.changeDate;
    // }

    // function getChangeCause() public view returns (string memory) {
    //     return buildingData.changeCause;
    // }

    // function getIsVerified() public view returns (bool) {
    //     return buildingData.isVerified;
    // }
}
