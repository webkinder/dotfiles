#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

sudo -v

info "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
echo 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
echo 'export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.zshrc
echo 'fnm env --use-on-cd' >> ~/.zshrc

source ~/.zshrc

success "Finished installing Brew"

# TODO: Documentation der commands und functions
