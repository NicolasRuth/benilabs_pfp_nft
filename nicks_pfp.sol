pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ProfilePicture is ERC721, Ownable {
    string private ipfsAddress;
    address private constant allowedWallet = 0xab19f8F25cc001B57242FF60c6D6dF4D603dc5EA;

    constructor() ERC721("Profile Picture", "PP") {}

    function setIpfsAddress(string calldata _ipfsAddress) external onlyOwner {
        ipfsAddress = _ipfsAddress;
    }

    function mintProfilePicture() external {
        require(msg.sender == allowedWallet, "Only the allowed wallet can mint");
        require(bytes(ipfsAddress).length > 0, "IPFS address not set");

        uint256 tokenId = totalSupply() + 1;
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return ipfsAddress;
    }
}
