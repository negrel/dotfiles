SHELL = bash
SECRET_FILES := $(shell find secrets -type f)

.PHONY: build-iso/%
build-iso/%:
	nix build .#nixosConfigurations.$().config.system.build.isoImage

PHONY: _git-add-secret-files
_git-add-secret-files:
	@for f in $(SECRET_FILES); do \
		git add -f $${f}; \
	done

.PHONY: _git-rm-secret-files
_git-rm-secret-files:
	@for f in $(SECRET_FILES); do \
		git rm --cached $${f}; \
	done

.PHONY: switch/%
switch/%: _git-add-secret-files
	-nixos-rebuild switch --flake .#$* --show-trace
	$(MAKE) SECRET_FILES="$(SECRET_FILES)" _git-rm-secret-files

.PHONY: build/%
build/%: _git-add-secret-files
	-nixos-rebuild build --flake .#$* --show-trace
	$(MAKE) SECRET_FILES="$(SECRET_FILES)" _git-rm-secret-files

.PHONY: dry-build/%
dry-build/%: _git-add-secret-files
	-nixos-rebuild dry-build --flake .#$* --show-trace
	$(MAKE) SECRET_FILES="$(SECRET_FILES)" _git-rm-secret-files
