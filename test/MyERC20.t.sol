// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/MyERC20.sol";

contract MyERC20Test is Test {
    MyERC20 public myerc20;
    address user1 = vm.addr(0x1);
    address user2 = vm.addr(0x2);

    function setUp() public {
        myerc20 = new MyERC20("AshishToken", "ASH");
    }

    function testname() external {
        assertEq("AshishToken", myerc20.name());
    }

    function testsymbol() external {
        assertEq("ASH", myerc20.symbol());
    }

    function testTotalSupply() public {
        uint256 expectedTotalSupply = 1000000 *
            (10 ** uint256(myerc20.decimals()));
        assertEq(myerc20.totalSupply(), expectedTotalSupply);
    }

    function testBalancesOf() public {
        uint256 expectedTotalSupply = 1000000 *
            (10 ** uint256(myerc20.decimals()));
        assertEq(myerc20.balanceOf(address(this)), expectedTotalSupply);
    }

    function testApprove() public {
        uint256 amountToApprove = 1e18;
        assertEq(myerc20.approve(user1, amountToApprove), true);
    }

    function testTransfer() external {
        // transfer from address(this) - owner of tokens to user1
        uint256 amountToTransfer = 0.2e18;
        myerc20.transfer(user1, amountToTransfer);
        assertEq(myerc20.balanceOf(user1), amountToTransfer);
    }

    function testAllowance() public {
        uint256 amountAllowance = 1e18;

        // first approve, then allowance
        myerc20.approve(user1, amountAllowance);

        assertEq(
            myerc20.allowance(address(this), user1),
            amountAllowance,
            "allownce amount mismatched"
        );
    }

    function testTransferFrom() public {
        uint256 amountToTransfer = 1e18;

        // first approve from tokens owner, then transfert from
        myerc20.approve(user1, amountToTransfer);

        vm.startPrank(user1);
        assertEq(
            myerc20.transferFrom(address(this), user1, amountToTransfer),
            true
        );
        vm.stopPrank();
    }

    function testDescreaseAllowance() external {
        uint256 amountToTransfer = 1e18;

        // first approve, then decrease
        myerc20.approve(user1, amountToTransfer);

        assertEq(myerc20.allowance(address(this), user1), 1e18);
        assertTrue(myerc20.decreaseAllowance(user1, 0.5e18));
        assertEq(myerc20.allowance(address(this), user1), 0.5e18);
    }

    function testIncreaseAllowance() external {
        assertEq(myerc20.allowance(address(this), user1), 0);
        assertEq(myerc20.increaseAllowance(user1, 2e18), true); // assertTrue(erc20.increaseAllowance(user1, 2e18));
        assertEq(myerc20.allowance(address(this), user1), 2e18);
    }
}
