// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./abiEncodeDecode.sol";
contract solidityGlobalVariables {
    /**
     * hash of the given block when blocknumber is one of the 256 most recent blocks; 
     * otherwise returns zero
     */
    function blockhashFunc() public view returns (bytes32) {
        return blockhash(currentBlockNumber()-1);
    }
    function currentBlockNumber() public view returns (uint256) {
        return block.number;
    }
    /**
     * current block’s base fee (EIP-3198 and EIP-1559)
     */
    function currentBlockBaseFee()  public view returns (uint256) {
        return block.basefee;
    }

    function currentChainId() public view returns (uint256) {
        return block.chainid;
    }

    /**
     * current block miner’s address
     */
    function minerAddress() public view returns (address) {
        return block.coinbase;
    }

    function currentBlockGaslimit() public view returns (uint256) {
        return block.gaslimit;
    }
    /**
     * current block timestamp as seconds since unix epoch
     */
    function blockTimestamp() public view returns (uint256) {
        return block.timestamp;
    }
    //how difficult it is to mine a  block
    function currentBlockDifficulty() public view returns (uint256) {
        return block.difficulty;
    }

    function remainingGas() public view returns (uint256) {
        return gasleft();
    }

    function completeCalldata() public pure returns (bytes calldata) {
        return msg.data;
    }

    function senderOfMessage() public view returns (address) {
        return msg.sender;
    }

    function numberOfWei() public payable returns (uint256) {
        return msg.value;
    }

    function transactionGasPrice() public view returns (uint256) {
        return tx.gasprice;
    }

    /**
     * sender of the transaction (full call chain)
     */

    function transactionSender() public view returns (address) {
        return tx.origin;
    }    

    //compute the Keccak-256 hash of the inpu
    function computeKeccak256(string memory data) public pure returns (bytes32) {
        return keccak256(bytes(data));
    }  

    /**
     * recover address associated with the public key from elliptic curve signature,
     *  return zero on error
     */
    function ecRecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        return ecrecover( hash,  v,  r,  s);
    } 
    // destroy the current contract, sending its funds to the given address
    function selfDestruct(address payable recipient) public {
        selfdestruct(recipient);
    } 

    function balanceOfaddr(address addr) public view  returns (uint256) {
        return addr.balance;        
    }
    //code at the Address (can be empty)
    function codeOfAddress(address addr) public view  returns (bytes memory) {
        return addr.code;        //@audit working?
    }
    
    // the codehash of the Address
    function codehashOfAddress(address addr) public view returns (bytes32) {
        return addr.codehash;       
    }
    //Creation code, is runtime code plus an initialization process.
    //type(X) = X can be either a contract or an integer type
    function creationCode() public pure returns (bytes memory) {
        bytes memory bytecode = type(abiEncodeDecode).creationCode;      
        return bytecode; 
    }
    //Runtime code is the actual business logic stored in the contract’s code slot
    function runtimeCode() public pure returns (bytes memory) {
        return type(abiEncodeDecode).runtimeCode;      
    }

    function minValue() public pure returns(uint256){
        return type(uint256).min;
    }

    function maxValue() public pure returns(uint256){
        return type(uint256).max;
    }
}

