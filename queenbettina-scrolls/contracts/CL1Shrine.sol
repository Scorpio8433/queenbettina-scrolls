// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract CL1Shrine {
    struct Scroll {
        address recipient;
        string emotionalTag;
        string sanctum;
        string blessing;
        bool sealed;
    }

    mapping(address => Scroll) public scrolls;
    address public sovereign;

    event ScrollInscribed(address indexed recipient, string emotionalTag);
    event ScrollSealed(address indexed recipient);

    constructor() {
        sovereign = msg.sender;
    }

    function inscribeScroll(
        address _recipient,
        string memory _emotionalTag,
        string memory _sanctum,
        string memory _blessing
    ) public {
        require(msg.sender == sovereign, "Not authorized");
        scrolls[_recipient] = Scroll(_recipient, _emotionalTag, _sanctum, _blessing, false);
        emit ScrollInscribed(_recipient, _emotionalTag);
    }

    function sealScroll(address _recipient) public {
        require(msg.sender == sovereign, "Not authorized");
        require(!scrolls[_recipient].sealed, "Already sealed");
        scrolls[_recipient].sealed = true;
        emit ScrollSealed(_recipient);
    }

    function getScroll(address _recipient) public view returns (Scroll memory) {
        return scrolls[_recipient];
    }
}
