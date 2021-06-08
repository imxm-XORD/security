// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


contract Locker {
    using SafeMath for uint256;
    mapping(address => uint256) private balance;
    mapping(address => bool) private accountBook;
    modifier checkPoint() {
        require(accountBook[msg.sender],"You need to have an account with us");
        _;
    }
    modifier alreadyExists(){
        require(!accountBook[msg.sender],"You are already an account holder");
        _;
    }
    function createAcc() public alreadyExists() {
        accountBook[msg.sender]=true;
    }
    function deposit() public payable checkPoint(){
        require(msg.value>0,"Please send some funds");
        balance[msg.sender] = balance[msg.sender].add(msg.value);
    }
    function checkBalanceUser(address _account) public view checkPoint() returns(uint256) {
        return balance[_account];
    }
    function withDraw(uint256 _amount) public checkPoint() {
        require(balance[msg.sender]>0,"You dont have any balance");
        balance[msg.sender] = balance[msg.sender].sub(_amount);
        address(msg.sender).call{value:_amount}("");
    }

    /// this function contains the reentrancy attack
    function closeAccount() public checkPoint() {
        require(balance[msg.sender]>0,"You dont have any balance");
        address(msg.sender).call{value: balance[msg.sender]}("");
        accountBook[msg.sender] =false;
        balance[msg.sender]=0;
    }



    function checkBalance() view public returns(uint256) {
        return address(this).balance;
    }
}
