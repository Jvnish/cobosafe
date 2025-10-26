// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2 as console} from "forge-std/Script.sol";
import {CoboSafeFactory} from "../contracts/helper/CoboSafeFactory.sol";
import {CoboFactory} from "../contracts/CoboFactory.sol";

contract DeployCoboScript is Script {
    CoboSafeFactory public factory;

    function run() external {
        factory = new CoboSafeFactory();
        console.log("coboArgusFactory:", factory.coboArgusFactory());
        console.log("gnosisSafeProxyFactory:", factory.gnosisSafeProxyFactory());
        console.log("gnosisSafeFallbackHandler:", factory.gnosisSafeFallbackHandler());

        // address coboFactoryAddr = factory.coboArgusFactory();
        // console.log("coboFactoryAddr:", coboFactoryAddr);
        // CoboFactory coboFactory = CoboFactory(coboFactoryAddr);
        // address helper_addr = coboFactory.getLatestImplementation(bytes32("ArgusAccountHelper"));
        // require(helper_addr != address(0), "ArgusAccountHelper implementation not found");

        // console.log("helper_impl:", helper_addr);
    }
}