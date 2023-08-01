//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Registry {
    address public houseowner;
    address public tenant;
    mapping(address => bool) public authorizedTenants;

    struct partOfTitle {
        uint256 uniqueNum;
        uint256 receiptDate1;
        string congregateBuilding;
        uint256 locationNum;
        string buildingStatement;
        string landCategory;
        uint256 area;
        uint256 buildingNum;
        string typesOfLandRights;
        uint256 landRightsRatio;
        string registrationCauseAndOtherMatters;
    }

    struct partOfA {
        string registrationPurpose1;
        uint256 receiptDate2;
        string rightsHoldersAndOtherMatters1;
    }

    struct partOfB {
        string registrationPurpose2;
        uint256 receiptDate3;
        string registrationCause;
        string rightsHoldersAndOtherMatters2;
    }
    partOfTitle public PartOfTitleData;
    partOfA public PartOfAData;
    partOfB public PartOfBData;

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
        uint256 _receiptDate1,
        string memory _congregateBuilding,
        uint256 _locationNum,
        string memory _buildingStatement,
        string memory _landCategory,
        uint256 _area,
        uint256 _buildingNum,
        string memory _typesOfLandRights,
        uint256 _landRightsRatio,
        string memory _registrationCauseAndOtherMatters,
        string memory _registrationPurpose1,
        uint256 _receiptDate2,
        string memory _rightsHoldersAndOtherMatters1,
        string memory _registrationPurpose2,
        uint256 _receiptDate3,
        string memory _registrationCause,
        string memory _rightsHoldersAndOtherMatters2
    ) {
        houseowner = msg.sender;
        authorizedTenants[msg.sender] = true;
        PartOfTitleData = partOfTitle(
            _uniqueNum,
            _receiptDate1,
            _congregateBuilding,
            _locationNum,
            _buildingStatement,
            _landCategory,
            _area,
            _buildingNum,
            _typesOfLandRights,
            _landRightsRatio,
            _registrationCauseAndOtherMatters
        );

        PartOfAData = partOfA(
            _registrationPurpose1,
            _receiptDate2,
            _rightsHoldersAndOtherMatters1
        );

        PartOfBData = partOfB(
            _registrationPurpose2,
            _receiptDate3,
            _registrationCause,
            _rightsHoldersAndOtherMatters2
        );
    }
}


    function getUniqueNum() public view returns (uint256) {
        return PartOfTitleData.uniqueNum;
    }

    function getReceiptDate1() public view returns (uint256) {
        return PartOfTitleData.receiptDate1;
    }

    function getCongregateBuilding() public view returns (uint256) {
        return PartOfTitleData.congregateBuilding;
    }

    function getLocationNum() public view returns (uint256) {
        return PartOfTitleData.locationNum;
    }

    function getBuildingStatement() public view returns (uint256) {
        return PartOfTitleData.buildingStatement;
    }

    function getLandCategory() public view returns (uint256) {
        return PartOfTitleData.landCategory;
    }

    function getUniqueNum() public view returns (uint256) {
        return PartOfTitleData.uniqueNum;
    }

    function getUniqueNum() public view returns (uint256) {
        return PartOfTitleData.uniqueNum;
    }

    function getUniqueNum() public view returns (uint256) {
        return PartOfTitleData.uniqueNum;
    }

    function getUniqueNum() public view returns (uint256) {
        return PartOfTitleData.uniqueNum;
    }

    function getUniqueNum() public view returns (uint256) {
        return PartOfTitleData.uniqueNum;
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