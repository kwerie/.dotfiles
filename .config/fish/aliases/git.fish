alias ga "git add -A"
alias gags "git add -A; git status;"
alias gpsu "git push --set-upstream origin"
alias gs "git status"
alias gco "git checkout"
alias gcm "git commit -m"
alias gd "git diff"
alias gpl "git pull"
alias gplom "git pull origin master"
alias gcb "git branch --show-current"
alias gbra "git branch -a"
alias gp "git push"
#alias gyolo "git commit -m (curl -sL https://whatthecommit.com/index.txt)"

function grdb
	git remote show origin | sed -n '/HEAD branch/s/.*: //p'
end

function gbrl
	if test -z "$argv[1]"
		echo "You must provide a (partial) branchname"
		return 0
	end

	git branch -a | grep $argv
end

function greset
	set -l db (grdb)
	git checkout $db
	git fetch --all --prune
	git pull
end
