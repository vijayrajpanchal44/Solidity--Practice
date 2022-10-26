// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;


contract otherGlobal {
    //The functions bytes.concat and string.concat
    string s = "Storage";
    /**
     * @notice  Concatenates variable number of bytes and bytes1, …, bytes32 arguments to one byte array
     * @notice Concatenates variable number of string arguments to one string array
     * @dev Concatenates both bytes and string
     * @param bc input in bytes
     * @param sm Input in string
     * @param b input in bytes16 format
     */
    function concatFunc(bytes calldata bc, string memory sm, bytes16 b) public view {
        string memory concatString = string.concat(s, string(bc), "Literal", sm);
        assert((bytes(s).length + bc.length + 7 + bytes(sm).length) == bytes(concatString).length);

        bytes memory concatBytes = bytes.concat(bytes(s), bc, bc[:2], "Literal", bytes(sm), b);
        assert((bytes(s).length + bc.length + 2 + 7 + bytes(sm).length + b.length) == concatBytes.length);
    }

    function concatStringFunc(string memory str1, string memory str2) public pure  returns (string memory) {
        return string.concat(str1, str2);
    }

    function concatBytesFunc(bytes memory b1, bytes memory b2) public pure  returns (bytes memory) {
        return bytes.concat(b1, b2);
    }

    /**
     * @notice compute (x + y) % k where the addition is performed with arbitrary precision and does 
     * not wrap around at 2**256. Assert that k != 0 starting from version 0.5.0.
     * @dev Concatenates both bytes and string
     * @param x input in integer
     * @param y input in integer
     * @param k input in integer
     * @return return modulus 
     */
    function addMod(uint x, uint y, uint k) public pure returns (uint256) {
        return addmod(x, y, k);        
    }

    /**
     * @notice compute (x * y) % k where the multiplication is performed with arbitrary
     *  precision and does not wrap around at 2**256. Assert that k != 0 starting from version 0.5.0.
     * @dev Concatenates both bytes and string
     * @param x input in integer
     * @param y input in integer
     * @param k input in integer
     * @return return modulus 
     */
    function mulMod(uint x, uint y, uint k) public pure returns (uint256) {
        return mulmod(x, y, k);        
    }

}