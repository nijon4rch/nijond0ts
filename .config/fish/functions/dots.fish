function dots --wraps='git --git-dir=$HOME/.nijond0ts.git/ --work-tree=$HOME' --description 'git alias for dotfiles management'
	git --git-dir=$HOME/.nijond0ts.git/ --work-tree=$HOME $argv
end
