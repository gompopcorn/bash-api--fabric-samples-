#!/bin/bash

test_network_dir="/usr/local/go/src/github.com/hyperledger/fabric-samples/test-network"
fabric_samples_dir="/usr/local/go/src/github.com/hyperledger/fabric-samples"


# the path is in the 'fabric-samples' directory
export PATH=${fabric_samples_dir}/bin:$PATH
export FABRIC_CFG_PATH=$fabric_samples_dir/config/

# install one peer0 Org1
cd ${test_network_dir}
. ./scripts/envVar.sh

# use Org1
setGlobals $1

# create the car
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls \
--cafile ${test_network_dir}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem \
-C mychannel -n fabcar --peerAddresses localhost:7051 \
--tlsRootCertFiles ${test_network_dir}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt \
--peerAddresses localhost:9051 --tlsRootCertFiles ${test_network_dir}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt \
-c '{"function":"createCar", "Args":["'$2'", "'$3'", "'$4'", "'$5'", "'$6'"]}'

