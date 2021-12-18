// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../interfaces/BEP20.sol";

/**
 * @title BEP20DistributedVault
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
contract BEP20DistributedBank is BEP20 {

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function recoverBEP20(address tokenAddress, uint256 tokenAmount) public onlyOwner {
        IBEP20(tokenAddress).transfer(owner(), tokenAmount);
    }

}