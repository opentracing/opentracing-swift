.PHONY: build

NAME ?= OpenTracing
PROJECT ?= $(NAME).xcodeproj

FORMATTER ?= $(shell which xcpretty 2>/dev/null)
ifneq ($(FORMATTER),)
FORMATTER := | $(FORMATTER) && exit $${PIPESTATUS[0]}
endif

SIMULATOR_FLAGS = -destination 'id=$(shell python tools/newest-sim.py)' \
	ONLY_ACTIVE_ARCH=YES

XCODEBUILD = xcodebuild \
	-project "$(PROJECT)" \
	-configuration Release \
	-scheme "$(NAME)-Package" \
	$(SIMULATOR_FLAGS)

build: build-ios build-mac

build-ios: $(PROJECT)
	$(XCODEBUILD) clean build $(FORMATTER)

build-mac:
	swift package clean && swift build

$(PROJECT):
	swift package generate-xcodeproj \
		--xcconfig-overrides tools/settings.xcconfig \
		--output $(PROJECT)