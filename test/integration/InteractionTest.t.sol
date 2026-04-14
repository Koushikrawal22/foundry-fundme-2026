 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe , WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionTest is Test {
    FundMe fundMe;
    FundFundMe fundFundMe;
    WithdrawFundMe withdrawFundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE =1;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe(); // helper contract
        fundMe = deployFundMe.run();  // main contract  
        fundFundMe = new FundFundMe(); // helper contract for interaction
        withdrawFundMe = new WithdrawFundMe(); // helper contract for interaction
        vm.deal(USER, STARTING_BALANCE); 
        vm.deal(address(fundFundMe), STARTING_BALANCE); // giving balance to the script contract so that we can use this contract to test the fund function and withdraw function of the contract
    }

     function testUserCanFundinteraction() public {
        // FundFundMe fundFundMe = new FundFundMe(); //helper contract
        fundFundMe.fundFundMe(address(fundMe));

         address funder = fundMe.getFunder(0);
        assertEq(funder, address(fundFundMe));
     }
     
     function testUserCanWithdrawinteraction() public {
       
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assertEq(address(fundMe).balance, 0 );
     }

}