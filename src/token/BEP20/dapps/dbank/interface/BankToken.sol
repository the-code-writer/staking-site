// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "../../../interfaces/BEP20.sol";

contract BankToken is BEP20 {

    address public minter;

    event MinterChanged(address indexed from, address to);

    constructor() public payable BEP20("Decentralized Bank Currency", "DBC") {
        minter = msg.sender; // only initially
    }

    function passMinterRole(address dBank) public returns (bool) {
        require(msg.sender == minter, 'Error, only owner can change pass minter role');
        minter = dBank;

        emit MinterChanged(msg.sender, dBank);
        return true;
    }

    function mint(address account, uint256 amount) public {
        require(msg.sender == minter, 'Error, msg.sender does not have minter role');
        _mint(account, amount);
    }
}