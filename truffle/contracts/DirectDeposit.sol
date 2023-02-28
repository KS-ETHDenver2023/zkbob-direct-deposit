// SPDX-License-Identifier: CC0-1.0
// Compiler: 0.8.0
// Author: @krkmu
// ETHDenver - For you zkBOB

pragma solidity ^0.8.0;

import "./IZkBobDirectDeposits.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERC677 {
    function transferAndCall(address to, uint256 amount, bytes calldata data) external;
}

contract DirectDeposit {

    address public owner;
    mapping (address => uint256) public deposits;

    // Polygon Mainnet
    // IERC20 bob = IERC20(0xB0B195aEFA3650A6908f15CdaC7D92F8a5791B0B);
    // IZkBobDirectDeposits queue = IZkBobDirectDeposits(0x668c5286eAD26fAC5fa944887F9D2F20f7DDF289);

    // Sepolia testnet 
    // We use the IERC677 interface to call the transferAndCall function of the BOB token
    // and we use the IERC20 interface to call the transfer function of the BOB token
    // nb : BOB token has 18 decimals
    IERC677 public bob = IERC677(0x2C74B18e2f84B78ac67428d0c7a9898515f0c46f); 
    IERC20 public bobi = IERC20(0x2C74B18e2f84B78ac67428d0c7a9898515f0c46f); 
    IZkBobDirectDeposits public queue = IZkBobDirectDeposits(0xE3Dd183ffa70BcFC442A0B9991E682cA8A442Ade);

    //Some basic events to help us track the deposit and withdrawal of BOB tokens
    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(address indexed sender, uint256 amount);
    event Received(address, uint256);

    constructor() {
        owner = msg.sender;
    }

    /*
    @notice Performs a direct deposit to the specified zk address.
    User should first have performed a deposit (and BOB approve) of BOB tokens to this contract.
    @param amount direct deposit amount.
    @param zkRecieverAddress receiver zk address.
    @param fallbackReceiver fallback receiver address.
    Direct Deposit limits:
    1. Max amount of a single deposit - 1,000 BOB
    2. Max daily sum of all single user deposits - 10,000 BOB
    In case the deposit cannot be processed, it can be refunded later to the fallbackReceiver (msg.sender) address.
    */
    function directDeposit(uint256 amount, string memory zkRecieverAddress, address fallbackReceiver) public {
        require(deposits[msg.sender]>=amount, "Not enough funds");
        bytes memory zkAddress = bytes(zkRecieverAddress);
        bob.transferAndCall(address(queue), amount, abi.encode(fallbackReceiver, zkAddress));
        deposits[msg.sender] -= amount;
    }

    /*
    @notice Performs a direct deposit to the specified zk address.
    User should first have performed a approve this contract for BOB transfer.
    @param amount direct deposit amount.
    */
    function despositBob(uint256 amount) public {
        bobi.transferFrom(msg.sender,address(this),amount);
        deposits[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }

    /*
    @notice Withdraw the deposited BOB.
    @param amount direct deposit amount.
    */
    function withdrawBob(uint256 amount) public {
        require(deposits[msg.sender]>=amount, "Not enough funds");
        bobi.transfer(msg.sender,amount);
        deposits[msg.sender] -= amount;
        emit Withdraw(msg.sender, amount);
    }

    /*
    @notice Withdraw the deposited BOB.
    @param amount direct deposit amount.
    */
    function getContractBobBalance() public view returns (uint256) {
        return bobi.balanceOf(address(this));
    }

    /*
    @notice View the BOB amount allowed by user to be transfered by the contract.
    */
    function getContractBobAllowance(address user) public view returns (uint256) {
        return bobi.allowance(user,address(this));
    } 

    // Contract Utils

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

    /*
    @notice Withdraw native coin from contract.
    Only owner can perform this action.
    */
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(msg.sender).transfer(address(this).balance);
    }

}
