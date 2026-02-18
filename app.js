const DEX_ADDRESS = "PASTE_DEX_ADDRESS";

const ABI = [
  "function addLiquidity(uint,uint)",
  "function swapAforB(uint)",
  "function swapBforA(uint)"
];

let signer;
let dex;

const statusEl = document.getElementById("status");

document.getElementById("connect").onclick = async () => {
  const provider = new ethers.BrowserProvider(window.ethereum);
  await provider.send("eth_requestAccounts", []);
  signer = await provider.getSigner();

  dex = new ethers.Contract(DEX_ADDRESS, ABI, signer);

  statusEl.innerText = "Connected";
};

document.getElementById("add").onclick = async () => {
  const a = document.getElementById("a1").value;
  const b = document.getElementById("b1").value;

  const tx = await dex.addLiquidity(
    ethers.parseUnits(a,18),
    ethers.parseUnits(b,18)
  );

  await tx.wait();
  statusEl.innerText = "Liquidity added";
};

document.getElementById("swapAB").onclick = async () => {
  const a = document.getElementById("swapA").value;

  const tx = await dex.swapAforB(
    ethers.parseUnits(a,18)
  );

  await tx.wait();
  statusEl.innerText = "Swapped A → B";
};

document.getElementById("swapBA").onclick = async () => {
  const b = document.getElementById("swapB").value;

  const tx = await dex.swapBforA(
    ethers.parseUnits(b,18)
  );

  await tx.wait();
  statusEl.innerText = "Swapped B → A";
};
