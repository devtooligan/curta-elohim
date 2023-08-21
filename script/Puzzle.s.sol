// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Puzzle} from "../src/Puzzle.sol";
import {Script, console2} from "forge-std/Script.sol";
import "forge-std/console.sol";

contract PuzzleScript is Script {
    function deployHuff(string memory filename) public returns (address addr) {
        string[] memory cmds = new string[](3);
        cmds[0] = "huffc";
        cmds[1] = "-b";
        cmds[2] = filename;
        bytes memory creationCode = vm.ffi(cmds);
        console.logBytes(abi.encode(creationCode));
        vm.broadcast();
        assembly {
            addr := create(0, add(creationCode, 0x20), mload(creationCode))
        }
        console.log("Deployment Address", addr);
    }

    function setUp() public {}

    //forge script script/Puzzle.s.sol:PuzzleScript --rpc-url $MAINNET_RPC --broadcast --verify -vvvv

    function run() public {
        // address nerv = deployHuff("./src/NERVCommand.huff");
        address nerv = 0xac6a22d4d89e5B4e7a891474257f67c86101796C; // deployed
        // vm.broadcast();
        // Puzzle puzzle = new Puzzle(nerv);
        // console.log("Puzzle Address", address(puzzle));
        address puzzle = 0xE92126D243D8290B47Af8b198B662Bf301439830; // deployed
    }
}
