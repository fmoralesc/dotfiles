set fish_greeting

source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
source /etc/grc.fish

alias ls='grc --colour=auto ls --color=always -C'

fundle plugin 'oh-my-fish/plugin-foreign-env'
fundle plugin 'sentriz/fish-pipenv'
fundle plugin 'victante/trish'

fundle init
