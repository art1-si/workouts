.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

install-dependencies: ## Runs commands to install various dependencies (Flutter packages, …)
	flutter pub get
	flutter gen-l10n
	flutter packages pub run build_runner build --delete-conflicting-outputs
	./security/vault.sh decrypt

refresh: ## Runs flutter pub get and generates l10n
	flutter pub get
	flutter gen-l10n

run-tests: ## Runs the tests
	@echo "Ensure the *.mocks.dart files are generated by running 'flutter packages pub run build_runner build --delete-conflicting-outputs'"
	flutter test test/subjects/**/*_tests.dart --coverage --coverage-path="test/coverage/lcov.info"
	genhtml test/coverage/lcov.info -o test/coverage/html

check-signing: ## Performs checks on code/app signing
	cd ./android && ./gradlew signingReport

run-production: ## Runs production.
	flutter gen-l10n
	flutter run --flavor production --dart-define="CONFIGURATION=production"


run-uat: ## Runs UAT.
	flutter gen-l10n
	flutter run --flavor uat --dart-define="CONFIGURATION=uat"


run-dev: ## Runs dev.
	flutter gen-l10n
	flutter run --flavor dev  --dart-define="CONFIGURATION=dev"


internal-bundle: ## Makes internal builds for android and iOS.
	@$(MAKE) android-internal
	@$(MAKE) ios-internal

android-internal: ## Makes an Android internal build.
	flutter clean
	flutter gen-l10n
	flutter build apk --flavor internal --dart-define="CONFIGURATION=internal"


ios-internal: ## Makes an iOS internal build.
	pod --version
	flutter clean
	flutter gen-l10n
	flutter build ipa --flavor internal --dart-define="CONFIGURATION=internal" --export-options-plist="ios/exportOptions/exportOptions-release-internal.plist"


uat-bundle: ## Makes UAT builds for android and iOS.
	@$(MAKE) android-uat
	@$(MAKE) ios-uat

android-uat: ## Makes an Android UAT build.
	flutter clean
	flutter gen-l10n
	flutter build apk --flavor uat --dart-define="CONFIGURATION=uat"


ios-uat: ## Makes an iOS UAT build.
	pod --version
	flutter clean
	flutter gen-l10n
	flutter build ipa -v --flavor uat --dart-define="CONFIGURATION=uat" --export-options-plist="ios/exportOptions/exportOptions-release-uat.plist"


android-acceptance: ## Makes an Android Release acceptance build.
	flutter clean
	flutter gen-l10n
	flutter build apk --flavor acceptance --dart-define="CONFIGURATION=acceptance"


ios-acceptance: ## Makes an iOS Release acceptance build.
	flutter clean
	flutter gen-l10n
	flutter build ipa --flavor acceptance --dart-define="CONFIGURATION=acceptance"
	


android-production: ## Makes a Android Production build.
	flutter clean
	flutter build apk --obfuscate --dart-define="CONFIGURATION=production" --flavor production --split-debug-info=./symbols/
	cd build/app/intermediates/merged_native_libs/productionRelease/out/lib/ && zip -r ./native-debug-symbols.zip ./ && cd - && mv build/app/intermediates/merged_native_libs/productionRelease/out/lib/native-debug-symbols.zip .
	@echo "Symbols exported to ./native-debug-symbols.zip. \nThese can be uploaded through the Play Console under 'App bundle explorer', in the 'Downloads' tab for the version, last item under 'Assets'"

ios-production: ## Makes an iOS production build.
	flutter clean
	flutter gen-l10n
	flutter build ipa --flavor production --dart-define="CONFIGURATION=production" --export-options-plist="ios/exportOptions/exportOptions-release-production.plist"