// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "./buildingRegistry.sol";
import "./Registry.sol";

contract CombinedContract {
    address public houseowner;
    address public tenant;
    uint256 public currentStep;

    // Step 1 Variables
    mapping(uint256 => bool) public contractClauses;
    uint256 public totalClauses = 8;
    uint256 public agreedClauses;

    // Step 2 Variables
    string public location;
    string public landCategory; 
    uint256 public landArea;
    string public PaymentAgreed;
    bool public buildingStructure;
    string public buildingPurpose;
    uint256 public buildingArea;
    string public lease;

    // Step 3 Variables
     string public contentsOfContract;
    bool public securityDepositAgreed;
    bool public depositAgreed;
    bool public mirrowingAgreed;
    bool public specialContractOwnerAgreed;
    bool public specialContractTenantAgreed;
    bool public stepFourContractReady;
    enum BorrowingChoice { Prepay, DeferredPay }
    BorrowingChoice public borrowingChoice;

    // Step 4 Variables
    address public tenantAddress;
    string public residentRegistrationNumber;
    string public phoneNumber;
    string public name;
    bool public contractStepOneCompleted;
    bool public contractStepTwoCompleted;
    bool public contractStepThreeCompleted;
    bool public contractStepFourCompleted;

    // Rental Contract Variables
    uint256 public deposit;
    uint256 public monthlyRentAmount;
    uint256 public leaseStartDate;
    uint256 public leaseDuration; // Lease duration in seconds
    bool public isMonthlyRent; // Flag to indicate whether it's a monthly rent or a lump-sum deposit
    bool public electronicSignatureCompleted;

    event DepositPaid(uint256 amount);
    event RentPaid(uint256 amount);
    event DepositRefunded(uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == houseowner, "Only the houseowner can call this function.");
        _;
    }

    modifier onlyTenant() {
        require(msg.sender == tenant, "Only the tenant can call this function.");
        _;
    }

    constructor(address _houseowner,address _tenant, string memory _contents, uint256 _monthlyRentAmount, uint256 _leaseDuration, bool _isMonthlyRent) payable {
        //owner = msg.sender;
        houseowner= _houseowner;
        tenant = _tenant;
        currentStep = 1;
        contentsOfContract = _contents;
        monthlyRentAmount = _monthlyRentAmount;
        leaseDuration = _leaseDuration;
        isMonthlyRent = _isMonthlyRent;
    }

    // Step 1 Functions
    function agreeToClause(uint256 clause) public onlyTenant returns (uint256) {
        require(currentStep == 1, "You can't perform this step now.");
        require(!contractClauses[clause], "This clause has already been agreed to.");

        // Mark the clause as agreed
        contractClauses[clause] = true;
        agreedClauses++;

        // Check if all clauses are agreed to
        // if (agreedClauses == totalClauses) {
        //     currentStep = 2; // Move to Step 2 if all clauses are agreed to
        // }
        currentStep = 2;

        agreedClauses = clause;

        return agreedClauses;
    }

    // Step 2 Function
    function indicatePropertyDetails(
        string memory _location,
        string memory _landCategory,
        uint256 _landArea,
        string memory _buildingStructure,
        string memory _buildingPurpose,
        uint256 _buildingArea,
        string memory _lease
    ) public onlyTenant {
        require(currentStep == 2, "You can't perform this step now.");

        // Save the indicated property details
        location = _location;
        landCategory = _landCategory;
        landArea = _landArea;
        buildingStructure = _buildingStructure;
        buildingPurpose = _buildingPurpose;
        buildingArea = _buildingArea;
        lease = _lease;

        // Move to Step 3
        currentStep = 3;
    }

    // Step 3 Functions
    function agreeToSecurityDeposit() public onlyTenant {
        securityDepositAgreed = true;
    }

    function agreeToDeposit() public onlyTenant {
        
        require(currentStep == 3, "You can't perform this step now.");

        depositAgreed = true;
    }

    function agreeToMiddlePayment() public onlyTenant {
        middlePaymentAgreed = true;
    }

    function setBorrowingChoice(uint8 choice) public onlyTenant {
        require(choice == 0 || choice == 1, "Invalid choice.");
        borrowingChoice = BorrowingChoice(choice);
        borrowingAgreed = true;
    }

    function agreeToSpecialContract() public {
        require(msg.sender == houseowner || msg.sender == tenant, "Only the houseowner or tenant can call this function.");

        if (msg.sender == houseowner) {
            specialContractOwnerAgreed = true;
        } else if (msg.sender == tenant) {
            specialContractTenantAgreed = true;
        }

        if (specialContractOwnerAgreed && specialContractTenantAgreed) {
            stepFourContractReady = true;
        }
    }
        // Step 4 Function
    function completeContractStepOne() public onlyTenant {
        contractStepOneCompleted = true;
    }

    function completeContractStepTwo() public onlyTenant {
        require(contractStepOneCompleted, "Step one of the contract must be completed first.");
        contractStepTwoCompleted = true;
    }

    function completeContractStepThree() public onlyTenant {
        require(contractStepTwoCompleted, "Step two of the contract must be completed first.");
        contractStepThreeCompleted = true;
    }

    function provideTenantInfo(address _tenantAddress, string memory _residentRegNumber, string memory _phoneNumber, string memory _name) public onlyTenant {
        require(contractStepThreeCompleted, "Step three of the contract must be completed first.");

        tenantAddress = _tenantAddress;
        residentRegistrationNumber = _residentRegNumber;
        phoneNumber = _phoneNumber;
        name = _name;

        if (tenantAddress != address(0) && bytes(residentRegistrationNumber).length != 0 && bytes(phoneNumber).length != 0 && bytes(name).length != 0) {
            contractStepFourCompleted = true;
        }
    }

    // Rental Contract Functions
    function payRent() public onlyTenant payable {
        require(isMonthlyRent, "This is a lump-sum deposit contract, no monthly rent required.");
        require(msg.value == monthlyRentAmount, "Please pay the exact rent amount.");
        // require(block.timestamp >= leaseStartDate, "Lease has not started yet.");
        // require(electronicSignatureCompleted, "Tenant must complete the electronic signature first ");

        emit RentPaid(msg.value);

        // Transfer rent amount to the owner's account
        payable(houseowner).transfer(msg.value);
    }

    function payDeposit() public onlyTenant payable {
        require(msg.value > 0, "Deposit amount should be greater than 0.");
        require(tenant == address(0), "Deposit has already been paid.");
        require(msg.value >= deposit + (isMonthlyRent ? monthlyRentAmount : 0), "Insufficient payment, deposit and first rent amount required.");
        deposit = msg.value - (isMonthlyRent ? monthlyRentAmount : 0);
        tenant = msg.sender;

        emit DepositPaid(deposit);
        if (isMonthlyRent) {
            emit RentPaid(monthlyRentAmount);
        }
    }

    function startLease() public onlyOwner {
        require(deposit > 0, "Deposit has not been paid yet.");
        require(leaseStartDate == 0, "Lease has already started.");
        leaseStartDate = block.timestamp;
    }

    function endLease() public onlyOwner {
        require(leaseStartDate > 0, "Lease has not started yet.");
        require(block.timestamp >= leaseStartDate + leaseDuration, "Lease duration has not completed yet.");

        // Refund the deposit to the tenant's account
        payable(tenant).transfer(deposit);
        emit DepositRefunded(deposit);

        // Reset contract data
        deposit = 0;
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
   // New Function: Check if the electronic signature is completed
function isElectronicSignatureCompleted() public view returns (bool) {
    return electronicSignatureCompleted;
  }
}