// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./BankToken.sol";

abstract contract BankBaseContract {

    BankToken public token;

    mapping(address => uint) public depositStart;
    mapping(address => uint) public etherBalanceOf;
    mapping(address => uint) public collateralEther;

    mapping(address => bool) public isDeposited;
    mapping(address => bool) public isBorrowed;

    event BEP20DistributedBankDeposit(address indexed user, uint etherAmount, uint timeStart);
    event BEP20DistributedBankWithdraw(address indexed user, uint etherAmount, uint depositTime, uint interest);
    event BEP20DistributedBankBorrow(address indexed user, uint collateralEtherAmount, uint borrowedTokenAmount);
    event BEP20DistributedBankPayOff(address indexed user, uint fee);

    constructor(BankToken _token) {
        token = _token;
    }

}
