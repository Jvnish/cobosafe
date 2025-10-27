// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2 as console} from "forge-std/Script.sol";
import {CoboSafeFactory} from "../contracts/helper/CoboSafeFactory.sol";
import {CoboFactory} from "../contracts/CoboFactory.sol";
import {IGnosisSafe} from "../contracts/helper/CoboSafeFactory.sol";

contract DeployCoboScript is Script {
    CoboSafeFactory public factory;

    function run() external {
        factory = new CoboSafeFactory();
        console.log("coboArgusFactory:", factory.coboArgusFactory());

        address coboFactoryAddr = factory.coboArgusFactory();
        CoboFactory coboFactory = CoboFactory(coboFactoryAddr);
        address helper_addr = coboFactory.getLatestImplementation(
            bytes32("ArgusAccountHelper")
        );
        console.log("helper_impl:", helper_addr);
        bytes memory data = abi.encodeWithSignature(
            "initArgus(address,bytes32)",
            address(coboFactoryAddr),
            bytes32(0x0)
        );
        console.logBytes(data);

        address safe_addr = vm.envAddress("SAFE_ADDRESS");
        uint256 pk = vm.envUint("PRIVATE_KEY");
        address addr = vm.addr(pk);

        bytes memory signature = abi.encodePacked(
            abi.encode(addr, addr),
            bytes1(0x01)
        );
        vm.startBroadcast(pk);
        IGnosisSafe(safe_addr).execTransaction(
            helper_addr,
            0,
            data,
            uint8(1),
            0,
            0,
            0,
            address(0),
            payable(0),
            signature
        );
        vm.stopBroadcast();
        console.log("Transaction successfully sent!");
    }
}
