// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../interfaces/BEP20.sol";

import "../dbank/deposits/Deposits.sol";
import "../dbank/collateral_loans/Borrow.sol";
import "../dbank/yeild_farming/Stake.sol";
import "../dbank/withdrawals/Withdrawals.sol";

/**
 * @title BEP20DistributedVault
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
contract BEP20DistributedBank is BEP20, Deposits, Borrow, Lend, Withdrawals {

    mapping(address => uint) public depositStart;
    mapping(address => uint) public etherBalanceOf;
    mapping(address => uint) public collateralEther;

    mapping(address => bool) public isDeposited;
    mapping(address => bool) public isBorrowed;

    event BEP20DistributedBankDeposit(address indexed user, uint etherAmount, uint timeStart);
    event BEP20DistributedBankWithdraw(address indexed user, uint etherAmount, uint depositTime, uint interest);
    event BEP20DistributedBankBorrow(address indexed user, uint collateralEtherAmount, uint borrowedTokenAmount);
    event BEP20DistributedBankPayOff(address indexed user, uint fee);

    // indicates if minting is finished
    bool private _booleanValue = false;

    //
    function getBooleanValue() public view returns (bool) {
        return _booleanValue;
    }

    //
    function setBooleanValue(bool data) public{
        _booleanValue = data;
    }

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function deposit() payable public{
        IBEP20(tokenAddress).transfer(owner(), tokenAmount);
    }

}