function wml --description 'Use Wordmove to pull a WordPress site from a remote server'
	if test "$argv"
		wordmove pull --all -e "$argv"
	else
		wordmove pull --all
	end
end
