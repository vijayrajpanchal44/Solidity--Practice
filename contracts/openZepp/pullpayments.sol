//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/security/PullPayment.sol";
contract pullPayments is PullPayment{

    function depositEther() public payable {
        _asyncTransfer(msg.sender, msg.value);
    }     
}