// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interface/BankBaseContract.sol";

/**
 * @title Borrow
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
abstract contract Borrow is BankBaseContract {

    /*
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function bankBorrow () payable public{

        require(msg.value>=1e9, 'Error, collateral must be >= 0.01 ETH');
        require(isBorrowed[msg.sender] == false, 'Error, loan already taken.');

        //this Ether will be locked till user payOff the loan
        collateralEther[msg.sender] = collateralEther[msg.sender] + msg.value;

        //calc tokens amount to mint, 50% of msg.value
        uint tokensToMint = collateralEther[msg.sender] / 2;

        //mint&send tokens to user
        BankBaseContract.token.mint(msg.sender, tokensToMint);

        //activate borrower's loan status
        isBorrowed[msg.sender] = true;

        emit BEP20DistributedBankBorrow(msg.sender, collateralEther[msg.sender], tokensToMint);

    }

    function payOff() public{

        require(isBorrowed[msg.sender] == true, 'Error, loan not active');
        require(super.token.transferFrom(msg.sender, address(this), collateralEther[msg.sender]/2), "Error, can't receive tokens"); //must approve dBank 1st

        uint fee = collateralEther[msg.sender]/10; //calc 10% fee

        //send user's collateral minus fee
        msg.sender.transfer(collateralEther[msg.sender]-fee);

        //reset borrower's data
        collateralEther[msg.sender] = 0;
        isBorrowed[msg.sender] = false;

        emit BEP20DistributedBankPayOff(msg.sender, fee);

    }

}