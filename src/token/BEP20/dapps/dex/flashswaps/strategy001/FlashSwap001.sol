// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title FlashSwap001
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
abstract contract FlashSwap001 {

    /*
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function executeOpportunity1(address tokenAddressA, address tokenAddressB, uint256 tokenAmount, string memory exchange) virtual public {

    }

}