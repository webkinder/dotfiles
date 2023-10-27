#! /usr/bin/env sh

DIR=$($(brew --prefix coreutils)/libexec/gnubin/dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$($(brew --prefix coreutils)/libexec/gnubin/realpath -m .)"
DESTINATION="$($(brew --prefix coreutils)/libexec/gnubin/realpath -m ~)"

info "Linking formatting configs..."

find .editorconfig -not -name "$($(brew --prefix coreutils)/libexec/gnubin/basename ${0})" -type f | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

find .prettierrc -not -name "$($(brew --prefix coreutils)/libexec/gnubin/basename ${0})" -type f | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

find .php-cs-fixer.php -not -name "$($(brew --prefix coreutils)/libexec/gnubin/basename ${0})" -type f | while read fn; do
	symlink "$SOURCE/$fn" "$DESTINATION/.vscode/$fn"
done


success "Finished linking formatting configs."
