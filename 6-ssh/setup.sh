#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~/.ssh)"

info "Configuring ssh..."

mkdir -p ~/.ssh
touch ~/.ssh/config

if [ ! -f ~/.ssh/id_rsa ]; then
	read -p "Enter your email address: " email
	ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -q -N ""
fi

success "Finished configuring ssh."
