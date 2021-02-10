install:
	swift build -c release
	install .build/release/platform /usr/local/bin/platform
