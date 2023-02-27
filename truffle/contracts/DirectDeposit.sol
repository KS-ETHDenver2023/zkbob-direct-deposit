// SPDX-License-Identifier: CC0-1.0

pragma solidity ^0.8.0;

import "./IZkBobDirectDeposits.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DirectDeposit {

    address public owner;

    // Polygon Mainnet
    // IERC20 bob = IERC20(0xB0B195aEFA3650A6908f15CdaC7D92F8a5791B0B);
    // IZkBobDirectDeposits queue = IZkBobDirectDeposits(0x668c5286eAD26fAC5fa944887F9D2F20f7DDF289);

    // Sepolia testnet
    IERC20 bob = IERC20(0x2C74B18e2f84B78ac67428d0c7a9898515f0c46f);
    IZkBobDirectDeposits queue = IZkBobDirectDeposits(0xE3Dd183ffa70BcFC442A0B9991E682cA8A442Ade);

    event Received(address indexed, uint256);
    event DirectDepositSubmited(address indexed, uint256 indexed, uint256, string);

    constructor() {
        owner = msg.sender;
    }

    /*
    @notice Performs a direct deposit to the specified zk address.
    @param amount direct deposit amount.
    @param zkAddress receiver zk address.
    @return depositId id of the submitted deposit to query status for.
    Direct Deposit limits:
    1. Max amount of a single deposit - 1,000 BOB
    2. Max daily sum of all single user deposits - 10,000 BOB
    In case the deposit cannot be processed, it can be refunded later to the fallbackReceiver (msg.sender) address.
    */

    function directDepositImpl(uint256 amount, string memory zkRecieverAddress) public returns (uint256 IDdeposit){
        require(bob.balanceOf(msg.sender)>=amount, "not enough funds");
        bytes memory zkAddress = bytes(zkRecieverAddress);
        bob.approve(address(queue), amount);
        uint256 depositId = queue.directDeposit(msg.sender, amount, zkAddress);
        emit DirectDepositSubmited(msg.sender, depositId, amount, zkRecieverAddress);
        return depositId;
    }
    
    fallback () external payable 
	{
        emit Received(msg.sender, msg.value);
    }

    //It executes on calls to the contract with no data (calldata), such as calls made via send() or transfer()
	receive () external payable 
	{
        emit Received(msg.sender, msg.value);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public {
        require(msg.sender == owner, "only owner can withdraw");
        payable(msg.sender).transfer(address(this).balance);
    }

    
}