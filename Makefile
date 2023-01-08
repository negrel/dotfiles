SHELL = bash
SECRET_FILES := $(shell find . -name '*.secret')

.PHONY: build-iso/%
build-iso/%:
	nix build .#nixosConfigurations.$().config.system.build.isoImage

PHONY: _git-add-secret-files
_git-add-secret-files:
	@for f in $(SECRET_FILES); do \
		mv $$f $${f%.secret}; \
		git add $${f%.secret}; \
	done

.PHONY: _git-rm-secret-files
_git-rm-secret-files:
	@for f in $(SECRET_FILES); do \
		git rm --cached $${f%.secret}; \
		mv $${f%.secret} $$f; \
	done

.PHONY: switch/%
switch/%: _git-add-secret-files
	-nixos-rebuild switch --flake .#$*
	$(MAKE) SECRET_FILES="$(SECRET_FILES)" _git-rm-secret-files

