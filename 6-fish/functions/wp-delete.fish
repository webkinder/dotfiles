function wp-delete --description 'Delete a valet WordPress installation'
	# Check if $argv is set
	if not test "$argv"
		error "Usage: wp-delete <site>"
		return 1
	end

	# Check if $argv is a valid site
	set -l site_path (find ~/repos/valet -mindepth 1 -maxdepth 1 -type d -name "*$argv*")
	if not test "$site_path"
		error "Error: $argv is not a valid site"
		return 1
	end

	# Check if $argv is a valid WordPress installation
	set -l wp_path (find "$site_path" -mindepth 1 -maxdepth 1 -type d -name "wp-*")
	if not test "$wp_path"
		error "Error: $argv is not a valid WordPress installation"
		return 1
	end

	info "Deleting WordPress installation $argv"

	# Get DB_NAME from wp-config.php
	set -l db_name (grep DB_NAME "$site_path/wp-config.php" | cut -d "'" -f 4)

	# Create query to drop database
	set -l query "DROP DATABASE IF EXISTS `$db_name`;"

	# Drop database
	substep_info "Deleting database $db_name"
	mariadb -e "$query"

	# Check if DB was deleted successfully
	if test "$status" -ne 0
		error "Error: Database $db_name could not be deleted"
		return 1
	else
		substep_success "Database $db_name deleted successfully"
	end

	# Remove SSL
	substep_info "Removing SSL"
	valet unsecure "$argv"

	# Check if SSL was removed successfully
	if test "$status" -ne 0
		error "Error: SSL could not be removed"
		return 1
	else
		substep_success "SSL removed successfully"
	end

	# Delete site
	substep_info "Deleting site $argv"
	rm -rf "$site_path"

	# Check if site was deleted successfully
	if test "$status" -ne 0
		error "Error: Site $argv could not be deleted"
		return 1
	else
		substep_success "Site $argv deleted successfully"
	end

	success "WordPress installation $argv was deleted successfully"
end
