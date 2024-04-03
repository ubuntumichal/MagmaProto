const web3 = new Web3(Web3.givenProvider);

// Contract address and ABI
const contractAddress = 'CONTRACT_ADDRESS';
const contractABI = [
    // Include the ABI here
];

const contract = new web3.eth.Contract(contractABI, contractAddress);

// List NFT form submission
document.getElementById('listForm').addEventListener('submit', async (event) => {
    event.preventDefault();
    const tokenId = document.getElementById('tokenId').value;
    const price = document.getElementById('price').value;
    await contract.methods.listToken(tokenId, price).send({ from: web3.eth.accounts[0] });
    alert('NFT listed successfully!');
});

// Buy NFT form submission
document.getElementById('buyForm').addEventListener('submit', async (event) => {
    event.preventDefault();
    const tokenId = document.getElementById('tokenId').value;
    await contract.methods.buyToken(tokenId).send({ from: web3.eth.accounts[0], value: web3.utils.toWei(price, 'ether') });
    alert('NFT purchased successfully!');
});

