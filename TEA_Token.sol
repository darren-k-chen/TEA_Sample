// contracts/TEA_Token.sol
// SPDX-License-Identifier: MIT

// This contract is use for AGAI internal testing.

pragma solidity ^0.8.0;

import "ERC721A.sol";
import "Ownable.sol";
import "Counters.sol";
// import "MerkleProof.sol";

contract sampleNFT is ERC721A, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIds;
    // bool private _presaleActive = false;
    // bool private _saleActive = false;
    string public _prefixURI;
    string public _baseExtension;

    constructor() ERC721A("sampleNFT", "sNFT") { }

    modifier callerIsUser() { 
        require(tx.origin == msg.sender, "The caller is another contract");
        _;
    }

    function increaseTokenID(uint256 newID) public onlyOwner {
        uint256 currentID = _tokenIds.current();
        require(newID > currentID, "New ID must be greater than current ID");
        uint256 diff = newID - currentID;
        for(uint256 i = 1;i<diff;i++) {
            _tokenIds.increment();
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return _prefixURI;
    }

    function setBaseURI(string memory _uri) public onlyOwner {
        _prefixURI = _uri;
    }

    function baseExtension() internal view returns (string memory) {
        return _baseExtension;
    }

    function setBaseExtension(string memory _ext) public onlyOwner {
        _baseExtension = _ext;
    }
    
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId),"ERC721AMetadata: URI query for nonexistent token");
        string memory currentBaseURI = _baseURI();
        return _baseURI();
        // return string(abi.encodePacked(currentBaseURI, "CH_token_metadata", _baseExtension))
        // tokenId.toString();
        // return bytes(currentBaseURI).length > 0 ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), _baseExtension)) : "";
    }

    function withdraw(address to, uint256 amount) external onlyOwner {
        require(address(this).balance >= amount);
        payable(to).transfer(amount);
    }

    function mint(uint256 quantity) external onlyOwner {
        _safeMint(msg.sender, quantity);
    }

    function testMint(uint256 quantity) public {
        _safeMint(msg.sender, quantity);
    }
}