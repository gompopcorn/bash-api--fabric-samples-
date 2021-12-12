#!/bin/bash

test_network_dir="/usr/local/go/src/github.com/hyperledger/fabric-samples/test-network"
fabric_samples_dir="/usr/local/go/src/github.com/hyperledger/fabric-samples"


# the path is in the 'fabric-samples' directory
export PATH=${test_network_dir}/../bin:$PATH
export FABRIC_CFG_PATH=$test_network_dir/../config/

# install one peer0 Org1
cd ${test_network_dir}
. ./scripts/envVar.sh

# use Org1
setGlobals 1

# create the car
peer chaincode query -C channel1 -n fabcar -c '{"Args": ["queryAllCars"]}'

