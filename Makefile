.PHONY: build build-ios build-mac \
  generate-podspecs \
  increment-version tag-version tag-version-bump publish-pod publish

NAME ?= OpenTracing
PROJECT ?= $(NAME).xcodeproj

FORMATTER ?= $(shell which xcpretty 2>/dev/null)
ifneq ($(FORMATTER),)
FORMATTER := | $(FORMATTER) && exit $${PIPESTATUS[0]}
endif

SRCS := $(wildcard Sources/*/*.swift)

SIMULATOR_FLAGS = -destination 'id=$(shell python tools/newest-sim.py)' \
	ONLY_ACTIVE_ARCH=YES

XCODEBUILD = xcodebuild \
	-project "$(PROJECT)" \
	-configuration Release \
	-scheme "$(NAME)-Package" \
	$(SIMULATOR_FLAGS)

build: build-ios build-mac

build-ios: $(PROJECT) $(SRCS)
	$(XCODEBUILD) clean build $(FORMATTER)

build-mac: Package.swift $(SRCS)
	swift package clean && swift build

$(PROJECT): Package.swift
	swift package generate-xcodeproj \
		--xcconfig-overrides tools/settings.xcconfig \
		--output $(PROJECT)

project:
	make -B $(PROJECT)  # -B forces the command to run

OpenTracingSwift.podspec: OpenTracingSwift.podspec.src VERSION
	sed 's/_VERSION_STRING_/$(shell cat VERSION)/g' OpenTracingSwift.podspec.src > OpenTracingSwift.podspec

increment-version:
	awk 'BEGIN { FS = "." }; { printf("%d.%d.%d", $$1, $$2, $$3+1) }' VERSION > VERSION.incr
	mv VERSION.incr VERSION

tag-version:
	git add .
	git commit -m "Increment version to $(shell cat VERSION)"
	git tag $(shell cat VERSION)
	git push -u origin master
	git push -u origin master --tags
	@echo Incremented version to `cat VERSION`

tag-version-bump: increment-version generate-podspecs tag-version

publish-pod:
	pod trunk push --verbose lightstep.podspec

publish: tag-version-bump publish-pod