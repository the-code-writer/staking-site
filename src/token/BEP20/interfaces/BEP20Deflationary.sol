// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./BEP20.sol";

import "./BEP20TxnFeeReceiverAddress.sol";
import "./BEP20BrnFeeReceiverAddress.sol";

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
/**
 * @dev Extension of {BEP20} that adds a deflation with transfer fee and burn fee.
 */
abstract contract BEP20Deflationary is BEP20, BEP20TxnFeeReceiverAddress, BEP20BrnFeeReceiverAddress {

    using SafeMath for uint256;

    /**
     * @dev Emitted when `value` tokens are rewarded to token holders.
     *
     */
    event Rewards(uint256 value);


    function _transfer(address sender, address recipient, uint256 amount) internal virtual override(BEP20) {
        require(sender != address(0), "BEP20: transfer from the zero address");
        require(recipient != address(0), "BEP20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "BEP20: transfer amount exceeds balance");
        _balances[sender] = senderBalance.sub(amount);

        //address owner = getOwner();

        address txnFeeReceiverAddress = getTxnFeeReceiverAddress();
        address brnFeeReceiverAddress = getBrnFeeReceiverAddress();
        uint256 transferFee = amount * 4 / 100000;
        uint256 rewardsFee = amount * 5 / 100000;
        uint256 burnFee = amount / 100000;
        uint256 deductions = transferFee.add(rewardsFee).add(burnFee);

        amount.sub(deductions);

        _balances[recipient] += amount;
        _balances[brnFeeReceiverAddress] += transferFee;
        _balances[txnFeeReceiverAddress] += burnFee;
        rewardHolders(rewardsFee);

        emit Transfer(sender, recipient, amount);
        emit Transfer(sender, brnFeeReceiverAddress, transferFee);
        emit Transfer(sender, txnFeeReceiverAddress, burnFee);
        emit Rewards(rewardsFee);

    }

    function rewardHolders(uint256 amount) internal {
        require(amount > 0, "BEP20: rewards amount must be greater than zero");
        emit Rewards(amount);
    }
}