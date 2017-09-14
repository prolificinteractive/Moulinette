# Moulinette makefile

install:
	make install-documentation

install-documentation:
	gem install jazzy

documentation:
	make documentation-moulinette
	make documentation-test

documentation-moulinette:
	jazzy --min-acl private  --module Moulinette --skip-undocumented

documentation-test:
	jazzy --min-acl private  --module Moulinette_Tests --xcodebuild-arguments test,-scheme,Moulinette-Tests --skip-undocumented -o docs-test

ci-audit:
	xcodebuild \
	-project Moulinette-2.0.xcodeproj \
	-target Moulinette-2.0 \
	-configuration Release
	./build/Release/Moulinette-2.0 -projectName ${projectName} -projectIdentifier ${projectIdentifier} -projectDirectory ../../ -silentMode false

local-audit:
	xcodebuild \
	-project Moulinette-2.0.xcodeproj \
	-target Moulinette-2.0 \
	-configuration Release
	./build/Release/Moulinette-2.0 -projectName ${projectName} -projectIdentifier ${projectIdentifier} -projectDirectory ${projectDirectory} -silentMode true

tests:
	xcodebuild \
  -project Moulinette-2.0.xcodeproj \
  -scheme Moulinette-2.0-Tests \
  -destination 'platform=macOS,arch=x86_64' \
  test | xcpretty --test --color
