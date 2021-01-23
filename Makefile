lint:
	@test -x bin/swiftlint || echo "`tput setaf 1`Error: linter not found. Run **make install**.`tput sgr 0`"
	@bin/swiftlint

install:
	@mkdir -p bin
	@cd bin; curl -L -O https://github.com/realm/SwiftLint/releases/download/0.42.0/portable_swiftlint.zip; \
	unzip -o portable_swiftlint.zip; \
	rm -rf portable_swiftlint.zip; rm LICENSE

clean:
	@rm -rf bin/*

.PHONY: install lint clean
