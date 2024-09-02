const { ethers } = require("hardhat");

async function main() {
  const [deployer, ...otherAccounts] = await ethers.getSigners();
  const AddressCrowd = deployer.address;
  const AddressAccounts = [];
  otherAccounts.forEach((account, index) => {
    AddressAccounts.push(account.address)
  });

  console.log(AddressAccounts.length)
  const nomeCampagna = "Prova";
  const latitudine = 123564;
  const longitudine = 234561;
  const Campaign = await ethers.getContractFactory("Campaign");
  const campaign = await Campaign.deploy(nomeCampagna,latitudine,longitudine);
  await campaign.deployed();

  for(var i = 0;i<AddressAccounts.length;i++){
    var rank = Math.floor(Math.random() * 10) + 1;
    var status = true;
    await campaign.AddDevice(AddressAccounts[i],rank,status);
  }
  //await campaign.setStatus();
  const deviceCount = await campaign.getDeviceCount();
  console.log("numero di device totali:", deviceCount);
  console.log("Device",await campaign.getDevice());
  await campaign.AddDeviceTop();
  console.log("Numero device top:" , await campaign.getDeviceTopCount());
  console.log("Top Device:" , await campaign.getDeviceTop());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Errore durante il deploy:", error);
    process.exit(1);
  });
