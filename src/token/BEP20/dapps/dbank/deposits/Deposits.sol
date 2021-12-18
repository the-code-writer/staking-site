// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interface/BankBaseContract.sol";

/**
 * @title Deposits
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
abstract contract Deposits is BankBaseContract{

    /*
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function bankDeposit() payable public{

        require(isDeposited[msg.sender] == false, 'DBANK DEPOSIT: Error, deposit already active');
        require(msg.value>=1e16, 'DBANK DEPOSIT: Error, deposit must be >= 0.01 ETH');

        etherBalanceOf[msg.sender] = etherBalanceOf[msg.sender] + msg.value;
        depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;

        isDeposited[msg.sender] = true; //activate deposit status
        emit BEP20DistributedBankDeposit(msg.sender, msg.value, block.timestamp);

    }

}