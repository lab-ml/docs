# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = source
BUILDDIR      = build
PYCMD         = python
PAGES_REPO    = pages

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)


# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
build:
	$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

open:
	@open build/html/index.html

clean:
	@echo "Removing everything under 'build'.."
	@rm -rf $(BUILDDIR)/html/ $(BUILDDIR)/doctrees

rebuild: clean build

pages: rebuild
	@cd ../$(PAGES_REPO); git pull
	@cp -r $(BUILDDIR)/html/* ../$(PAGES_REPO)

.PHONY: build clean help
