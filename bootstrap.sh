#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. scripts/functions.sh

info "Prompting for sudo password..."

if sudo -v; then
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    success "Sudo credentials updated."
else
    error "Failed to obtain sudo credentials."
fi

info "Installing Rosetta..."
sudo softwareupdate --install-rosetta

./1-homebrew/setup.sh

find * -name "setup.sh" -not -wholename "1-homebrew*" -print0 | xargs -0 -I {} bash {}

info "Configuring git..."

# Request input for gitconfig user.name and user.email
read -p "Enter your git user.name: " name
read -p "Enter your git user.email: " email

# add user.name and user.email to gitconfig
git config --global user.name "$name"
git config --global user.email "$email"

info "Configuring ssh..."

mkdir -p ~/.ssh
touch ~/.ssh/config

if [ ! -f ~/.ssh/id_ed25519 ]; then
	read -p "Enter your email address: " email
	ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -q -N ""
fi

info "Configure user bin folder..."

mkdir -p ~/bin
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc

success "Finished installing Dotfiles"
