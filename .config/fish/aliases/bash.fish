alias c "clear"
alias cl "clear; ls -l"
alias lsa "ls -alsh --color=always"
alias x "exit"
alias reloadfish "source ~/.config/fish/config.fish"
alias s3 "s3cmd"
#alias vim "nvim"

function gpass
	set -l length $argv[1]
	if test -z "$argv[1]"
		set length 64
	end
	pwgen -cny -B -1 -r \'\<\>\"\@\?\^\&\*\(\)\`\:\~\?\;\:\[\]\{\}\.\,\\\/\|\%\#\+\!\=\$\! $length
end

alias rlkp "dig +noall +answer"
alias wn1 "watch -n 1"
alias yeet "rm -rf"
#alias cat "batcat -p"
#alias bat "batcat"
alias cpy 'xclip -selection clipboard'

alias jrny "bin/jrny"
#alias proj "cd ~/Projects"
#alias wproj "cd ~/Projects/work"

function proj
	if test -z "$argv[1]"
		cd ~/Projects/
		return
	end

	cd ~/Projects/$argv[1]
end
