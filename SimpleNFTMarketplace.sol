// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract SimpleNFTMarketplace is ERC721, Ownable {
    using SafeMath for uint256;

    mapping (uint256 => uint256) public tokenPrice;
    mapping (uint256 => address) public tokenSeller;

    event TokenListed(uint256 indexed tokenId, uint256 price);
    event TokenSold(uint256 indexed tokenId, uint256 price, address buyer);

    constructor(string memory _name, string memory _symbol, address _initialOwner) ERC721(_name, _symbol) Ownable(_initialOwner) {}

    function listToken(uint256 _tokenId, uint256 _price) external {
        require(ownerOf(_tokenId) == msg.sender, "You do not own this token");
        tokenPrice[_tokenId] = _price;
        tokenSeller[_tokenId] = msg.sender;
        emit TokenListed(_tokenId, _price);
    }

    function buyToken(uint256 _tokenId) external payable {
        uint256 price = tokenPrice[_tokenId];
        address seller = tokenSeller[_tokenId];
        require(price > 0, "Token not listed for sale");
        require(msg.value >= price, "Insufficient funds");
        transferFrom(seller, msg.sender, _tokenId);
        payable(seller).transfer(msg.value);
        tokenPrice[_tokenId] = 0;
        tokenSeller[_tokenId] = address(0);
        emit TokenSold(_tokenId, price, msg.sender);
    }
}
