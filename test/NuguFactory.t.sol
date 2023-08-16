// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NuguFactory.sol";

contract Dummy {}

contract NuguFactoryTest is Test {
    NuguFactory factory;

    function setUp() public {
        factory = new NuguFactory();
    }

    function test_deploy() public {
        address dummy = factory.deploy(keccak256("salt"), type(Dummy).creationCode, 0);
        assertEq(dummy.code, type(Dummy).runtimeCode);
    }

    function test_getDeployed() public {
        bytes32 salt = keccak256("salt");
        address dummy = factory.deploy(salt, type(Dummy).creationCode, 0);
        assertEq(dummy, factory.getDeployed(address(this), salt));
    }

    function test_RevertIfUsingSaltSame() public {
        factory.deploy(keccak256("salt"), type(Dummy).creationCode, 0);
        vm.expectRevert();
        factory.deploy(keccak256("salt"), type(Dummy).creationCode, 0);
    }

    function test_deploy_senderMatters() public {
        bytes32 salt = keccak256("salt");
        address dummy1 = factory.deploy(salt, type(Dummy).creationCode, 0);
        vm.prank(address(0xbeef));
        address dummy2 = factory.deploy(salt, type(Dummy).creationCode, 0);
        assertNotEq(dummy1, dummy2);
    }
}
