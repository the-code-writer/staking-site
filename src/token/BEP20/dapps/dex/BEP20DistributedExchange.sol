// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../interfaces/BEP20.sol";

import "./arbitrage/Arbitrage.sol";
import "./bot/PriceMonitor.sol";
import "./bot/Trader.sol";
import "./flashswaps/strategy001/FlashSwap001.sol";
import "./flashswaps/strategy002/FlashSwap002.sol";
import "./flashswaps/strategy003/FlashSwap003.sol";
import "./swaps/Exchange.sol";


/**
 * @title TokenRecover
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
abstract contract BEP20DistributedExchange is BEP20, Arbitrage, PriceMonitor, Trader, FlashSwap001, FlashSwap002, FlashSwap003, Exchange{

    /*
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function executeOpportunity(address tokenAddressA, address tokenAddressB, uint256 tokenAmount, string memory exchange) override virtual public {

    }

}