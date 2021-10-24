pragma ton-solidity >= 0.50.0;
pragma AbiHeader expire;

contract Nfts {

    Token[] tokensCollection;
    Order[] orders;

    struct Token {
        string name;
        string typeOriginal;
        uint uniquenessDegree;
        uint releaseDate;
        bool preEdited;
    }
    struct Order {
        uint id;
        uint price;
    }

    mapping(uint => uint) tokenToOwner;
    mapping(uint => uint) orderToOwner;

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function getLastTokenId() private returns(uint) {
        uint tokenId = tokensCollection.length;
        if (tokensCollection.length == 0) {
            tokenId = tokensCollection.length;
        } else {
            tokenId = tokensCollection.length - 1;
        }
        return tokenId;
    }

    modifier tokenUniqueness(string name) {
        tvm.accept();
        uint tokenId = getLastTokenId();
        uint uniqstatus = 0;
        if (tokenId == tokensCollection.length) {
            uniqstatus = uniqstatus;
        } else {
            for (uint i = 0; i <= tokenId; i++) {
                if (tokensCollection[i].name == name) {
                    uniqstatus = uniqstatus + 1;
                } else {
                    uniqstatus = uniqstatus;
                }
            }
        }

        require(uniqstatus == 0, 102);
        _;
    }

    function returnLength() private returns(uint) {
        tvm.accept();
        uint length = tokensCollection.length;
        return length;
    }

    function createToken(string name, string typeOriginal, uint uniquenessDegree, uint releaseDate, bool preEdited) public tokenUniqueness(name) {
        tvm.accept();
        uint tokenId = tokensCollection.length;
        tokensCollection.push(Token(name, typeOriginal, uniquenessDegree, releaseDate, preEdited));
        tokenToOwner[tokenId] = msg.pubkey();
    }

    function getTokenInfo(uint tokenId) public view returns(string name, string typeOriginal, uint uniquenessDegree, uint releaseDate, bool preEdited) {
        tvm.accept();
        string name = tokensCollection[tokenId].name;
        string typeOriginal = tokensCollection[tokenId].typeOriginal;
        uint uniquenessDegree = tokensCollection[tokenId].uniquenessDegree;
        uint releaseDate = tokensCollection[tokenId].releaseDate;
        bool preEdited = tokensCollection[tokenId].preEdited;
        return (name, typeOriginal, uniquenessDegree, releaseDate, preEdited);
    }

    function getTokenOwner(uint tokenId) public view returns(uint) {
        tvm.accept();
        return tokenToOwner[tokenId];
    }

    function makeOrder(uint tokenId, uint price) checkOwnerAndAccept public {
        orders.push(Order(tokenId, price));
        orderToOwner[tokenId] = msg.pubkey();
    }

    function seeOrders(uint tokenId) public view returns(uint tokenIdentifier, uint tokenOwner, uint orderPrice) {
        tvm.accept();
        tokenOwner = orderToOwner[tokenId];
        orderPrice = orders[tokenId].price;
    }

    function showTokensCollection() public view returns(Token[]) {
        tvm.accept();
        return tokensCollection;
    }

}