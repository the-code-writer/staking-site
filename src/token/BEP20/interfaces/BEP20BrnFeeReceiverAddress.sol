// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Extension of {BEP20} that adds the address of the burn fee receiver.
 */
abstract contract BEP20BrnFeeReceiverAddress{
    
    address  private _brnFeeReceiverAddress;

    /**
     * @dev Sets the address of the burn fee receiver. This value is immutable, it can only be
     * set once during construction.
     */
    constructor (address brnFeeReceiverAddress) {
        require(brnFeeReceiverAddress != address(0), "BEP20BrnFeeReceiverAddress: brnFeeReceiverAddress is 0");
        _brnFeeReceiverAddress = brnFeeReceiverAddress;
    }

    /**
     * @dev Returns the address of the burn fee receiver.
     */
    function getBrnFeeReceiverAddress() public view returns (address) {
        return _brnFeeReceiverAddress;
    }

}