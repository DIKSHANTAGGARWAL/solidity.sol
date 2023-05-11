pragma solidity 0.8.18;

contract CompanyContract 
{
    address admin;
    mapping(address => uint256) public userLevel;
    mapping(uint256 => uint256) public limit;

    constructor() 
    {
        admin = msg.sender;
        limit[1] = 100; // Level 1 spending limit
        limit[2] = 200; // Level 2 spending limit
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    function addUser(address _user, uint256 _level) external onlyAdmin {
        require(_level<=2,"Only 3 levels exist in the company from 0 to 2.");
        userLevel[_user] = _level;
    }

    function updateLevelLimit(uint256 _level, uint256 _limit)external onlyAdmin
    {
        limit[_level] = _limit;
    }

    function spend(uint256 _amount)  public{
        if (msg.sender != admin) 
        {
            require(_amount <= limit[userLevel[msg.sender]], "Transaction limit exceeded.");
          
        }
    }

}
