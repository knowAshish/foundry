// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";

import {MyERC20} from "../src/MyERC20.sol";

contract MyERC20Script is Script{

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new MyERC20("AshishToken", "ASH");
        vm.stopBroadcast();
    }

}
