// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../interfaces/BEP20.sol";

/**
 * @title BEP20DecentralisedAutonomousOrganization
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
abstract contract BEP20DecentralisedAutonomousOrganization is BEP20 {

    /*
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddressA The token contract address
     * @param tokenAddressB The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function vote(address tokenAddressA, address tokenAddressB, uint256 tokenAmount) public {

    }

}