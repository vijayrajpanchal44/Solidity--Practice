// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;
import "@openzeppelin/contracts/interfaces/IERC20.sol";
/**
 * @title Solidity Global variables
 * @author Vijay Raj Panchal
 * @notice You can use Global variables in you smart contract
 * @dev All function calls are currently implemented without side effects
 */


contract abiEncodeDecode {
    /**
    * @notice ABI-encodes the given arguments
    * @param name any string 
    * @param nums integer data in array format
    * @return encodes data in bytes format
    */
    function abiEncode(string memory name, uint[2] memory nums) public pure returns (bytes memory) {
        return abi.encode(name, nums);
    }

    /**
     * @notice  ABI-decodes the given data, while the types are given in parentheses as second argument.
     * @param data is encoded bytes
     * @dev ABI-decodes the provided data. The types are given in parentheses as second argument.
     */
    function abiDecode(bytes memory data) public pure returns (string memory name, uint[2] memory b) {
        (name, b) = abi.decode(data, (string, uint256[2]));
    }

    /**
     * @notice Performs packed encoding of the given arguments. Note that this encoding can be ambiguous!
     * @param name any string 
     * @param num integer 
     * @return encoded data
     */
    function abiEncodePacked(bytes memory name, uint256 num) public pure returns (bytes memory) {
        return abi.encodePacked(name, num);   //@audit -collision
    }

    /**
     * @notice  ABI-encodes the given arguments starting from the second and prepends 
     * the given four-byte selector
     * @notice Typo is not checked - "transfer(address, uint)"
     * @dev by this function we can call transfer function of erc20 tokens
     * @param to address of where we wants to send erc20
     * @param amount amount of erc20 token  
     * @return encoded data
     */
    function encodeWithSelector(address to, uint amount)    //@audit multisig wallet
        external
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    /**
     * @notice Equivalent to abi.encodeWithSelector(bytes4(keccak256(bytes(signature)), ...)
     * @notice Typo is not checked - "transfer(address, uint)"
     * @dev by this function we can call transfer function of erc20 tokens
     * @param to address of where we wants to send erc20
     * @param amount amount of erc20 token  
     * @return encoded data
     */
    function encodeWithSignature(address to, uint amount)
        external
        pure
        returns (bytes memory)
    {        
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    /**
     * @notice  ABI-encodes a call to functionPointer with the arguments found in the tuple
     * @notice Typo is checked, it will match the types expected by the called function.
     * @dev by this function we can call transfer function of erc20 tokens
     * @param to address of where we wants to send erc20
     * @param amount amount of erc20 token  
     * @return encoded data
     */
    function encodeCall(address to, uint amount)
        external
        pure
        returns (bytes memory)
    {
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }
}