
// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;
import "./abiEncodeDecode.sol";
/**
 * @title Solidity Global variables
 * @author Vijay Raj Panchal
 * @notice You can use Global variables in you smart contract
 * @dev All function calls are currently implemented without side effects
 */


contract solidityGlobalVariables {
    /**
     * @notice  Hash of the given block when blocknumber is one of the 256 most recent blocks; 
     * otherwise returns zero
     * @dev Can not generate hash of current block.
     * @return Block hash in bytes
     */
    function blockhashFunc() public view returns (bytes32) {
        return blockhash(currentBlockNumber()-1);
    }

    /**
     * @notice This function will return current block number. 
     * @return Current Block number
     */
    function currentBlockNumber() public view returns (uint256) {
        return block.number;
    }

    /**
     * @notice The base fee is calculated by a formula that compares the size of the previous
     *  block (the amount of gas used for all the transactions) with the target size.
     * @dev current block’s base fee (EIP-3198 and EIP-1559)
     * @return current block’s base fee
     */
    function currentBlockBaseFee() public view returns (uint256) {
        return block.basefee;
    }

    /**
     * @notice  The chain ID is a property of the chain managed by the node. 
     * It is used for replay protection of transactions.
     * @return Current working chain ID.
     */
    function currentChainId() public view returns (uint256) {
        return block.chainid;
    }

    /**
     * @dev block.coinbase points to the miner node which included the transaction in its block.
     * @return current block miner’s address
     */
    function minerAddress() public view returns (address) {
        return block.coinbase;
    }

    /**
     * @notice  The gas limit of a block defines the maximum amount of gas that all 
     * the transactions inside the block are allowed to consume
     * @return current block gaslimit
     */
    function currentBlockGaslimit() public view returns (uint256) {
        return block.gaslimit;
    }

    /**
     * @return Current block timestamp as seconds since unix epoch
     */
    function blockTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    /**
     * @notice how difficult it is to mine a block
     * @return current block difficulty
     */
    function currentBlockDifficulty() public view returns (uint256) {
        return block.difficulty;
    }

    /**
     * @notice The function gasleft was previously known as msg.gas, 
     * which was deprecated in version 0.4.21 and removed in version 0.5.0.
     * @return remaining gas of a block.
     */
    function remainingGas() public view returns (uint256) {
        return gasleft();
    }

    /**
     * @return complete Call data  @audit
     */
    function completeCalldata() public pure returns (bytes calldata) {
        return msg.data;
    }

    /**
     * @dev sender of the message (current call)
     * @return return address of sender of the message
     */
    function senderOfMessage() public view returns (address) {
        return msg.sender;
    }

    /**
     * @dev Number of wei sent with the message
     * @return return number of wei send
     */
    function numberOfWei() public payable returns (uint256) {
        return msg.value;
    }

    /**
     * @dev Gas price of the transaction.
     * @return return Gas price of the transaction.
     */
    function transactionGasPrice() public view returns (uint256) {
        return tx.gasprice;
    }

    /**
     * @dev sender of the transaction (full call chain)
     * @return return address of the transaction sender
     */
    function transactionSender() public view returns (address) {
        return tx.origin;
    }    

    /**
     * @notice It can be used for generating hash of string data type using keccak256 algorithm
     * @dev compute the Keccak-256 hash of the input
     * @param data can pass a string
     * @return return hash of passed data
     */
    function computeKeccak256(string memory data) public pure returns (bytes32) {
        return keccak256(bytes(data));
    }  

    /**
     * @notice Recover address associated with the public key from elliptic curve signature,
     *  return zero on error
     * @param hash      @audit
     * @param r first 32 bytes of signature
     * @param s second 32 bytes of signature
     * @param v final 1 byte of signature
     * @return returns an address, and not an address payable.
     */
    function ecRecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        return ecrecover( hash,  v,  r,  s);
    } 

    /**
     * @notice  Destroy the current contract, sending its funds to the given Address and end execution.
     * @dev the contract is only really destroyed at the end of the transaction and revert s might 
     * “undo” the destruction.
     */
    function selfDestruct(address payable recipient) public {
        selfdestruct(recipient);
    } 

    /**
     * @param addr address whose balance we wants to know 
     * @return balance of the Address in Wei
     */
    function balanceOfaddr(address addr) public view returns (uint256) {
        return addr.balance;        
    }


    /**
     * @param addr contract address whose code we wants to know 
     * @return code in bytes format
     */
    function codeOfAddress(address addr) public view  returns (bytes memory) {
        return addr.code;        //@audit working?
    }
    
    /**
     * @param addr contract address whose codehash we wants to know 
     * @return the codehash of the Address
     */
    function codehashOfAddress(address addr) public view returns (bytes32) {
        return addr.codehash;       
    }

    /**
     * @notice Creation code, is runtime code plus an initialization process.
     * @dev type(X) = X can be either a contract or an integer type
     * @return creation code  of abiEncodeDecode contract
     */
    function creationCode() public pure returns (bytes memory) {
        bytes memory bytecode = type(abiEncodeDecode).creationCode;      
        return bytecode; 
    }

    /**
     * @notice Runtime code is the actual business logic stored in the contract’s code slot
     * @dev type(X) = X can be either a contract or an integer type
     * @return runtime code of abiEncodeDecode contract
     */
    function runtimeCode() public pure returns (bytes memory) {
        return type(abiEncodeDecode).runtimeCode;      
    }

    /**
     * @dev type(X) = X can be inbuilt datatype
     * @return return The smallest value representable by type
     */
    function minValue() public pure returns(uint256){
        return type(uint256).min;
    }

    /**
     * @dev type(X) = X can be inbuilt datatype
     * @return return The largest value representable by type
     */
    function maxValue() public pure returns(uint256){
        return type(uint256).max;
    }
}

