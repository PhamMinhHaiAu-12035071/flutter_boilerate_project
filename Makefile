.PHONY: help
help: ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

.PHONY: install
install: ## install all dependencies
	npm install \
	&& flutter pub get

.PHONY: rebuild
rebuild: ## clean and generate file *.g.dart again
	flutter pub run build_runner clean \
	&& flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: generate-template-l10n
generate-template-l10n: ## generate template language
	flutter pub run intl_generator:extract_to_arb \
        --output-dir=lib/localization/arb_files \
        lib/localization/app_localization.dart

.PHONY: generate-from-arb
generate-from-arb: ## run this command which converts those JSON maps into .dart files.
	flutter pub run intl_generator:generate_from_arb \
        --output-dir=lib/localization/dart_files \
        --no-use-deferred-loading lib/localization/app_localization.dart \
        lib/localization/arb_files/intl_en.arb \
        lib/localization/arb_files/intl_ja.arb