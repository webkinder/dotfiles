function coloredEcho
	set -l exp $argv[1]
	set -l color $argv[2]
	set -l arrow $argv[3]
	switch $color
		case black
			set color 0
		case red
			set color 1
		case green
			set color 2
		case yellow
			set color 3
		case blue
			set color 4
		case magenta
			set color 5
		case cyan
			set color 6
		case white
			set color 7
		case '*'
			set color 7
	end
	command tput bold
	command tput setaf $color
	echo "$arrow $exp"
	command tput sgr0
end
