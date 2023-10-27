#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Configuring git..."

find . -name ".git*" | while read fn; do
    fn=$(basename $fn)
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

# Request input for gitconfig user.name and user.email
read -p "Enter your git user.name: " name
read -p "Enter your git user.email: " email

# add user.name and user.email to gitconfig
git config --global user.name "$name"
git config --global user.email "$email"

success "Finished configuring git."
