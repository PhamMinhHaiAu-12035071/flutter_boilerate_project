.PHONY: help
help: ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

.PHONY: install
install: ## install all dependencies
	npm install \
	&& flutter pub get

.PHONY: rebuild ## clean and generate file *.g.dart again
rebuild:
	flutter pub run build_runner clean && flutter pub run build_runner build --delete-conflicting-outputs