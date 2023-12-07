#! /usr/bin/env sh

DIR=$($(brew --prefix coreutils)/libexec/gnubin/dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

info "Configuring ssh..."

mkdir -p ~/.ssh
touch ~/.ssh/config

if [ ! -f ~/.ssh/id_ed25519 ]; then
	read -p "Enter your email address: " email
	ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -q -N ""
fi

success "Finished configuring ssh."
