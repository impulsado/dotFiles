#!/bin/bash

# > Author: @impulsado
# > Date: 31/05/2024

function startCheck() {
    if [[ "$EUID" -eq 0 ]]; then
        echo ""
        echo "DO NOT be root!"
        echo ""
        exit 1
    fi

    ping -c 1 -q google.com >&/dev/null
    if [[ $? != 0 ]]; then
        echo ""
        echo "Must have internet connection!"
        echo ""
        exit 1
    fi

    echo ""
    echo "=============================="
    echo "   Welcome to your new O.S!   "
    echo "=============================="
    echo ""
    echo ""
    read -p "Enter your O.S. username: " username

    if [[ $username == "root" ]]; then
        echo ""
        echo "Please, enter another username!"
        echo ""
    fi

    read -p "Which SHELL do you prefere BASH [B] or ZSH [Z]? " -e -i "Z" usr_op_shell
    read -p "Do you want to install & configure TMUX? [Y/n] " -e -i "Y" usr_op_tmux
    read -p "Do you want to install & configure NEOVIM? [Y/n] " -e -i "Y" usr_op_neovim
    echo ""
    read -p "Do you want to proceed? [Y/n] " -e -i "Y" usr_op

    if [[ $usr_op != "Y" ]]; then
        echo ""
        echo "See you soon!"
        echo ""
        exit 2
    fi
}

function initialConfig() {
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install -y xclip bat zsh zsh-autosuggestions zsh-syntax-highlighting wget nmap tcpdump curl python3 pip
    rm -d ~/{Documents,Music,Pictures,Public,Templates,Videos}
    mkdir ~/{Scripts}
    sudo dpkg -i ~/dotFiles/assets/lsd.deb
    mkdir ~/tmp
    #echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    #timedatectl set-timezone Europe/Madrid
}

function addZSH() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
        echo "Could not install Oh My Zsh" >/dev/stderr
        exit 1
    }

    curl -sS https://starship.rs/install.sh | sh
    cp ~/dotFiles/assets/starship.toml ~/.config/

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    cat ~/dotFiles/assets/.zshrc >> ~/.zshrc
    sed -i 's/plugins=(git)/plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

    # INSTALL HACK FONT
    sudo unzip -o ~/dotFiles/assets/Hack.zip -d /usr/share/fonts/
}

function addBASH() {
    cat <<EOF >> ~/.bashrc
alias ls='ls -lh --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias cat='batcat'
alias update='sudo apt update -y && sudo apt upgrade -y'
alias poweroff='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
alias apt='sudo apt'
alias mkt='mkdir'
alias tmux='tmux -u'
alias myip='curl ifconfig.co/'
alias copy='xcopy -sel c <'
alias ipa='ip -c a'

# === OTHERS ===
export PATH=$PATH:~/Scripts/
PS1='\[\e[0;38;5;46m\]\u\[\e[0;38;5;46m\]@\[\e[0;38;5;46m\]\H \[\e[0m\][\[\e[0m\]\w\[\e[0m\]] \[\e[0;93m\]\$ \[\e[0m\]'
EOF
}

function confNVIM() {
    sudo apt install -y fuse
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
    git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
    usr/bin/nvim +PackerSync
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function confTMUX() {
    sudo apt install -y tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cat <<EOF > ~/.tmux.conf
# === MAIN ===
# Reload config file
unbind r
bind r source-file ~/.tmux.conf
# Double prefix to change pane
unbind C-b
bind C-b select-pane -t :.+
# Split pane
bind h split-window -v
bind v split-window -h
# Mouse friendly
set -g mouse on
unbind -n MouseDown3Pane
# Start index at number 1
set -g base-index 1
# Modern colors
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",alacritty:Tc"
# Set scroll history to 100,000 lines
set-option -g history-limit 100000
# Window automatically rename 
set-option -g automatic-rename on
# Quiet
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
set -g monitor-activity off
set -g bell-action none

# === DESIGN ===
# Remove extra information
set-option -g status-right ''
# Centre window names
set-option -g status-justify centre
# Default window title colors
set-window-option -g window-status-style "fg=white,bg=default"
# Active window title colors
set-window-option -g window-status-current-style "fg=red,bg=default"
# Status bar colors
set-option -g status-style "fg=green,bg=#292929"
# Pane border
set-option -g pane-border-style "fg=#292929"
set-option -g pane-active-border-style "fg=white"
EOF
    #cp ~/dotFiles/assets/tmux.conf ~/.tmux.conf
}

function downloadRepos() {
    git clone https://github.com/Flangvik/SharpCollection /opt/SharpCollection
    git clone https://github.com/danielmiessler/SecLists /opt/SecLists
    git clone https://github.com/impulsado/wannaNotes.git ~/wannaNotes
}


function secureALL() {
    cp ~/dotFiles/assets/secureOS.sh ~
    chmod u+x ~/secureOS.sh

    cp ~/dotFiles/assets/secureSSH.sh ~
    chmod u+x ~/secureSSH.sh

    cp ~/dotFiles/assets/confFirefox.sh ~
    chmod u+x ~/confFirefox.sh
}

function printEnd() {
    clear
    cp ~/dotFiles/assets/README.md ~
    yes | rm -rf ~/tmp # Delete tmp files
    echo ""
    echo ""
    echo "  1. Read this file:   cat ~/README.md"
    echo ""
    echo "  2. Log Out to apply the changes"
    echo ""
    echo ""
    echo "> Author: impulsado"
}

# === MAIN ===

startCheck

if [[ $usr_op == "Y" ]]; then
    initialConfig
    if [[ $usr_op_shell == "B" ]]; then
        addBASH
    else
        addZSH
    fi
    if [[ $usr_op_tmux == "Y"]]; then
        confTMUX
    fi
    if [[ $usr_op_neovim == "Y"]]; then
        confNVIM
    fi
    secureALL
    sleep 1
    printEnd
fi