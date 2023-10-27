#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Linking formatting configs..."

find .editorconfig -not -name "$(basename ${0})" -type f | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

find .prettierrc -not -name "$(basename ${0})" -type f | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

find .php-cs-fixer.php -not -name "$(basename ${0})" -type f | while read fn; do
	symlink "$SOURCE/$fn" "$DESTINATION/.vscode/$fn"
done


success "Finished linking formatting configs."
