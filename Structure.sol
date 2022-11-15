pragma solidity ^0.8.7;

contract Crud{

    struct User{
        uint id;
        string name;
    }

    User[] public users;
    uint public nextid=0;

    function Create(string memory name)public{
        users.push(User(nextid, name));
        nextid++;
    }

    function Read(uint id) view public returns(uint,string memory) {
        for(uint i=0;i<users.length;i++){
            if(users[i].id == id){
                return(users[i].id,users[i].name);
            }
        }
    }

    function Update(uint id, string memory name)  public {
        for(uint i=0;i<users.length;i++){
            if(users[i].id == id){
                users[i].name = name;

            }
        }
    }

    function Delete(uint id) public {
        delete users[id];
    }

    function Find(uint id) view internal returns(uint){
        for(uint i=0;i<users.length;i++){
            if(users[i].id == id){
                return i;
            }
        }

        revert("User does not exist");
    }


    



}
