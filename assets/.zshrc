# Path to your oh-my-zsh installation.
export ZSH="/home/impu/.oh-my-zsh"

# === THEME ===
ZSH_THEME="powerlevel10k/powerlevel10k"

# === PLUGINS ===
plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# === ALIAS ===
alias ls='lsd -lh --color=auto'
alias ll='lsd -la --color=auto'
alias grep='grep --color=auto'
alias cat='batcat'
alias update='sudo apt update -y && sudo apt upgrade -y'
alias poweroff='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
alias apt='sudo apt'
alias mkt='mkdir'
alias tmux='tmux -u'
alias vim='nvim'
alias myip='curl ifconfig.co/'
alias copy='xcopy -sel c <'

# === OTHERS ===
export PATH=$PATH:/home/$username/Scripts/
eval "$(starship init zsh)"