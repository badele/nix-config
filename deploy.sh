#!/usr/bin/env bash

set -e

function usage() {
    echo 'Usage: username=$USERNAME hostname=$HOST ./deploy.sh <home|system|all'
    exit 1
}

mode=$1
has_error=0
function check_var() {
    var_name="${1}"
    if [ -z "${!var_name}" ]; then
        echo "Please export '\$$1' variable"
        has_error=1
    fi
}

# Check variables
checks="username hostname"
for check in $checks; do check_var "${check}"; done
[ $has_error -eq 1 ] && exit 1


case $mode in

  system)
    sudo nixos-rebuild switch --flake ".#${hostname}"
    ;;

  home)
    home-manager switch --flake ".#${username}_on_${hostname}"
    ;;

  all)
    sudo nixos-rebuild switch --flake ".#${hostname}"
    home-manager switch --flake ".#${username}_on_${hostname}"
    ;;

  *)
    usage
    ;;
esac

# if [ $1 = "all"]
# sudo nixos-rebuild switch --flake ".#${hostname}"
# home-manager switch --flake ".#${username}_on_${hostname}"
