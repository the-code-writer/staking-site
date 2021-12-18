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
contract BEP20DistributedExchange is BEP20, Arbitrage, PriceMonitor, Trader, FlashSwap001, FlashSwap002, FlashSwap003, Exchange{

    /*
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function recoverBEP20(address tokenAddress, uint256 tokenAmount) public onlyOwner {
        IBEP20(tokenAddress).transfer(owner(), tokenAmount);
    }

}