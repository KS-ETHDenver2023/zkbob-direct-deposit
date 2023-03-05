# **Alice's ring - zkBob Direct Deposit smart contract**

🎯 Integrate BOB stablecoin and zkBob Direct Deposits functionality into your application.  

🎯 Use Infura and the Truffle suite of tools for L2 and Multi-Network Deployment.

**About zkBob and BOB stablecoin :**

BOB is a decentralized stablecoin with opt-in anonymity and confidentiality features powered by a protocol based on zk-SNARKs. One of the disadvantages of these types of protocols is the sender needs to calculate a proof using their secret key each time, making it difficult to use a smart contract to automate such payments. This problem is solved by introducing the Direct Deposit feature. 
You can now send funds to anyone in the privacy pool directly from the smart contract. This feature makes the zkBob protocol much more composable and suitable for integration where funds transfer can be included as a subroutine to other decentralized protocols. [See more details in the documentation.](https://docs.zkbob.com/zkbob-overview/readme)

## **Configuration** 📝

1. Clone this repo 
```
git clone https://github.com/KS-ETHDenver2023/zkbob-direct-deposit.git
```
2. Install npm
```
npm install
```
3. Install Truffle globally
```
npm install -g truffle
```

We use the **[React Truffle Box](https://trufflesuite.com/boxes/react/)** to write, compile, test, and deploy smart contracts, and interact with them from a React app. It's a great tool for every developer and it helps us a lot during our development journey.
You can install [**Ganache**](https://trufflesuite.com/ganache/) for local development and deployment.


## Challenges and benefits when using Infura and the Truffle suite of tools 💻
Challenges :

Our challenges were numerous during the design and implementation of our project.

 - First we had to create a portable, scalable and understandable development environment for the whole team but also in view of a future reuse of the project by other developers.
 - Our project and our smart contracts must be deployed and usable on different networks (L1, L2).
 - Test, correct, deploy... We needed to have a set of easily usable and implementable tools for these actions.

Benefits 🛰️:

1.  **Convenient access to blockchain networks** : Infura provides convenient access to various networks via L1 and L2 endpoints, so we don't need to set up and maintain our own node and configure our own RPC. This save us lot of time and resources, especially during hackathon.
2.  **Reliable and scalable infrastructure**: Infura is built on top of highly reliable and scalable infrastructure, which can help ensure that our dApp remains available and responsive to users.
3.  **Simplified deployment:** Using Infura and Truffle box simplify the process of deploying and testing our multichain dApp.
4.  **Integrated with Truffle:** Truffle provides built-in support for Infura, so it's easy to configure your Truffle project to use Infura's RPC. The process of RPC configuration inside the truffle-config.js is verry simple. 
5. **Truffle for VS Code:** As developers we love using VS Code. The Truffle extension for VS Code allowed us to simplify our development process.
6. **Documentation :** The infura and truffle documentation is very detailed and simply explains via concrete examples how to set up your project.

## Smart contract architecture 📏

The goal for our project was to add, thanks to **zkBob**, the possibility of carrying out anonymous transactions, via a stablecoin, on an EVM chain.
**zkBob** is currently deployed on the **Polygon** ecosystem, which we particularly appreciate thanks to its infrastructure and the quality of resources for developers and users.

We relied on the [zkbob documentation](https://docs.zkbob.com/).

**Direct deposits integration :**  

In order to dev the direct deposit functionality, we had to implement the interface [IZkBobDirectDeposits.sol](https://github.com/zkBob/zkbob-contracts/blob/develop/src/interfaces/IZkBobDirectDeposits.sol) within our smart contract.

We use the ERC677 transferAndCall approach because it's more gas efficient.

Our smart contract interacts directly with the zkBobpool to transfer BOBs from one address to another.
To do this the user must allow+deposit BOBs on our "Alice's Ring Direct Deposit" smart contract. 
Once done, he has the possibility from our web app to transfer BOBs.

One of the advantages of zkBob during our development phase was the good structure of their documentation and the explanations of how their protocol works.

# Why Using Polygon Network:

- High scalability
- Interoperability
- Security
- Developer-friendly
- Community-driven
- Eco-friendly

## High Scalability

Our solution requires fast transaction times that can be enabled by the Polygon's Plasma framework. The optimized version of EVM will enable us to process smart contracts more efficiently, with fast computation and low gas fees.

## Interoperability

- High compatibility with the Ethereum ecosystem (Solidity Language, similar development environment).
- Multiple blockchain networks are supported (Ethereum, BSC…), making good interoperability for our solution.
- Bridges to other blockchain networks for asset transfer and access to a wide range of dApps and services, which is a key aspect of our solution if we want to expand.
- Zkbob is on Polygon and is central to our project. It will allow us to create a micro-ecosystem of privacy transfer and to enable end-to-end anonymous solvency checking.

## Security

Polygon has a strong focus on smart contract auditing and will ensure the safety and security of the smart contracts that we will deploy on the network. Multi-sig is supported by Polygon.

## Developer-friendly

- Significantly low gas fees make it easy for us developers to build and deploy apps on the network.
- SDK includes a range of development tools which provides a simplified interface for interacting with the network.
- We love that the documentation is clear and comprehensive (guides, tutorials, and code samples…)

## Community-driven

- Grants program can really help us since it pushes us and it is designed to encourage community involvement and participation in the network's development.
- Community events and forums will help us network and provide feedback.

## Eco-friendly

We really care about our environmental footprint. The biggest PoW blockchains can consume a yearly quota of anywhere between 35–140 TWh of electricity, with a continuous draw of anywhere between 3–15 GW of electricity. Polygon’s validators approximately consume 0.00079TWh of electricity yearly with an approximate continuous draw of 0.00009GW. Polygon has implemented several carbon offset initiatives, such as partnering with ClimateTrade, to offset the carbon emissions generated by its network operations. This will help us analyze our carbon footprint. Polygon encourages developers to build energy-efficient dApps on the network by providing resources and support for sustainable development practices. That creates an eco-friendly ecosystem that we want to be a part of.


## Smart contract address

Polygon mainnet : 
```
0x39cb72ab613A386E8D37E8caCE8e048d0Dc54f86
```

Sepolia testnet: 
```
0x6a39041208918E974d967CA60CfBC239D9D50125
```

## Contribute ✨

Our project is intended as open source and as a tool for the Ethereum community and all web3 users. 
Feel free to contribute!

**Maxime - Thomas - Nathan - Adam | KRYPTOSPHERE®**
