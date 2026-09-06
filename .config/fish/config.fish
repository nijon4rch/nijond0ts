if status is-interactive
    corrfetch
end
function fish_user_key_bindings
	bind ctrl-backspace backward-kill-word
end
zoxide init fish | source
