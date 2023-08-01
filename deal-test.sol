//SPDX-License-Identifier:MIT
pragma solidity >=0.8.0 <0.9.0;

import "./buildingRegistry-test.sol";
import "./Registry-test.sol";

contract CombinedContract{
    address public houseowner;
    address public tenant;
       modifier onlyOwner() {
        require(msg.sender == houseowner, "Only the houseowner can call this function.");
        _;
    }

    modifier onlyTenant() {
        require(msg.sender == tenant, "Only the tenant can call this function.");
        _;
    }
// 1단계 계약
    mapping(uint256 => string) public Clauses;
    // bool public agreedClauses;
    // mapping
    bool[] public agreedClausesArr;//8개 미리 arr 선언=> push x. ag[0]="dsfasf";
    constructor(){
        // agreedClausesArr[0] = "term";
        //Clauses 8개까지 변수명 입력. 

        Clauses[0] = "term";
    }
    

    function agreeToClauses(uint256 index) public onlyTenant returns (bool) {
        require(currentStep == 1, "You can't perform this step now.");
        require(!contractClauses[clause], "This clause has already been agreed to.");
        // agreedClauses=true;
        agreedClausesArr[index] = true;

//require(~arr[0]==true, "x")
    

        return agreedClausesArr[index];
}



//2단계 계약

