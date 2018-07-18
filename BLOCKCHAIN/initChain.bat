geth -identity "aetherchain" init .\genesis.json -datadir .\aetherChain
PAUSE
geth --rpc --rpcapi "admin,miner,db,eth,net,web3,personal" --datadir .\aetherChain networkid 9876 