if status is-interactive
    # Commands to run in interactive sessions can go here
    if not set -q TMUX
        set -g TMUX tmux new-session -d -s s -c "$HOME/"
        eval $TMUX
        tmux attach-session -d -t s
    end
end

# add Rust to path 
set PATH $HOME/.cargo/bin $PATH

# no greeting
set fish_greeting

set -Ux TERM xterm-256color
set -Ux EDITOR nvim

alias ex "exit"
alias cl "clear"
alias cat "bat"
alias neovim "nvim"
alias nv "nvim"
alias cdh "cd ~"
alias cdp "cd ~/projects/"


starship init fish | source
