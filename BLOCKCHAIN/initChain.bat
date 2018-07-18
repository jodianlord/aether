geth -identity "aetherchain" init .\genesis.json -datadir .\aetherChain
PAUSE
geth --bootnodes enode://343503a593bac7db3a829e7fc423d68422fb21bed4e88482bcdf58095f0274efe3dc664b9a5bb1d81638f60290b09342fb2d9ab6fa60450374777f1d55c30a3b@[127.0.0.1]:30305 --rpc --rpcapi "admin,miner,db,eth,net,web3,personal" --datadir .\aetherChain --networkid 9876 console
PAUSE