// Copyright 2016 The networkchain Authors
// This file is part of the networkchain library.
//
// The networkchain library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The networkchain library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the networkchain library. If not, see <http://www.gnu.org/licenses/>.

package ethclient

import "github.com/networkchain/networkchain"

// Verify that Client implements the networkchain interfaces.
var (
	_ = networkchain.ChainReader(&Client{})
	_ = networkchain.TransactionReader(&Client{})
	_ = networkchain.ChainStateReader(&Client{})
	_ = networkchain.ChainSyncReader(&Client{})
	_ = networkchain.ContractCaller(&Client{})
	_ = networkchain.GasEstimator(&Client{})
	_ = networkchain.GasPricer(&Client{})
	_ = networkchain.LogFilterer(&Client{})
	_ = networkchain.PendingStateReader(&Client{})
	// _ = networkchain.PendingStateEventer(&Client{})
	_ = networkchain.PendingContractCaller(&Client{})
)
