.EXPORT_ALL_VARIABLES:

-include nixos/hosts/${HOSTNAME}/host.env

# Fix 'No space left on device'
TMPDIR ?= $(shell mktemp -d -p /data/tmp)

# Ensures that a variable is defined and non-empty
define assert-variable-set
	@$(if $($(1)),,$(error $(1) not defined in $(@)))
endef

all: help

help: ## This help
	@find . -name Makefile -o -name "*.mk" | xargs -n1 grep -hE '^[a-z0-9\-]+:.* ##' | sed 's/\: .*##/:/g' | sort | column  -ts':'

bootstrap: ## Bootstrap (volumes creation and host ssh creation if not exists)
	$(call assert-variable-set,SYSTEM)
	$(call assert-variable-set,HOSTNAME)
	$(call assert-variable-set,DISK)
	@./.install/bootstrap.sh

mounts: ## Mount or remount all nix volumes
	$(call assert-variable-set,DISK)
	$(call assert-variable-set,HOSTNAME)

	@umount -R /mnt 2>/dev/null || true

	@zpool import -f ${HOSTNAME} 2>/dev/null || true 
	@zfs load-key ${HOSTNAME}/private 2>/dev/null || true

	@mount -t zfs ${HOSTNAME}/private/root /mnt
	@mkdir -p /mnt/{boot,nix,data,persist/host,persist/user}
	@mount "${DISK}-part1" /mnt/boot
	@mount -t zfs ${HOSTNAME}/public/nix /mnt/nix
	@mount -t zfs ${HOSTNAME}/private/data /mnt/data
	@mount -t zfs ${HOSTNAME}/private/persist/host /mnt/persist/host
	@mount -t zfs ${HOSTNAME}/private/persist/user /mnt/persist/user

install-nixos: ## Install nixos
	$(call assert-variable-set,USERNAME)
	$(call assert-variable-set,HOSTNAME)
	@nixos-install --no-root-passwd --flake ".#${HOSTNAME}"

update-nixos: ## Update nixos installation
	$(call assert-variable-set,HOSTNAME)
	@sudo nixos-rebuild switch --flake ".#${HOSTNAME}"

update-home: ## Update home installation
	$(call assert-variable-set,USERNAME)
	@home-manager switch --flake ".#${USERNAME}_on_${HOSTNAME}"

fmt-all: ## Format all .nix files
	@nix-shell -p nixpkgs-fmt --run 'nixpkgs-fmt .'

fmt-file: ## Format <FILE> 
	@nix-shell -p nixpkgs-fmt --run 'nixpkgs-fmt ${FILE}'