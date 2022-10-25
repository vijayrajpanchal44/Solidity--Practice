// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract abiEncodeDecode {
    /**
     *  ABI-encodes the given arguments
     */
    function abiEncode(string memory name, uint[2] memory b) public pure returns (bytes memory) {
        return abi.encode(name, b);
    }
    /**
     * ABI-decodes the provided data. The types are given in parentheses as second argument.
     */

    function abiDecode(bytes memory data) public pure returns (string memory name, uint[2] memory b) {
        (name, b) = abi.decode(data, (string, uint256[2]));
    }
    /**
     * Performs packed encoding of the given arguments. Note that this encoding can be ambiguous!
     */
    function abiEncodePacked(bytes memory name, uint256 num) public pure returns (bytes memory) {
        return abi.encodePacked(name, num);
    }

    //Equivalent to abi.encodeWithSelector(bytes4(keccak256(bytes(signature)), ...)

    function encodeWithSignature(address to, uint amount)
        external
        pure
        returns (bytes memory)
    {
        // Typo is not checked - "transfer(address, uint)"
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    /**
     * ABI-encodes the given arguments starting from the second and prepends the given 
     * four-byte selector
     */
    function encodeWithSelector(address to, uint amount)
        external
        pure
        returns (bytes memory)
    {
        // Type is not checked - (IERC20.transfer.selector, true, amount)
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }
}