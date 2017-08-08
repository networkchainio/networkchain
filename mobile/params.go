// Copyright 2016 The go-networkchain Authors
// This file is part of the go-networkchain library.
//
// The go-networkchain library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-networkchain library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-networkchain library. If not, see <http://www.gnu.org/licenses/>.

// Contains all the wrappers from the params package.

package netk

import (
	"encoding/json"

	"github.com/networkchain/go-networkchain/core"
	"github.com/networkchain/go-networkchain/p2p/discv5"
	"github.com/networkchain/go-networkchain/params"
)

// MainnetGenesis returns the JSON spec to use for the main NetworkChain network. It
// is actually empty since that defaults to the hard coded binary genesis block.
func MainnetGenesis() string {
	return ""
}

// TestnetGenesis returns the JSON spec to use for the NetworkChain test network.
func TestnetGenesis() string {
	enc, err := json.Marshal(core.DefaultTestnetGenesisBlock())
	if err != nil {
		panic(err)
	}
	return string(enc)
}

// FoundationBootnodes returns the enode URLs of the P2P bootstrap nodes operated
// by the foundation running the V5 discovery protocol.
func FoundationBootnodes() *Enodes {
	nodes := &Enodes{nodes: make([]*discv5.Node, len(params.DiscoveryV5Bootnodes))}
	for i, url := range params.DiscoveryV5Bootnodes {
		nodes.nodes[i] = discv5.MustParseNode(url)
	}
	return nodes
}