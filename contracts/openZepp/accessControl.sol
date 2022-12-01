//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";

abstract contract AccessControlTest is Context, IAccessControl, ERC165 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }
    mapping(bytes32 => RoleData) private _roles;

    bytes32 public constant ADMIN_ROLE = 0x00;

    modifier onlyRole(bytes32 role) {
        _checkRole(role);
        _;
    }

    function _checkRole(bytes32 role) internal view virtual {
        _checkRole(role, _msgSender());
    }

    function _checkRole(bytes32 role, address account) internal view virtual {
        if (!hasRole(role, account)) {
            revert(
                string(
                    abi.encodePacked(
                        "AccessControl: account ",
                        Strings.toHexString(account),
                        " is missing role ",
                        Strings.toHexString(uint256(role), 32)
                    )
                )
            );
        }
    }

    function hasRole(bytes32 role, address account) public view virtual override returns(bool) {
        return _roles[role].members[account];
    }

    function getRoleAdmin(bytes32 role) public view virtual override returns (bytes32) {
        return _roles[role].adminRole;
    }

    function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _grantRole(role, account);
    }

    function _grantRole(bytes32 role, address account) internal virtual {
        if (!hasRole(role, account)) {
            _roles[role].members[account] = true;
            emit RoleGranted(role, account, _msgSender());
        }
    }

    function _setupRole(bytes32 role, address account) internal virtual {
        _grantRole(role, account);
    }
    
    function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }

    function _revokeRole(bytes32 role, address account) internal virtual {
        if(hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }        
    }
    function renounceRole(bytes32 role, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for self");

        _revokeRole(role, account);
    }
}

/**
 * @title Community
 * @author Vijay Raj Panchal
 * @notice Implements a single role access control contract.
 */
contract Community is AccessControlTest {
    /// @dev Create the community role, with `root` as a member.
    constructor(address root) {
        _setupRole(ADMIN_ROLE, root);
    }

    function getRoleHash(string memory role) public pure returns(bytes32){
        return keccak256(abi.encodePacked(role));
    }

    /// @dev Restricted to members of the community.
    modifier onlyMember() {
        require(isMember(msg.sender), "Restricted to members.");
        _;
    }

    /// @dev Return `true` if the `account` belongs to the community.
    function isMember(address account) public view virtual returns (bool) {
        return hasRole(ADMIN_ROLE, account);
    }

    /// @dev Add a member of the community. Caller must already belong to the community.
    function addMember(address account) public virtual onlyMember {
        grantRole(ADMIN_ROLE, account);
    }

    /// @dev Remove oneself as a member of the community.
    function leaveCommunity() public virtual {
        // Roles will check membership.
        renounceRole(ADMIN_ROLE, msg.sender);
    }
}
