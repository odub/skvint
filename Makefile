.PHONY: all
all: deps

.PHONY: clean
clean:
	rm -rf ./packages/*

.PHONY: deps
deps: packages/brightness packages/sunwait packages/coreutils packages/npm

packages/brightness:
	mkdir -p ./packages/brightness
	git clone https://github.com/nriley/brightness.git ./packages/brightness
	make -C ./packages/brightness

packages/sunwait:
	mkdir -p ./packages/sunwait
	git clone https://github.com/RalphBln/sunwait-multiplatform ./packages/sunwait
	make -C ./packages/sunwait

.PHONY: packages/coreutils
packages/coreutils:
	brew list coreutils &>/dev/null || brew install coreutils

.PHONY: packages/npm
package/npm:
	npm install

.PHONY: install
install:
	ln -sf $$PWD/skvint /usr/local/bin
	mkdir -p /usr/local/var/skvint/
	cp -f ./com.oscardub.skvint.plist ~/Library/LaunchAgents/
	launchctl load -w ~/Library/LaunchAgents/com.oscardub.skvint.plist

.PHONY: uninstall
uninstall:
	unlink /usr/local/bin/skvint
	launchctl unload -w ~/Library/LaunchAgents/com.oscardub.skvint.plist
	rm ~/Library/LaunchAgents/com.oscardub.skvint.plist
