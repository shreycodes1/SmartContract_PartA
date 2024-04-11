// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract NFT is ERC721URIStorageUpgradeable {
    uint256 public _tokenIds; // Tracking the no of tokens minted

    /**
     * @notice Enables to initialize the contract
     * @param name  collection name
     * @param symbol collection symbolr
     *
     * intialize contract by owner.
     * Function should be perform by contract owner to initiliaze it.
     */
    function initialize(string memory name, string memory symbol) public initializer {
        ERC721Upgradeable.__ERC721_init(name, symbol); // Do not forget this call!
    }


    /**
     * @notice Enables users to create NFT Token
     * @param tokenURI  NFT detail of ipfs url
     *
     * user create the NFT.
     * Function should be perform by user to create token.
     */
    function createToken(address to,string memory tokenURI) public returns (uint256) {
        require(to != address(0),"Has Zero Address");
        uint256 newTokenId = _tokenIds+=1; // The new token id is the current value of the counter
        _mint(to, newTokenId); // mint the token to the sender
        _setTokenURI(newTokenId, tokenURI); // set the tokenURI to the tokenId.
        return newTokenId;
    }


    /**
     * @notice Enables users to create and transfer nft
     * @param _creator  creator address
     * @param _to  To transfer address 
     * @param _tokenURI NFT url of ipfs data
     *
     * buyer mint and transfer to himself using lazymint functionality.
     * Function should be perform by buyer to buy the nft and transfer to himself.
     */
    function mintAndTransfer(
        address _creator,
        address _to,
        string memory _tokenURI
    )  external returns(uint)  {
        require(_creator != address(0),"Has Zero Address");
        require(_to != _creator,"Have same Address");
        require(_to != address(0),"Have zero address");
        uint256 newTokenId = _tokenIds+=1;
        _safeMint(_creator, newTokenId);
        _setTokenURI(newTokenId, _tokenURI);
        _transfer(_creator, _to, newTokenId);
        return(newTokenId);
    }
}