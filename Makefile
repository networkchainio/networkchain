# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: netk android ios netk-cross swarm evm all test clean
.PHONY: netk-linux netk-linux-386 netk-linux-amd64 netk-linux-mips64 netk-linux-mips64le
.PHONY: netk-linux-arm netk-linux-arm-5 netk-linux-arm-6 netk-linux-arm-7 netk-linux-arm64
.PHONY: netk-darwin netk-darwin-386 netk-darwin-amd64
.PHONY: netk-windows netk-windows-386 netk-windows-amd64

GOBIN = build/bin
GO ?= latest

netk:
	build/env.sh go run build/ci.go install ./cmd/netk
	@echo "Done building."
	@echo "Run \"$(GOBIN)/netk\" to launch netk."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

evm:
	build/env.sh go run build/ci.go install ./cmd/evm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/evm\" to start the evm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/netk.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Netk.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/jteeuwen/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go install ./cmd/abigen

# Cross Compilation Targets (xgo)

netk-cross: netk-linux netk-darwin netk-windows netk-android netk-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/netk-*

netk-linux: netk-linux-386 netk-linux-amd64 netk-linux-arm netk-linux-mips64 netk-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-*

netk-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/netk
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep 386

netk-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/netk
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep amd64

netk-linux-arm: netk-linux-arm-5 netk-linux-arm-6 netk-linux-arm-7 netk-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep arm

netk-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/netk
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep arm-5

netk-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/netk
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep arm-6

netk-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/netk
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep arm-7

netk-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/netk
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep arm64

netk-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/netk
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep mips

netk-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/netk
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep mipsle

netk-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/netk
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep mips64

netk-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/netk
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/netk-linux-* | grep mips64le

netk-darwin: netk-darwin-386 netk-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/netk-darwin-*

netk-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/netk
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/netk-darwin-* | grep 386

netk-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/netk
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/netk-darwin-* | grep amd64

netk-windows: netk-windows-386 netk-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/netk-windows-*

netk-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/netk
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/netk-windows-* | grep 386

netk-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/netk
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/netk-windows-* | grep amd64
