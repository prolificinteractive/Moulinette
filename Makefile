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