geth -identity "aetherchain" init .\genesis.json -datadir .\aetherChain
PAUSE
geth --bootnodes enode://18b44cfa9e4d09af5335f4e2aa000b23c7f7aa2c1b5c4b562782b07e9951934ed64555b476eba5b347c2b057e991324a5e44ded08d547b7b5f772420ad054ba3@[118.189.176.3]:30305 --rpc --rpcapi "admin,miner,db,eth,net,web3,personal" --datadir .\aetherChain --networkid 9876 console
PAUSE