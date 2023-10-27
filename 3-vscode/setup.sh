#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~/Library/Application\ Support/Code/User)"

info "Setting up Visual Studio Code..."

substep_info "Installing Visual Studio Code extensions..."
cat extensions | while read extension; do
	code --install-extension "$extension"
done

substep_info "Creating Visual Studio Code folders..."
mkdir -p "$DESTINATION"
mkdir -p "$DESTINATION/snippets"

substep_info "Symlinking Visual Studio Code settings..."
find * -not -name "$(basename ${0})" -type f | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

substep_info "Symlinking Visual Studio Code snippets..."
find snippets/* -type f | while read fn; do
	symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Finished setting up Visual Studio Code"
