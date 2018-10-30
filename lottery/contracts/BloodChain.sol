pragma solidity ^0.4.17;

contract BloodChain {
    
    struct Donor {
        string name; 
        string mobile;
        string bloodGroup;
        uint16 gender; //1 = Male; 2 =Female 
        string location;
        uint16 status; //1 =Active; 2=Available for donation ; 3=onHold;
        address ethAddress;
        uint256 lastBloodDonationDate;
        //followed following blog
        //https://ethereum.stackexchange.com/questions/32173/how-to-handle-dates-in-solidity-and-web3
    }
    
    struct BloodBank {
        address ethAddress;
        string name; 
        string contactPerson;
        string contactNumber;
        string location;
        uint256 createdDate;
        uint256 approvalDate;
        uint16 status; //1= approved/2= pending/3 =rejected/ 4= active
    }

    struct  BloodBag {
            uint256 id;
            address donar;
            string test1;
            string test2;
            string test3;
            string test4;
            uint256 booldTakenDate;
            uint16 bagStatus; //1=Available; 2=rejected;3=verified; 4=transfused
            address screeningHospital;
            address availableLocation;
            address receiver;
            uint256 receivingDate; //user receiving date
            uint256 expirationDate;
            uint256 exractionDate;
    }

    struct  BloodRequest{
        address requestor;
        address requestedToDonor;
        uint256 bloodBagId; //in solidity there is no any concept of null value, if no value prodivded default value would be defined
        uint16 status;	//processed/rejected//pending 1=pending,2 =processed, 3 = rejected
    }

    struct BloodDonationRequest{
        address donor;
        address bloodBank; //hospital address
        uint256 bloodBagId;
        uint16 status; //received/pending/canceled
    }

    function BloodChain() public {
        
    }
//modifiers
    modifier modifiedByAdmin (){
    require( manager == msg.sender);
    _;
    }

// i will add second modifier of hospitals with mapping structure
    modifier modifiedByDonor(){
        require(false);//add conditions here later;
        _;
    }
//modifiers end



    //storage
    Donor[] public donors;
    address manager;
    BloodBank[] public bloodBanks; //blood banks and hospitals;
    BloodRequest[] public bloodRequests;
    
    //end
    
    function addDonor(string name, string mobile, string bloodGroup,uint16 gender,string location,uint16 status) public {
        
        Donor memory newDonor = Donor({
            name :name,
            mobile:mobile,
            bloodGroup:bloodGroup,
            gender:gender,
            location:location,
            status:status,
            ethAddress:msg.sender,
            lastBloodDonationDate:now //now * 1000 to get datetime ticks e.g. new Date( lastBloodDonationDate *1000) 
        });
        donors.push(newDonor);
    }
    
    function addBloodBank(string name, string contactPerson, string contactNumber,string location) public {
        
        BloodBank memory newBloodBank = BloodBank({
            name: name,
            contactNumber: contactNumber,
            contactPerson: contactPerson,
            location: location,
            status: 2,// 2 = pending on registration status should be pending
            ethAddress: msg.sender,
            createdDate: now,
            approvalDate: 0//not defined
        });
        bloodBanks.push(newBloodBank);
    }

    function updateBloodBankStaus (uint256 index,uint16 status) public modifiedByAdmin{
        //add data validations here..
        bloodBanks[index].status = status;
    }
    
    function getDonorsCount() view public returns(uint) {
        return donors.length;
    }

    function getDonor(uint index) view public returns(string, string, string, uint16, string, uint16) {
        return (donors[index].name, donors[index].mobile, donors[index].bloodGroup, donors[index].gender, donors[index].location, donors[index].status);
    }

    function requestBlood(uint256 bloodBagId,address donorId) public modifiedByDonor{
        //addblood request here.
        //bloodRequests
        BloodRequest memory newBloodRequest = BloodRequest({
            requestor:msg.sender,
            requestedToDonor:donorId,
            bloodBagId:bloodBagId,
            status:1 //default pending;
        });
        
        bloodRequests.push(newBloodRequest);
    }
    
    function getUser(address userId) view returns(string) {
        for(uint i=0;i<donors.length;i++) {
            if(donors[i].ethAddress == userId) {
                return "donor";
            }
        }
        
        for(i=0;i<bloodBanks.length;i++) {
            if(bloodBanks[i].ethAddress == userId) {
                return "bloodBank";
            }
        }
        
        return "";
    }
}