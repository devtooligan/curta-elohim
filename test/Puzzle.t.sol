// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Puzzle} from "../src/Puzzle.sol";
import "foundry-huff/HuffDeployer.sol";

interface NERV {
    function execute(string memory command) external;
}


contract PuzzleTest is Test {
    Puzzle public puzzle;
    address public nerv;



    function setUp() public {
        nerv = HuffDeployer.deploy("NERVCommand");
        puzzle = new Puzzle(nerv);
    }

    function testPuzzleName() public view {
        require(keccak256(abi.encode(puzzle.name())) == keccak256(abi.encode("Elohim")));
    }

    /// @notice Good luck!
    function testFuzzSolvePuzzle(uint256 solution) public {
        address player = address(this);
        (bool success, bytes memory data) = address(puzzle).call(abi.encodeWithSignature("verify(uint256,uint256)", solution, puzzle.generate(player)));
        if (success) {
            bool solved = abi.decode(data, (bool));
            if (solved) {
                console.log("Solved", solution);
                revert();
            }
        }
    }

}
