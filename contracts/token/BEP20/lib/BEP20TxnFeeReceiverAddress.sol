// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Extension of {BEP20} that adds the address of the transactions fee receiver.
 */
abstract contract BEP20TxnFeeReceiverAddress{

    address  private _txnFeeReceiverAddress;

    /**
     * @dev Sets the address of the transactions fee receiver. This value is immutable, it can only be
     * set once during construction.
     */
    constructor (address txnFeeReceiverAddress) {
        require(txnFeeReceiverAddress != address(0), "BEP20TxnFeeReceiverAddress: txnFeeReceiverAddress is 0");
        _txnFeeReceiverAddress = txnFeeReceiverAddress;
    }

    /**
     * @dev Returns the address of the transactions fee receiver.
     */
    function getTxnFeeReceiverAddress() public view returns (address) {
        return _txnFeeReceiverAddress;
    }

}