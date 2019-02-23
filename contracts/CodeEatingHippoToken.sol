pragma solidity >=0.4.21 < 0.6.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-solidity/contracts/access/roles/MinterRole.sol";

contract CodeEatingHippoToken is ERC721Full("CodeEatingHippo", "CEH"), MinterRole {
    struct Hippo {
        string hippoUri; // swarm uri
        string email; // email
        address attendee;
    }

    uint256 constant public QTY_LIMIT = 50;
    // (eventId => quantity)
    mapping(uint256 => uint8) public quantity;
    // (eventId => details)
    mapping(uint256 => Hippo) public details;

    function attend(address _attendee) public onlyMinter returns (bool) {
        uint256 eventId = now.div(7);
        _mint(_attendee, uint256(keccak256(abi.encodePacked(_attendee, eventId))));
    }
}
