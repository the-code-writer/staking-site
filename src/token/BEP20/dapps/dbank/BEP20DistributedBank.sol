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

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function _bankDeposit() payable public{
        bankDeposit();
    }

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function _bankWithdraw() payable public{
        bankWithdraw();
    }

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function _bankBorrow() payable public{
        bankBorrow();
    }

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function _bankStakeTokens() payable public{
        bankStakeTokens();
    }

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function _bankUnstakeTokens() payable public{
        bankUnstakeTokens();
    }

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function _bankIssueTokens() payable public{
        bankIssueTokens();
    }

}