sphinx-help: ## Sphinx help
	@sphinx-build -M help source build

build: ## Build docs
	@sphinx-build -M html source build

open: ## Open docs
	@open build/html/index.html

clean: ## Clean
	@echo "Removing everything under 'build'.."
	@rm -rf build/html/ build/doctrees

rebuild: clean build ## Rebuild docs

pages: rebuild ## Create pages
	@cd ../pages; git pull
	@cp -r build/html/* ../pages

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: build clean help sphinx-help pages rebuild
.DEFAULT_GOAL := help
