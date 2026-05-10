abbr --add sy sybau
abbr --add gy gyatt
abbr --add oh ohio
abbr --add cd z
abbr --add h history
abbr --add hs "history | fzf --preview '' --bind 'focus:transform-header:''' | wl-copy"
abbr --add zq "zoxide query --interactive | wl-copy"
abbr --add f "fzf"
abbr --add fnr "find . -maxdepth 1 | fzf"
abbr --add fcd 'z $(find -type d | fzf)'
abbr --add fopen 'xdg-open $(find -type f | fzf)'
abbr --add fdel "rm -rf (find . -maxdepth 1 | fzf)"
abbr --add psg "ps aux | grep -i"
abbr --add iwsc "iwctl station wlan0 scan"
abbr --add iwget "iwctl station wlan0 get-networks"
abbr --add iwsh "iwctl station wlan0 show"
abbr --add iwcon "iwctl station wlan0 connect"
abbr --add :q exit
