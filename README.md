# Mini AMM DEX

A clean educational implementation of a decentralized exchange using the Automated Market Maker model (like Uniswap V2 simplified).

This project demonstrates core DeFi mechanics:

- Liquidity pools
- Token swaps
- LP shares
- Price calculation formula

Flat repo structure ensures easy learning.

---

## Features

• Add liquidity  
• Remove liquidity  
• Swap tokens  
• Constant product formula  
• LP token accounting  
• Wallet interaction  

---

## AMM Formula

The pricing model follows:

x * y = k

Where:

x = token A reserve  
y = token B reserve  
k = constant  

Swaps adjust reserves but keep k constant.

---

## Tech Stack

- Solidity
- Hardhat
- Ethers.js
- HTML + JS

---

## Contracts

Token.sol → ERC20 test tokens  
DEX.sol → AMM logic  

---

## Setup

Install:

npm install

Compile:

npx hardhat compile

Run node:

npx hardhat node

Deploy:

npx hardhat run deploy.js --network localhost

---

## Frontend

Open:

index.html

Paste deployed addresses in:

app.js

---

## Learning Goals

Understand:

- Liquidity pool math
- Slippage
- Token ratios
- LP share calculation
- DeFi swap logic

---

## Security Note

This DEX is simplified for education.

Production DEXs require:

- fee math
- oracle pricing
- flash-loan protection
- reentrancy guards

---

## License
MIT
