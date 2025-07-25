# Ethernaut-Hunt 🕵️‍♂️

---

## Overview

Welcome to `Ethernaut-Hunt`! This repository is a collection of my solutions and walkthroughs for the [OpenZeppelin Ethernaut](https://ethernaut.openzeppelin.com/) wargame. Ethernaut is an incredibly valuable resource for anyone looking to deepen their understanding of Web3 security, Solidity vulnerabilities, and the Ethereum Virtual Machine (EVM).

Each level in Ethernaut presents a smart contract that needs to be "hacked" by identifying and exploiting a specific vulnerability. This repository documents my journey through these challenges, providing not just the attack contracts but also detailed explanations of the vulnerabilities, the thought process behind the exploits, and the concepts learned.

Whether you're a beginner to blockchain security, an aspiring smart contract auditor, or just curious about common Solidity pitfalls, this repository aims to be a helpful guide.

---

## What is Ethernaut?

Ethernaut is a Web3/Solidity-based wargame inspired by [OverTheWire](https://overthewire.org/). It's played directly in the Ethereum Virtual Machine, where each level involves "hacking" a smart contract. The game serves both as a learning tool for Ethereum enthusiasts and as a catalog of historical hacks presented as interactive levels.

---

## Repository Structure

Each Ethernaut level's solution is is organized into its own directory. Inside each level's directory, you'll typically find:

* **`{LevelName}.sol`**: The original vulnerable Ethernaut contract (for reference).
* **`{LevelName}Attack.sol`**: My custom smart contract designed to exploit the vulnerability.
* **`README.md`**: A detailed walkthrough of the level, covering:
    * **Vulnerability Explanation**: What the flaw is and why it exists.
    * **Exploit Strategy**: How the attack contract (or manual steps) leverages the vulnerability.
    * **Key Concepts Learned**: Important Solidity or EVM concepts highlighted by the challenge (e.g., `tx.origin` vs `msg.sender`, reentrancy, storage layout, integer overflows, etc.).
    * **Attack Steps**: Step-by-step instructions on how to reproduce the hack.

---

## Levels & Solutions

Here's a list of the Ethernaut levels included in this repository (more will be added as I progress):

* **Level 00: Hello Ethernaut** (Often the introductory level)
* **Level 01: Fallback**
* **Level 02: Fallout**
* **Level 03: Coin Flip**
* **Level 04: Telephone**
* **Level 05: Token**
* **Level 06: Delegation**
* **Level 07: Force**
* **Level 08: Vault**
* **Level 09: King**
* **Level 10: Re-entrancy**
* **Level 11: Elevator**
* **Level 12: Privacy**
* **Level 13: GatekeeperOne**
* **Level 14: GatekeeperTwo**
* **Level 15: NaughtCoin**
* **Level 16: Preservation**
* **Level 17: Recovery**
* **Level 18: MagicNumber**
* **Level 19: Alien Codex**
* **Level 20: Denial**
* **Level 21: Shop**
* **Level 22: Dex**
* **Level 23: DexTwo**
* **Level 24: Puzzle Wallet**
* **Level 25: Motorbike**
* **Level 26: DoubleEntryPoint**
* **Level 27: Good Samaritan**
* **Level 28: Gatekeeper Three**
* **Level 29: Switch**
* **Level 30: Higher Order**

---

## Getting Started (How to use this repo)

To understand and test these solutions, you'll typically need a local Ethereum development environment (like Hardhat or Foundry) and access to the Ethernaut game itself.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/0xdeephunt/ethernaut-hunt.git](https://github.com/0xdeephunt/ethernaut-hunt.git)
    cd ethernaut-hunt
    ```
2.  **Install dependencies (if applicable):**
    If any `package.json` or `foundry.toml` files are present, follow their setup instructions (e.g., `npm install` or `forge install`).
3.  **Navigate to a level's directory:**
    ```bash
    cd levels/Level08_Reentrance
    ```
4.  **Review the `README.md`:**
    Read the walkthrough for the specific level to understand the vulnerability and the attack strategy.
5.  **Deploy the `Attack` contract:**
    Use your preferred tool (Remix, Hardhat, Foundry) to deploy the `Attack` contract to a testnet (e.g., Sepolia, Goerli, or a local Hardhat/Ganache node). Remember to pass the Ethernaut instance address to your `Attack` contract's constructor if required.
6.  **Execute the attack:**
    Follow the "Attack Steps" in the `README.md` to interact with your `Attack` contract or the Ethernaut instance directly to trigger the exploit.
7.  **Verify & Submit:**
    Once the vulnerability is exploited, verify the level's completion in the Ethernaut game and submit the instance.

---

## Contributing

If you find an error, have a more elegant solution, or want to contribute a walkthrough for a level not yet covered, feel free to open a pull request! Contributions are always welcome and help make this resource even better.

---

## Acknowledgments

* A huge thank you to **OpenZeppelin** for creating and maintaining the incredible Ethernaut wargame. It's an invaluable learning tool for the blockchain security community.

---

Happy hunting! 🚀