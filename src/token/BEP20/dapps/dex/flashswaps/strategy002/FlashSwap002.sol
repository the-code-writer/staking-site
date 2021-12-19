// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title FlashSwap002
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
abstract contract FlashSwap002 {

    /*
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function executeOpportunity2(address tokenAddressA, address tokenAddressB, uint256 tokenAmount, string memory exchange) virtual public {

    }

}