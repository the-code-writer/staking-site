// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Withdrawals
 * @dev Allow to recover any BEP20 sent into the contract for error
 */
contract Withdrawals {

    /**
     * @dev Remember that only owner can call so be careful when use on contracts generated from other contracts.
     * @param tokenAddress The token contract address
     * @param tokenAmount Number of tokens to be sent
     */
    function withdraw() public{

        require(isDeposited[msg.sender]==true, 'Error, no previous deposit');
        uint userBalance = etherBalanceOf[msg.sender]; //for event

        //check user's hodl time
        uint depositTime = block.timestamp - depositStart[msg.sender];

        //31668017 - interest(10% APY) per second for min. deposit amount (0.01 ETH), cuz:
        //1e15(10% of 0.01 ETH) / 31577600 (seconds in 365.25 days)

        //(etherBalanceOf[msg.sender] / 1e16) - calc. how much higher interest will be (based on deposit), e.g.:
        //for min. deposit (0.01 ETH), (etherBalanceOf[msg.sender] / 1e16) = 1 (the same, 31668017/s)
        //for deposit 0.02 ETH, (etherBalanceOf[msg.sender] / 1e16) = 2 (doubled, (2*31668017)/s)
        uint interestPerSecond = 31668017 * (etherBalanceOf[msg.sender] / 1e16);
        uint interest = interestPerSecond * depositTime;

        //send funds to user
        msg.sender.transfer(etherBalanceOf[msg.sender]); //eth back to user
        mint(msg.sender, interest); //interest to user

        //reset depositer data
        depositStart[msg.sender] = 0;
        etherBalanceOf[msg.sender] = 0;
        isDeposited[msg.sender] = false;

        emit BEP20DistributedBankWithdraw(msg.sender, userBalance, depositTime, interest);

    }

}