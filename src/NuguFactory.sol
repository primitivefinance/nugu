// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.19;

import "solmate/utils/CREATE3.sol";

contract NuguFactory {
    function deploy(bytes32 salt, bytes memory creationCode, uint256 value)
        external
        payable
        returns (address deployed)
    {
        deployed = CREATE3.deploy(salt, creationCode, value);
    }

    function getDeployed(bytes32 salt) external view returns (address) {
        return CREATE3.getDeployed(salt);
    }
}
