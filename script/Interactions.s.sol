// SPDX_License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "./DeployFundMe.s.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentlyDeployedFundMe) public {
        FundMe(payable(mostRecentlyDeployedFundMe)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployedFundMe = DevOpsTools .get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployedFundMe);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployedFundMe) public {
     vm.startBroadcast();
     FundMe(payable(mostRecentlyDeployedFundMe)).withdraw();
     vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployedFundMe = DevOpsTools .get_most_recent_deployment("FundMe", block.chainid);
       
        withdrawFundMe(mostRecentlyDeployedFundMe);
       
    }
}
