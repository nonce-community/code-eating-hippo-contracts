pragma solidity >=0.4.21 < 0.6.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-solidity/contracts/access/roles/MinterRole.sol";
import {LibHippo} from "./LibHippo.sol";

contract CodeEatingHippo is ERC721Full("CodeEatingHippo", "CEH"), MinterRole {
    using SafeMath for uint256;
    using LibHippo for LibHippo.Hippo;
    using LibHippo for IERC721;

    // (DNA => Hippo details data)
    mapping(uint256 => LibHippo.Hippo) public hippos;
    // all DNAs
    uint256[] public dnaList;

    function createHippo(string memory _resUri, uint32 _maxNum) public onlyMinter returns (uint256 _dna) {
        // Create a new hippo instance
        LibHippo.Hippo memory hippo = LibHippo.newHippo(_resUri, _maxNum);
        // Check that if a hippo with same DNA exists or not
        require(hippos[hippo.dna].dna == uint256(0), "A hippo with the same DNA already exists");
        // Add the newly assigned hippo object into the map
        hippos[hippo.dna] = hippo;
        // Add the DNA of newly created hippo into the DNA list
        dnaList.push(hippo.dna);
        return hippo.dna;
    }

    function cloneHippo(address _to, uint256 _dna) public onlyMinter returns (uint256 _hippoId) {
        // Retrieve Hippo data from map with the DNA
        LibHippo.Hippo storage hippo = hippos[_dna];
        // Hippo data should exist in the map
        require(hippo.dna != uint256(0), "should exist in the map");
        // Cloning is only allowed in a week after its first creation
        require(now < hippo.birthTimestamp.add(604800), "Hippo can be cloned only in a week after the creation");
        // Hippo can not be cloned more than its maximum clone number
        require(hippo.numOfClones < hippo.maxNum, "It exceeds the maximum number of clones");
        // Increase the count of clones
        hippo.numOfClones += 1;
        // Mint a non-fungible hippo with the DNA and assign _to address as its owner
        _hippoId = LibHippo.getHippoId(_dna, _to);
        _mint(_to, _hippoId);
    }

    function getHippo(uint256 _hippoId) public view returns (
        uint256 _dna,
        string memory _resUri,
        uint32 _numOfClones,
        uint32 _maxNum,
        uint256 _birthTimestamp
    ) {
        // Retrieve DNA using library
        uint256 dna = IERC721(this).getHippoDnaFromId(_hippoId);
        // Retrieve the hippo data corresponding to that DNA
        LibHippo.Hippo storage hippo = hippos[dna];
        // Hippo data should exist
        require(hippo.dna != uint256(0), "Hippo data should exist");
        // Return data
        return (hippo.dna, hippo.resUri, hippo.numOfClones, hippo.maxNum, hippo.birthTimestamp);
    }
}
