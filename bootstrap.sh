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

success "Finished installing Dotfiles"
