function vup --description 'Change PHP Version with Laravel Valet'
	# Check if $argv is set
	if not test "$argv"
		error "Usage: vup <site>"
		return 1
	end

	valet use php@$argv
	composer global update
end
