set	-gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
	--color=bg:#20000f,fg:#ff6996,hl:#ffdd59 \
	--color=bg+:#760023,fg+:#ffffff,hl+:#ffe996 \
	--color=info:#ff7fa5,prompt:#f2477a,pointer:#ff0055 \
	--color=marker:#8eff69,spinner:#ffbbcf,header:#a5979b \
	--color=border:#ff96b5 \
	--border=rounded --border-label=\"🫧fuzzy🫧\" --border-label-pos=0 --preview-window=border-rounded \
	--prompt=\"> \" --marker=\"▶\" --pointer=\"👉\" --separator=\"─\" \
	--scrollbar=\"│\" --layout=reverse --height=~75% -m \
	--style	full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"
set -gx MANPAGER "nvim +Man!"
set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim
set -gx TERM kitty
