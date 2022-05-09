// contracts/TEA_Token.sol
// SPDX-License-Identifier: MIT

// This contract is use for AGAI internal testing.

pragma solidity ^0.8.0;

import "ERC721A.sol";
import "Ownable.sol";
import "Counters.sol";
// import "MerkleProof.sol";

contract ChaXinYuan is ERC721A, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIds;
    // bool private _presaleActive = false;
    // bool private _saleActive = false;
    string public _prefixURI;
    string public _baseExtension;

    // uint256 private _maxPresaleMint = 1;
    // uint256 private _maxMint = 100;
    // bytes32 private merkleRoot = 0x6c8dd02b3d8754af9de7705bf4ecc6ed39e01388126cc610ab26fbf3a293bcda;

    // mapping (address => uint256) private _presaleMints;
    // mapping (address => uint256) private _saleMints;

    // uint256 public  _price = 60000000000000000;
    // uint256 private _maxTokens = 1000000;

    // uint256 public finalSupply;
    // address[2] public contractOwner;

    constructor() ERC721A("ChaXinYuan", "TEA") { }

    modifier callerIsUser() { 
        require(tx.origin == msg.sender, "The caller is another contract");
        _;
    }

    // modifier hasCorrectAmount(uint256 _wei, uint256 _quantity) {
    //     require(_wei >= _price * _quantity, "Insufficent funds");
    //     _;
    // }

    // modifier withinMaximumSupply(uint256 _quantity) {
    //     require(totalSupply() + _quantity <= _maxTokens, "Surpasses supply");
    //     _;
    // }

    // function airdrop(address[] memory addrs, uint256 amount) public onlyOwner {
    //     for (uint256 i = 0; i < addrs.length; i++) {
    //         _tokenIds.increment();
    //        _mintItem(addrs[i], amount);
    //     }
    // }

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

    // function setMerkleRoot(bytes32 _root) public onlyOwner {
    //     merkleRoot = _root;
    // }

    // function preSaleActive() public view returns (bool) {
    //     return _presaleActive;
    // }

    // function saleActive() public view returns (bool) {
    //     return _saleActive;
    // }

    function setBaseExtension(string memory _ext) public onlyOwner {
        _baseExtension = _ext;
    }

    // function togglePreSale() public onlyOwner {
    //     _presaleActive = !_presaleActive;
    // }

    // function toggleSale() public onlyOwner {
    //     _saleActive = !_saleActive;
    // }

    // function resetSaleMintsForAddrs(address[] memory addrs) public onlyOwner {
    //     for (uint256 i = 0; i < addrs.length; i++) {
    //         _saleMints[addrs[i]] = 0;
    //     }
    // }

    // function updatePrice(uint256 newPrice) public onlyOwner {
    //     _price = newPrice;
    // }
    
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId),"ERC721AMetadata: URI query for nonexistent token");
        string memory currentBaseURI = _baseURI();
        return _baseURI();
        // return string(abi.encodePacked(currentBaseURI, "CH_token_metadata", _baseExtension))
        // tokenId.toString();
        // return bytes(currentBaseURI).length > 0 ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), _baseExtension)) : "";
    }

    // function updateMaxTokens(uint256 newMax) public onlyOwner {
    //     _maxTokens = newMax;
    // }

    // function updateMaxMint(uint256 newMax) public onlyOwner {
    //     _maxMint = newMax;
    // }

    // function updateMaxPresaleMint(uint256 newMax) public onlyOwner {
    //     _maxPresaleMint = newMax;
    // }

    // function mintItems(uint256 _quantity)
    //     public
    //     payable
    //     callerIsUser
    //     hasCorrectAmount(msg.value, _quantity)
    // {
    //     require(
    //         _quantity > 0 &&
    //             _saleMints[msg.sender] + _quantity <=
    //             _maxMint,
    //         "Minting above public limit"
    //     );
    // }

    // function presaleMintItems (
    //     uint256 _quantity,
    //     bytes32[] calldata proof
    // )
    //  external payable callerIsUser
    //  hasCorrectAmount(msg.value, _quantity)
    // {
    //     require(msg.value >= _quantity * _price);
    //     require(_presaleMints[msg.sender] + _quantity <= _maxPresaleMint, "Exceeds mint amount per wallet!");
    //     require(_presaleActive);
    //     require(MerkleProof.verify(proof, merkleRoot, keccak256(abi.encodePacked(msg.sender))), "You are not whitelisted!");

    //     uint256 totalMinted = _tokenIds.current();

    //     require(totalMinted + _quantity <= _maxTokens);

    //     _presaleMints[msg.sender] += _quantity;
    //     _mintItem(msg.sender, _quantity);
    // }
    
    // function _mintItem(address to, uint256 _quantity) internal returns (uint256) {
    //     _tokenIds.increment();
    //     uint256 id = _tokenIds.current();
    //     _safeMint(to, _quantity);
    //     return id;
    // }

    // uint256 public CH_Fund = 8 ether;
    // address public CH_FundWalletAddr = 0x150a8aB5BF28b07bE181E4365486a0Fd67EADbcF;

    // function updateFund(uint256 newFund) public onlyOwner {
    //     CH_Fund = newFund;
    // }

    // function withdrawToCHFund(address to) external onlyOwner {
    //     require(address(this).balance >= CH_Fund);
    //     payable(CH_FundWalletAddr).transfer(CH_Fund);
    // }

    function withdraw(address to, uint256 amount) external onlyOwner {
        require(address(this).balance >= amount);
        payable(to).transfer(amount);
    }

    function mint(uint256 quantity) external onlyOwner {
        _safeMint(msg.sender, quantity);
    }
}