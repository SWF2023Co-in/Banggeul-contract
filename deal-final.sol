// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;


contract CombinedContract {
    uint8 public currentStep;
    address public houseowner;
    address public tenant;
    bool[5] public completedSteps;

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
    bool public agreedClauses;
    bool[8] public agreedClausesArr; // 8개 미리 arr 선언=> push x. ag[0]="dsfasf";

    // 2단계 계약
    string[] public indicationArr;
    mapping(uint256 => string) public indication;
    bool public agreedIndication;

    // 3단계 계약
    mapping(uint256 => string) public contents;
    string[] public contentsArr;
    bool public agreedContents;
    bool public specialOwnerAgreed;
    bool public specialTenantAgreed;
    enum BorrowingChoice { Prepay, DeferredPay }
    BorrowingChoice public borrowingChoice;
    bool public borrowingAgreed;

    // 4단계 계약
    address public tenantAddress;
    string public residentRegistrationNumber;
    string public phoneNumber;
    string public name;

    // 전자 서명
    bool public electronicSignatureCompleted;

    bool public isMonthlyRent;
    uint256 public monthlyRentAmount;
    uint256 public securityDeposit;
    uint256 public leaseStartDate;
    uint256 public leaseDuration;

    event RentPaid(uint256 amount);
    event securityDepositPaid(uint256 amount);
    event DepositRefunded(uint256 amount);

    constructor() {
        

        Clauses[0] = "term";
        Clauses[1] = "altOfUseAndSub";
        Clauses[2] = "cancel";
        Clauses[3] = "end";
        Clauses[4] = "lapse";
        Clauses[5] = "defaultAndComp";
        Clauses[6] = "commission";
        Clauses[7] = "checkAndIssusance";
        

        indicationArr.push("DongDaeMun,Seoul");
        indicationArr.push("ground");
        indicationArr.push("58");
        indicationArr.push("apart");
        indicationArr.push("apart");
        indicationArr.push("1000");
        indicationArr.push("401");


        indication[0] = "location";
        indication[1] = "landCategory";
        indication[2] = "landArea";
        indication[3] = "buildingStructure";
        indication[4] = "buildingPurpose";
        indication[5] = "buildingArea";
        indication[6] = "lease";

        
      
        contentsArr.push("10,000,000");
        contentsArr.push("1,000,000");
        contentsArr.push("3,000,000");
        contentsArr.push("20230802");
        contentsArr.push("200,000");
        contentsArr.push("the first day of each month");
        contentsArr.push("the dispute follow the general case of housing lease contract");

        contents[0] = "securityDeposit";
        contents[1] = "deposit";
        contents[2] = "middlePayment";
        contents[3] = "middlePayday";
        contents[4] = "borrowing";
        contents[5] = "borrowingPayday";
        contents[6] = "special";  
        
    }

    function agreeToClauses(uint256 index) public onlyTenant returns (bool) {
        require(currentStep == 1, "You can't perform this step now.");
        require(!agreedClausesArr[index], "This clause has already been agreed to.");
        for (uint256 i = 0; i < 8; i++) {
            require(agreedClausesArr[i], "You can't agree to this step now.");
        }
        agreedClausesArr[index] = true;
        agreedClauses= true;
        return true;
    }

    function agreeToIndication() public onlyTenant returns (bool) {
        require(currentStep == 2, "You can't perform this step now.");
        require(completedSteps[0], "All previous steps must be completed.");
        require(!agreedIndication, "These indications have already been agreed to.");
        agreedIndication = true;
        return true;
    }

    function setBorrowingChoice(uint8 choice) public onlyTenant {
        require(choice == 0 || choice == 1, "Invalid choice.");
        borrowingChoice = BorrowingChoice(choice);
        borrowingAgreed = true;
    }

    function agreeToContents() public onlyTenant returns (bool) {
        require(currentStep == 3, "You can't perform this step now.");
        require(completedSteps[0] && completedSteps[1], "All previous steps must be completed.");
        require(borrowingChoice == BorrowingChoice.Prepay || borrowingChoice == BorrowingChoice.DeferredPay, "Invalid borrowing choice.");
        require(!agreedContents, "These contents have already been agreed to.");
        agreedContents = true;
        return true;
    }

    function agreeToSpecial() public view {
        require(msg.sender == houseowner || msg.sender == tenant, "Only the houseowner or tenant can call this function.");
        // Implement the function logic here
    }

    function provideTenantInfo(address _tenantAddress, string memory _residentRegNumber, string memory _phoneNumber, string memory _name) public onlyTenant {
        require(completedSteps[0] && completedSteps[1] && completedSteps[2], "All previous steps must be completed.");
        require(currentStep == 4, "You can't perform this step now.");
        tenantAddress = _tenantAddress;
        residentRegistrationNumber = _residentRegNumber;
        phoneNumber = _phoneNumber;
        name = _name;
    }

    function isElectronicSignatureCompleted() public view returns (bool) {
        require(completedSteps[0] && completedSteps[1] && completedSteps[2] && completedSteps[3], "All previous steps must be completed.");
        require(currentStep == 5, "You can't perform this step now.");
        return electronicSignatureCompleted;
    }

    function payRent() public onlyTenant payable {
        require(isMonthlyRent, "This is a lump-sum deposit contract, no monthly rent required.");
        require(msg.value == monthlyRentAmount, "Please pay the exact rent amount.");
        require(block.timestamp >= leaseStartDate, "Lease has not started yet.");
        require(completedSteps[0] && completedSteps[1] && completedSteps[2] && completedSteps[3] && completedSteps[4], "All previous steps must be completed.");

        emit RentPaid(msg.value);

        payable(houseowner).transfer(msg.value);
    }

    function paySecurityDeposit() public onlyTenant payable {
        require(msg.value > 0, "SecurityDeposit amount should be greater than 0.");
        require(tenant == address(0), "Deposit has already been paid.");
        require(msg.value >= securityDeposit + (isMonthlyRent ? monthlyRentAmount : 0), "Insufficient payment, securityDeposit and first rent amount required.");
        securityDeposit = msg.value - (isMonthlyRent ? monthlyRentAmount : 0);
        tenant = msg.sender;

        emit securityDepositPaid(securityDeposit);
        if (isMonthlyRent) {
            emit RentPaid(monthlyRentAmount);
        }
    }

    function startLease() public onlyOwner {
        require(securityDeposit > 0, "securityDeposit has not been paid yet.");
        require(leaseStartDate == 0, "Lease has already started.");
        leaseStartDate = block.timestamp;
    }

    function endLease() public onlyOwner {
        require(leaseStartDate > 0, "Lease has not started yet.");
        require(block.timestamp >= leaseStartDate + leaseDuration, "Lease duration has not completed yet.");

        // Refund the deposit to the tenant's account
        payable(tenant).transfer(securityDeposit);
        emit DepositRefunded(securityDeposit);

        // Reset contract data
        securityDeposit = 0;
        tenant = address(0);
        leaseStartDate = 0;
    }

    function getRemainingLeaseDuration() public view returns (uint256) {
        if (leaseStartDate == 0) {
            return 0;
        } else {
            uint256 elapsedTime = block.timestamp - leaseStartDate;
            if (elapsedTime >= leaseDuration) {
                return 0;
            } else {
                return leaseDuration - elapsedTime;
            }
        }
    }
}
