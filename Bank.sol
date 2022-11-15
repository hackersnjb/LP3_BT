pragma solidity ^0.8.7;

contract simpleBank{

    struct client_account{
        int client_id;
        address client_address;
        uint client_balance_in_ether;

    }

    client_account[] clients;

    int clientCounter;
    address payable manager;


    modifier onlyManager(){
        require(msg.sender == manager, "Only Manager can call this !!");
        _;
    }


    modifier onlyClients(){
        bool isclient = false;

        for(uint i=0;i<clients.length;i++){
            if(clients[i].client_address == msg.sender){
                isclient = true;
                break;
            }
        }

        require(isclient, "Only Client can call this !!");

        _;
    }

    constructor(){
        clientCounter = 0;
    }

    receive() external payable{}  // this hepls to take external ether


    function setManager(address managerAdderess) public returns(string memory){
        manager = payable(managerAdderess);
        return "";
    }


    function joinAsClient() public payable returns(string memory){
        clients.push(client_account(clientCounter++, msg.sender, address(msg.sender).balance));
        return "";
    }

    function deposit(uint amount) public payable onlyClients{
        payable(msg.sender).transfer(amount * 1 ether);
    }

    function withdraw(uint amount) public payable onlyClients{
        payable(msg.sender).transfer(amount * 1 ether);
    }

    function sendInterest() public payable onlyManager{
        for(uint i=0;i<clients.length;i++){
            address initialAddress = clients[i].client_address;
            payable(initialAddress).transfer(1 ether);
        }
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }




}
