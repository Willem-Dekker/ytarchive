#!/bin/bash
if [[ "$1" = "t" ]]; then
    go build -race -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)"
elif [[ -n "$1" ]]; then
    CGO_ENABLED=0 go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)"
    GOOS=windows GOARCH=amd64 go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)"
    GOOS=linux GOARCH=arm GOARM=7 go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)" -o ytarchive_armv7l
    GOOS=linux GOARCH=arm GOARM=6 go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)" -o ytarchive_armv6
    GOOS=linux GOARCH=arm64 go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)" -o ytarchive_arm64
    GOOS=windows GOARCH=arm64 go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)" -o ytarchive_arm64.exe
    GOOS=linux GOARCH=mips GOMIPS=softfloat go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)" -o ytarchive_mips
    GOOS=linux GOARCH=mipsle GOMIPS=softfloat go build -ldflags "-X main.Commit=-$(git rev-parse --short HEAD)" -o ytarchive_mipsle
else
    CGO_ENABLED=0 go build
    GOOS=windows GOARCH=amd64 go build
    GOOS=linux GOARCH=arm GOARM=7 go build -o ytarchive_armv7l
    GOOS=linux GOARCH=arm GOARM=6 go build -o ytarchive_armv6
    GOOS=linux GOARCH=arm64 go build -o ytarchive_arm64
    GOOS=windows GOARCH=arm64 go build -o ytarchive_arm64.exe
    GOOS=linux GOARCH=mips GOMIPS=softfloat go build -o ytarchive_mips
    GOOS=linux GOARCH=mipsle GOMIPS=softfloat go build -o ytarchive_mipsle
fi

zip ytarchive_linux_amd64.zip ytarchive
zip ytarchive_windows_amd64.zip ytarchive.exe
zip ytarchive_linux_armv7l.zip ytarchive_armv7l
zip ytarchive_linux_armv6.zip ytarchive_armv6
zip ytarchive_linux_arm64.zip ytarchive_arm64
zip ytarchive_windows_arm64.zip ytarchive_arm64.exe
zip ytarchive_linux_mips.zip ytarchive_mips
zip ytarchive_linux_mipsle.zip ytarchive_mipsle

sha256sum ytarchive_linux_amd64.zip ytarchive_windows_amd64.zip ytarchive_linux_armv7l.zip ytarchive_linux_armv6.zip ytarchive_linux_mips.zip ytarchive_linux_mipsle.zip ytarchive_windows_arm64.zip ytarchive_linux_arm64.zip > SHA2-256SUMS
