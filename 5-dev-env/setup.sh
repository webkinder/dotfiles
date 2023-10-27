#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

sudo -v

SOURCE="$(realpath -m ~/.config/valet/Certificates)"
DESTINATION="$(realpath -m ~)"

info "Setting up Development Environment..."

substep_info "Setting up Valet..."
brew services start mariadb
brew services start mailhog

composer global require laravel/valet

valet install
symlink "$SOURCE" "$DESTINATION/.localhost-ssl"

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

mkdir -p ~/repos/valet
valet park ~/repos/valet

cd $(brew --prefix phpmyadmin)/share/phpmyadmin
valet link phpmyadmin
valet secure phpmyadmin
cd "$DIR"

sudo valet trust

substep_info "Setting up Ruby..."
fnm install 14
fnm use 14
fnm default 14

substep_info "Setting up Ruby..."
rbenv install 2.6.10
rbenv global 2.6.10

substep_info "Setting up Wordmove..."
gem install wordmove
gem install ed25519
gem install bcrypt_pbkdf

substep_info "Setting up Vim..."


find . -name ".vim*" | while read fn; do
    fn=$(basename $fn)
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh


substep_info "Setting up .npmrc..."
symlink "$SOURCE/.npmrc" "$DESTINATION/.npmrc"

substep_info "Setting up Proxy Driver for Valet..."
symlink "$SOURCE/WordPressProxyValetDriver.php" "$DESTINATION/.config/valet/Drivers/WordPressProxyValetDriver.php"

success "Finished setting up Development Environment."
