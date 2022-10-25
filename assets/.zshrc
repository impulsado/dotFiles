# === MAIN ===
export ZSH="~/.oh-my-zsh" # Path to your oh-my-zsh installation.

# === THEME ===
ZSH_THEME="robbyrussell"

# === HISTORY ===
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

# === PLUGINS ===
plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# === ALIAS ===
alias ls='lsd -lh --color=auto'
alias la='lsd -la --color=auto'
alias grep='grep --color=auto'
alias cat='batcat'
alias update='sudo apt update -y && sudo apt upgrade -y'
alias poweroff='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
alias apt='sudo apt'
alias mkt='mkdir'
alias tmux='tmux -u'
alias nvim='~/Programs/nvim'
alias myip='curl ifconfig.co/'
alias copy='xcopy -sel c <'
alias ipa='ip -c a'

# === FUNCTIONS ===
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

function c() { 
    curl "http://cheat.sh/$1" 
}

# === OTHERS ===
export PATH=$PATH:~/Scripts/
eval "$(starship init zsh)"