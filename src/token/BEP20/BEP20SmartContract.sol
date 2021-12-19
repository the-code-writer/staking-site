// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Import interfaces
import "./interfaces/BEP20Capped.sol";
import "./interfaces/BEP20Mintable.sol";
import "./interfaces/BEP20Burnable.sol";
import "./interfaces/BEP20Operable.sol";
import "./interfaces/BEP20Pausable.sol";
import "./interfaces/BEP20Snapshot.sol";
import "./interfaces/BEP20Deflationary.sol";

// Import Utils
import "./utils/TokenRecover.sol";
import "./utils/PayableToken.sol";


// Import DAPPS
import "./dapps/dao/BEP20DecentralisedAutonomousOrganization.sol";
import "./dapps/dbank/BEP20DistributedBank.sol";
import "./dapps/dex/BEP20DistributedExchange.sol";
import "./dapps/dvault/BEP20DistributedVault.sol";

contract BEP20SmartContract is BEP20Capped, BEP20Mintable, BEP20Burnable, BEP20Operable, BEP20Pausable, BEP20Deflationary, TokenRecover, BEP20DecentralisedAutonomousOrganization, BEP20DistributedBank, BEP20DistributedExchange, BEP20DistributedVault {

    constructor (
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 cap_,
        uint256 initialBalance_,
        address payable txnFeeReceiver_,
        address payable brnFeeReceiver_
    )
    BEP20(name_, symbol_)
    BEP20Capped(cap_, decimals_)
    BEP20TxnFeeReceiverAddress(txnFeeReceiver_)
    BEP20BrnFeeReceiverAddress(brnFeeReceiver_)
    payable
    {
        _setupDecimals(decimals_);
        _mint(_msgSender(), initialBalance_ * 10 ** decimals_);
    }

    /**
     * @dev Function to mint tokens.
     *
     * NOTE: restricting access to owner only. See {BEP20Mintable-mint}.
     *
     * @param account The address that will receive the minted tokens
     * @param amount The amount of tokens to mint
     */
    function _mint(address account, uint256 amount) internal override(BEP20, BEP20Capped) onlyOwner {
        super._mint(account, amount);
    }

    /**
     * @dev Function to stop minting new tokens.
     *
     * NOTE: restricting access to owner only. See {BEP20Mintable-finishMinting}.
     */
    function _finishMinting() internal override onlyOwner {
        super._finishMinting();
    }

    function transfer(address recipient, uint256 amount) public override(BEP20Pausable, BEP20) returns (bool) {
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override(BEP20Pausable, BEP20) returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }

    function approve(address spender, uint256 amount) public override(BEP20Pausable, BEP20) returns (bool) {
        return super.approve(spender, amount);
    }

    function increaseAllowance(address spender, uint256 addedValue) public override(BEP20Pausable, BEP20) returns (bool) {
        return super.increaseAllowance(spender, addedValue);
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public override(BEP20Pausable, BEP20) returns (bool) {
        return super.decreaseAllowance(spender, subtractedValue);
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override(BEP20Deflationary, BEP20) {
        super._transfer(sender, recipient, amount);
    }

}