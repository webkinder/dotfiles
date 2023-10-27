#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

sudo -v

info "Adding Brew to PATH..."

UNAME_MACHINE="$(/usr/bin/uname -m)"

if [[ "${UNAME_MACHINE}" == "arm64" ]]
then
	# On ARM macOS, this script installs to /opt/homebrew only
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	# On Intel macOS, this script installs to /usr/local only
	echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
	eval "$(/usr/local/bin/brew shellenv)"
fi

info "Installing Brew packages..."
brew update
brew upgrade
brew bundle --no-lock
brew cleanup

echo 'eval "rbenv init - zsh" >/dev/null 2>&1' >> ~/.zshrc
eval "$(rbenv init - zsh)"

echo 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

echo 'export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"

echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/.composer/vendor/bin:$PATH"

success "Finished installing Brew"
