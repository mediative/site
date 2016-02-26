HUGO := $(shell type -p hugo)

site:
	hugo

deploy-site: site
	tools/deploy-site.sh

setup:
	git submodule init
	git submodule update
ifndef HUGO
	go get -u -v github.com/spf13/hugo
endif

.PHONY: site deploy-site setup
