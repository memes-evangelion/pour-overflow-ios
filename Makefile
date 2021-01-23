export MODIFIED_FILES = git diff --name-status --diff-filter=d origin/master HEAD -- '*.swift'

lint: bin/swiftlint
	@$(MODIFIED_FILES) | xargs bin/swiftlint lint

bin/swiftlint:
	@mkdir -p bin
	@cd bin; curl -L -O https://github.com/realm/SwiftLint/releases/download/0.42.0/portable_swiftlint.zip; \
	unzip -o portable_swiftlint.zip; \
	rm -rf portable_swiftlint.zip; rm LICENSE

clean:
	@rm -rf bin/*

.PHONY: lint clean
