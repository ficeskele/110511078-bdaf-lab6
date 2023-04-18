//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface WealtPrivateClubNFT{
    function iDeclareBeingRich() external;
    function transferFrom(address from,address to,uint256 tokenId) external;
}

contract FlashloanExecutor {

    address public tokenAddress;
    address public NFT_Addr;
    address public bank_Addr;
    address public owner;

    constructor(address Token, address NFT, address bank){
        tokenAddress = Token;
        NFT_Addr = NFT;
        bank_Addr = bank;
        owner = msg.sender;
    }

    modifier onlyOwner {
        require( msg.sender == owner , "Only owner can assess this function.");
        _;
    }

    function callIDeclareBeingRich() public {
        WealtPrivateClubNFT wpc = WealtPrivateClubNFT(NFT_Addr);
        wpc.iDeclareBeingRich();
    }

    function executeWithMoney(uint256 amount) external {
        callIDeclareBeingRich();
        IERC20(tokenAddress).transfer(bank_Addr, amount);
    }

    function transferNFT(uint256 tokenId) public onlyOwner{
        WealtPrivateClubNFT wpc = WealtPrivateClubNFT(NFT_Addr);
        wpc.transferFrom ( address(this) ,owner,tokenId);
    }
}
