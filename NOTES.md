**The blockchain**: Think of it as a cloud provider, kinda like AWS, but it's owned by no one. It's run by compute power from mining machines all over the world. Usually these people are called miners, and we pay them to run our code!

**A smart contract**: Kinda like our server's code with different functions people can hit.

This is pretty much the basis of most smart contracts. Read functions. Write functions. And changing a state variable. After this lesson we have the building blocks we need now to keep on working on our epic WavePortal.

In the last commit when I run scripts/run.js it's actually:

1. Creating a new local Ethereum network.
2. Deploying your contract.
3. Then, when the script ends Hardhat will automatically destroy that local network.

To keep a local network alive we run:

```
npx hardhat node
```

And the command to run to deploy locally is:

```
npx hardhat run scripts/deploy.js --network localhost
```

El [**GAS**](https://www.buda.com/guias/que-es-ethereum?__cf_chl_jschl_tk__=4Pwd.8YqokhpPKBo_WySqSnZofwcM6dFo5KtaNaJ_VE-1640475696-0-gaNycGzNCL0#qu%C3%A9-es-el-gas) es la unidad que mide el trabajo computacional requerido para ejecutar una acción en la red de Ethereum, ya sea procesar una simple transacción de ethers entre direcciones ETH, o ejecutar un smart contract complejo.
