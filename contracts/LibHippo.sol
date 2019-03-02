pragma solidity >=0.4.21 < 0.6.0;
import "openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";

library LibHippo {
    struct Hippo {
        uint256 dna;
        string resUri; // swarm uri
        uint32 numOfClones;
        uint32 maxNum;
        uint256 birthTimestamp;
    }

    function newHippo(string memory _resUri, uint32 _maxNum) internal view returns(Hippo memory _hippo) {
        _hippo.birthTimestamp = now;
        _hippo.maxNum = _maxNum;
        _hippo.dna = uint256(keccak256(abi.encodePacked(_resUri)));
        // Tokens Id is made by subtracting owner address from the dna value. And it should not be ZERO
        require(_hippo.dna > uint32(0) - 1, "This DNA is not appropriate for hippo");
        _hippo.resUri = _resUri;
        return _hippo;
    }

    function getHippoId(uint256 _dna, address _owner) public pure returns (uint256) {
        return _dna - uint256(_owner);
    }

    function getHippoDnaFromId(IERC721 _hippoContract, uint256 _tokenId) public view returns (uint256) {
        address owner = _hippoContract.ownerOf(_tokenId);
        return _tokenId + uint256(owner);
    }
}
